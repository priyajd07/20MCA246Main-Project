from django.http import HttpResponse
from django.shortcuts import render
from user.models import User
from post.models import Post
from comment.models import Comment
from friendrequest.models import Friendrequest
from django.db.models import Q
from django.core.files.storage import FileSystemStorage
import datetime
from friend.models import Friend

def admin(request):
    return render(request, 'temp/admin.html')

def adminform(request):
    return render(request, 'temp/admin_form.html')

def counsellor(request):
    return render(request, 'temp/counsellor.html')

def counsellorform(request):
    return render(request, 'temp/counsellor_form.html')

def user(request):
    eid = str(request.session["u_id"])
    o = User.objects.get(u_id=eid)
    context = {
        'details': o
    }
    print(eid)
    return render(request, 'temp/user.html',context)

def userform(request):
    return render(request, 'temp/user_form.html')

def home(request):
    return render(request, 'temp/home.html')

def homeform(request):
    return render(request, 'temp/homeform.html')

def viewP(request):
    eid = str(request.session["u_id"])
    pobj = Post.objects.filter(status="open")
    context = {
        'details': pobj
    }
    return render(request,'temp/viewPost.html', context)

def viewC(request,idd):
    obj = Post.objects.get(p_id=idd)
    cobj = Comment.objects.filter(p_id=obj.p_id)
    context = {
        'details': cobj,
        'post': obj,
    }

    return render(request, 'temp/postDetails.html', context)


def createC(request,idd):
    eid = str(request.session["u_id"])
    o = Post.objects.get(p_id=idd)
    if request.method == "POST":
        eid = str(request.session["u_id"])
        comObj = Comment()
        comObj.com_content = request.POST.get('msg')

        comObj.u_id = o.u_id
        comObj.p_id = o.p_id
        comObj.f_id = eid

        comObj.com_date = datetime.date.today()
        comObj.com_time = datetime.datetime.now()
        comObj.reply = "NULL"
        comObj.status = "Pending"
        comObj.save()
    return render(request, 'temp/postDetails.html')

def viewProfile(request,idd):
    ob = User.objects.get(u_id=idd)
    context = {
        'details': ob
    }
    return render(request, 'temp/viewProfile.html', context)
def updateProfile(request,idd):
    eid = str(request.session["u_id"])
    ob = User.objects.filter(u_id=idd)
    context = {
        'details': ob
    }
    return render(request, 'temp/updatePro.html', context)

def myProfile(request):
    eid = str(request.session["u_id"])
    ob = User.objects.filter(u_id=eid)
    context = {
        'details': ob
    }
    return render(request, 'temp/myProfile.html', context)

def update(request,idd):
    EID = str(request.session["u_id"])
    obj = User.objects.get(u_id=EID)
    fobj = Friend.objects.get(f_id=EID)
    context = {
        'det': obj
    }
    if request.method == "POST":
        # obj = User.objects.get(u_id=EID)
        obj.u_name = request.POST.get('upname')
        obj.u_mobile = request.POST.get('upmob')
        obj.u_mail = request.POST.get('upmail')
        obj.u_gender = request.POST.get('upgen')
        obj.u_dob = request.POST.get('updob')
        obj.u_location = request.POST.get('uploc')
        # myfile = request.FILES["up_pic"]
        # fs = FileSystemStorage()
        # filename = fs.save(myfile.name, myfile)
        # obj.u_profile_pic = myfile.name

        # uobj.u_status = "Active"
        # uobj.u_uname = request.POST.get('uuname')
        # uobj.u_pass = request.POST.get('upass')

        fobj.f_name = request.POST.get('upname')
        fobj.f_mobile = request.POST.get('upmob')
        fobj.f_mail = request.POST.get('upmail')
        fobj.f_gender = request.POST.get('upgen')
        fobj.f_dob = request.POST.get('updob')
        fobj.f_location = request.POST.get('uploc')
        fobj.save()
        obj.save()
        return myProfile(request)
    return render(request, 'temp/updatePro.html', context)
