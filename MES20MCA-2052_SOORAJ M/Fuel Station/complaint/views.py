from django.http import HttpResponse
from django.shortcuts import render
from complaint.models import Complaint
import datetime
# Create your views here.
def vcomplaint(request):
    ob = Complaint.objects.all()
    context = {
        'obj': ob
    }
    return render(request,'complaint/com.html',context)

def reply(request,idd):
    ob = Complaint.objects.get(com_id=idd)
    context = {
        'obj': ob
    }
    if request.method=="POST":
        ob = Complaint.objects.get(com_id=idd)
        ob.reply = request.POST.get('reply')
        ob.save()
    return render(request,'complaint/repley.html',context)
from rest_framework.views import APIView,Response
from complaint.serializers import android_serialiser


class comp_view(APIView):
    def get(self, request):
        ob = Complaint.objects.all()
        ser = android_serialiser(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = Complaint()
        ob.complaint = request.data['complaint']
        ob.reply = "pending"
        ob.user_id = "1"
        ob.username="abc"
        ob.date=datetime.datetime.today()
        # ob.address = request.data['address']
        # ob.gender=request.data['gender']
        # ob. = request.data['gender']
        ob.save()

        return HttpResponse("yessss")