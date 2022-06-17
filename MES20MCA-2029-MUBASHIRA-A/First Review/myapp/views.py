from msilib.schema import Class
from multiprocessing import context
from re import template
from django.shortcuts import render,redirect
from django.views.generic import TemplateView,View
#from myapp.models import UserRegisterModel
from myapp.forms import *
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.forms import AuthenticationForm
from myapp.models import *
# Create your views here.
def index(request):
    return render(request,'index.html')

def contact(request):
    return render(request,'contact.html')

def adminindex(request):
    return render(request,'Adminindex.html')

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
				return redirect('index')
			if user.is_staff == True and user.is_superuser == False:
				return redirect('index')
			if user.is_staff == False and user.is_superuser == False:
				return redirect ('index')
		else:
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
		return redirect('addcategory')

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
		# approval_status=request.POST.get('approval_status')
		# up_vote=request.POST.get('up_vote')
		# down_vote=request.POST.get('down_vote')
		AnswerModel.objects.create(
			user=user,
			qn=qn_select,
			answer=answer,
			pic=pic,
			# approval_status=approval_status,
			# up_vote=up_vote,
			# down_vote=down_vote
			)
		return redirect('anslist')

class QuestionList(View):
	template_name='qnlist.html'
	def get(self,request):
		qn_data=QuestionModel.objects.all()
		context={'data':qn_data}
		return render(request,self.template_name,context)

class AnswerList(View):
	template_name='anslist.html'
	def get(self,request):
		ans_data=AnswerModel.objects.all()
		context={'data':ans_data}
		return render(request,self.template_name,context)

class Answers(View):
	template_name='answers.html'
	def get(self,request,pk):
		data=QuestionModel.objects.get(id=pk)
		answerdata=AnswerModel.objects.filter(qn=data)
		
		print(answerdata)
		return render(request,self.template_name,{'answerdata':answerdata})