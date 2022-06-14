from django.shortcuts import render
from user.models import User
from login.models import Login

# Create your views here.
def user_reg(request):
    if request.method == "POST":
        ob = User()
        ob.username = request.POST.get('name')
        ob.password = request.POST.get('Password')
        ob.email = request.POST.get('Email')
        ob.address = request.POST.get('Address')
        ob.phone_no = request.POST.get('phoneno')
        ob.gender = request.POST.get('gen')
        ob.save()
        obb=Login()
        obb.username=ob.username
        obb.password=ob.password
        obb.u_id=ob.user_id
        obb.type='user'
        obb.save()
    return render(request,'user/user_register.html')