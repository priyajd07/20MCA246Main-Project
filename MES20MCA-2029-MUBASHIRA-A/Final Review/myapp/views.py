from ast import Pass
from distutils.log import error
from itertools import count
from msilib.schema import Class
from multiprocessing import context
from re import template
from django.shortcuts import render,redirect
from django.views.generic import *
#from myapp.models import UserRegisterModel
from myapp.forms import *
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.forms import AuthenticationForm
from myapp.models import *
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http.response import JsonResponse
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from .models import User, Message
from django.db.models import Q
import json
from django.contrib import messages
from django.http import HttpResponse, JsonResponse
from django.db.models import Count

# Create your views here.
class index(View):
	template_name='index.html'
	def get(self,request):
		qn_data=QuestionModel.objects.all().order_by('-created_on')
		trending=AnswerModel.objects.annotate(upvote_count=Count('up_vote')).order_by("upvote_count")
		context={'data':qn_data, 'trending':trending}
		return render(request,self.template_name,context)
    

def contact(request):
    return render(request,'contact.html')

class AdminIndex(View):
	template_name='AdminIndex.html'
	def get(self,request):
		user=User.objects.all().count()
		pending=AnswerModel.objects.filter(approval_status='pending').count()
		qns=QuestionModel.objects.all().count()
		return render(request,self.template_name, {'pending':pending , 'user':user-1 , 'qns':qns})

class RegisterView(View):
	template_name='register.html'

	def get(self,request):
		context={'form':UserRegisterForm}
		return render(request,self.template_name,context)

	def post(self,request):
		username=request.POST.get('username')
		first_name=request.POST.get('first_name')
		last_name=request.POST.get('last_name')
		password=request.POST.get('password1')
		email=request.POST.get('email')
		user=User.objects.create(
			username=username,
			first_name=first_name ,
			last_name=last_name,
			email=email, 
			password=password ,
			is_staff=True
			)
		user.set_password(password)
		user.save()
		user_login=authenticate(username=username,password=password)
		login(request,user_login)
		return redirect('index')

"""def adduser(request):
	if request.method=="POST":
		form=UserRegisterForm(request.POST)
		extend_form=ExtendedUserForm(request.POST)

		if form.is_valid() and extend_form.is_valid():
			user=form.save()
			extended_profile=extend_form.save(commit=False)
			extended_profile.user=user
			extended_profile.save()

			username_var=form.cleaned_data.get('username')
			password_var=form.cleaned_data.get('password1')
			user=authenticate(username=username_var,password=password_var)

			login(request,user)
			return redirect ('index')

	else:
		form=UserRegisterForm(request.POST)
		extend_form=ExtendedUserForm(request.POST)

	context={"form":form,"extend_form":extend_form}
	return render(request,'adduser.html',context)"""

class UserLogin(View):
	def get(self,request):
		form=AuthenticationForm()
		context={'form':form}
		return render(request,'login.html',context)

	def post(self,request):
		username=request.POST.get('username')
		password=request.POST.get('password')
		user=authenticate(username=username,password=password)
		if user is not None :
			login(request,user)
			if user.is_superuser == True and user.is_staff == True:
				return redirect('dash')
			if user.is_staff == True and user.is_superuser == False:
				return redirect('index')
			if user.is_staff == False and user.is_superuser == False:
				return redirect ('index')
			
		else:
			messages.error(request,'username or password not correct')
            # return redirect('login')
			form=AuthenticationForm()
			context={'form':form}
			return render(request,'login.html',context)

def logout_view(request):
    logout(request)
    return redirect('index')

class CategoryView(View):
	template_name ='addcategory.html'
	def get(self,request):
		context={'form':CategoryForm}
		return render(request,self.template_name,context)

	def post(self,request):
		name=request.POST.get('name')
		user=CategoryModel.objects.create(
			name=name,
			)
		user.save()
		return redirect('dash')

class QuestionView(View):
	template_name ='addqn.html'
	# def get_context_data(self,**kwargs):
	# 	context=super().get_context_data(**kwargs)
	# 	categories=CategoryModel.objects.all()
	# 	context['categories']=categories
	# 	return context

	def get(self,request):
		categories = CategoryModel.objects.all()
		context={
			'form':QuestionForm,
			'categories': categories
			}

		return render(request,self.template_name,context=context)

	def post(self,request):
		user=request.user
		qn=request.POST.get('qn')
		group_name=CategoryModel.objects.get(id=request.POST.get('group'))
		group=group_name
		pic=request.FILES.get('pic')
		user=QuestionModel.objects.create(
			user=user,
			qn=qn,
			group=group,
			pic=pic,
			)
		user.save()
		return redirect('qnlist')

	

class AnswerView(View):
	template_name ='addans.html'

	def get(self,request,pk):
		qn=QuestionModel.objects.get(id=pk)
		context={'form':AnswerForm, 'data':qn}
		return render(request,self.template_name,context)

	def post(self,request,pk):
		qn_select=QuestionModel.objects.get(id=pk)
		user=request.user
		answer=request.POST.get('answer')
		pic=request.FILES.get('pic')
		AnswerModel.objects.create(
			user=user,
			qn=qn_select,
			answer=answer,
			pic=pic,
			)
		return redirect('index')

class QuestionList(View):
	template_name='qnlist.html'
	def get(self,request):
		qn_data=QuestionModel.objects.all().order_by('-created_on')
		context={'data':qn_data}
		return render(request,self.template_name,context)

class UserList(View):
	template_name='userlist.html'
	def get(self,request):
		user=User.objects.all()
		context={'data':user}
		return render(request,self.template_name,context)

class Answers(View):
	template_name='answers.html'
	def get(self,request,pk):
		data=QuestionModel.objects.get(id=pk)
		answerdata=AnswerModel.objects.filter(qn=data,approval_status='approval')
		return render(request,self.template_name,{'answerdata':answerdata,'data':data})

class CategoryList(View):
	template_name='categorylist.html'
	def get(self,request,pk):
		data=CategoryModel.objects.get(id=pk)
		answerdata=QuestionModel.objects.filter(group=data)
		return render(request,self.template_name,{'answerdata':answerdata,'data':data})

class PendingList(View):
	template_name='pendinglist.html'
	def get(self,request):
		data=AnswerModel.objects.filter(approval_status='pending')
		return render(request,self.template_name,{'data':data})

class updatependinganswer(UpdateView):
	template_name='pendingupdate.html'
	model=AnswerModel
	fields=["approval_status"]
	success_url='/pendinglist/'

# chat
@login_required
def chatroom(request, pk:int):
    other_user = get_object_or_404(User, pk=pk)
    messages = Message.objects.filter(
        Q(receiver=request.user, sender=other_user)
    )
    messages.update(seen=True)
    messages = messages | Message.objects.filter(Q(receiver=other_user, sender=request.user))
    return render(request, "chatroom.html", {"other_user": other_user, 'users': User.objects.all(), "user_messages": messages})


@login_required
def ajax_load_messages(request, pk):
    other_user = get_object_or_404(User, pk=pk)
    messages = Message.objects.filter(seen=False).filter(Q(receiver=request.user, sender=other_user))
    # print("messages")

    message_list = [{
        "sender": message.sender.username,
        "message": message.message,
        "sent": message.sender == request.user,

    } for message in messages]
    messages.update(seen=True)
    
    if request.method == "POST":
        message = json.loads(request.body)
        
        m = Message.objects.create(receiver=other_user, sender=request.user, message=message)
        message_list.append({
            "sender": request.user.username,
            # "username": request.user.username,
            "message": m.message,
            "sent": True,
        })
    print(message_list)
    return JsonResponse(message_list, safe=False)

# Save Upvote
def save_upvote(request):
    if request.method=='POST':
        answerid=request.POST['answerid']
        answer=AnswerModel.objects.get(pk=answerid)
        user=request.user
        check=UpVote.objects.filter(answer=answer,user=user).count()
        opp=DownVote.objects.filter(answer=answer,user=user).count()
        if opp > 0 or check > 0:
            return JsonResponse({'bool':False})
        else:
            UpVote.objects.create(
                answer=answer,
                user=user
            )
            return JsonResponse({'bool':True})

# Save Downvote
def save_downvote(request):
    if request.method=='POST':
        answerid=request.POST['answerid']
        answer=AnswerModel.objects.get(pk=answerid)
        user=request.user
        check=DownVote.objects.filter(answer=answer,user=user).count()
        opp=UpVote.objects.filter(answer=answer,user=user).count()
        if opp > 0 or check > 0:
            return JsonResponse({'bool':False})
        else:
            DownVote.objects.create(
                answer=answer,
                user=user
            )
            return JsonResponse({'bool':True})
#comment
def save_comment(request):
    if request.method=='POST':
        comment=request.POST['comment']
        answerid=request.POST['answerid']
        answer=AnswerModel.objects.get(pk=answerid)
        user=request.user
        Comment.objects.create(
            answer=answer,
            comment=comment,
            user=user
        )
        return JsonResponse({'bool':True})

def search(request):
	if request.method=='POST':
		search=request.POST.get('search')
		status=QuestionModel.objects.filter(qn__contains=search)
		if status==None:
			Pass
		else:
			return render(request,'index.html',{'data':status})