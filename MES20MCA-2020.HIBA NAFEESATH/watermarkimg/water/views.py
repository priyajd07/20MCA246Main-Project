from django.shortcuts import render,redirect
from .models import registration
from .forms import registerform
from django.core.files.storage import FileSystemStorage
import cv2
import numpy as np

# Create your views here.
def index(request):
    return render(request,'index.html')
def login(request):
    return render(request,'login.html')
def home(request):
    id=request.session['id']
    username=request.session['username']
    email=request.session['email']
    return render(request,'home.html',{'id':id,'username':username}) 
def thanku(request):
    return render(request,'thanku.html')



def log(request):
    
    if request.method=="POST":
        username=request.POST.get('username')
        password=request.POST.get('password')
        print('username')
        print(username)
        print('password')
        print(password)
        cr=registration.objects.filter(username=username,password=password)
        if cr:
           user = registration.objects.get(username=username,password=password)

           id=user.id
           print('id',id)

           username=user.username
           print('username',username)
           email=user.email
           print('email',email)

           request.session['id']=id
           request.session['username']=username
           request.session['email']=email
           
           
           

          

        
           return redirect('home')
        else:
           return render(request,'login.html')
    else:
        return render(request,'register.html')






def register(request):
    if request.method=="POST":
        firstname=request.POST.get('firstname')
        lastname=request.POST.get('lastname')
        email=request.POST.get('email')
        username=request.POST.get('username')
        password=request.POST.get('password')
        phone=request.POST.get('phone')

        registration(firstname=firstname,lastname=lastname,email=email,username=username,password=password,phone=phone).save()
        return redirect('thanku')
    else:
        return render(request,'register.html')


def image(request):
    if request.method == 'POST' and request.FILES['myfile']:
        myfile = request.FILES['myfile']
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        uploaded = fs.url(filename)
        print('uploaded',myfile.name)
        request.session['image']=myfile.name
        return render(request, 'image.html', {
            'uploaded': uploaded
        })
    return render(request,'image.html')
