from django.shortcuts import render
from user.models import User
from login.models import Login
# Create your views here.
def user(request):
    if request.method == "POST":
        obb = User()
        obb.username = request.POST.get('name')
        obb.password = request.POST.get('pass')
        obb.address = request.POST.get('adds')
        obb.phone = request.POST.get('phone')
        obb.email = request.POST.get('mail')
        obb.save()

        obj = Login()
        obj.username = obb.username
        obj.password = obb.password
        obj.u_id = obb.user_id
        obj.type = 'user'
        obj.save()
    return render(request,'user/userreg.html')