from django.http import HttpResponse
from django.shortcuts import render

from login.models import Login
from user.models import User


# Create your views here.
def user_reg(request):
    if request.method == "POST":
        obj = User()
        obj.name = request.POST.get('name')
        obj.address = request.POST.get('addr')
        obj.phone = request.POST.get('phone')
        obj.email = request.POST.get('email')
        obj.username = request.POST.get('username')
        obj.save()
        ob=Login()
        ob.username = request.POST.get('username')
        ob.password = request.POST.get('password')
        ob.type = request.POST.get('login')
        # ob.u_id = request.POST.get('')
    return render(request, 'user/user_reg.html')



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
        ob.address = request.data['address']
        ob.phone = request.data['phone']
        ob.email = request.data['email']
        ob.status = "pending"
        ob.gender = request.data['gender']
        ob.save()

        obj=Login()
        obj.username=request.data['email']
        obj.password=request.data['password']
        obj.type="user pending"
        obj.user_id=ob.u_id
        obj.save()
        return HttpResponse("yessss")

def view_user(request):
    obj = User.objects.all()
    context = {
        'userview': obj
    }
    return render(request, 'user/view_user.html', context)







