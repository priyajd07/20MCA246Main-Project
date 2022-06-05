from django.http import HttpResponse
from django.shortcuts import render
from user.models import User
from login.models import Login
# Create your views here.
def user(request):
    if request.method=="POST":
        obb=User()
        obb.username=request.POST.get('username')
        obb.password=request.POST.get('pass')
        obb.address=request.POST.get('adds')
        obb.gender=request.POST.get('gender')
        obb.phone=request.POST.get('phone')
        obb.email=request.POST.get('mail')
        obb.save()
        obj=Login()
        obj.username = obb.username
        obj.password = obb.password
        obj.u_id = obb.user_id
        obj.type = 'User'
        obj.save()
    return render(request,'user/userreg.html')

from rest_framework.views import APIView,Response
from user.serializers import android_serialiser


class user_view(APIView):
    def get(self, request):
        ob = User.objects.all()
        ser = android_serialiser(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = User()
        ob.username = request.data['username']
        ob.password = request.data['password']
        ob.phone = request.data['phone']
        ob.email = request.data['email']
        ob.address = request.data['address']
        ob.gender=request.data['gender']
        # ob. = request.data['gender']
        ob.save()

        obj=Login()
        obj.username=request.data['email']
        obj.password=request.data['password']
        obj.type="User"
        obj.user_id=ob.user_id
        obj.save()
        return HttpResponse("yessss")
