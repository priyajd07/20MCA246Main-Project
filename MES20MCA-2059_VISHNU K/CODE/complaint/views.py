from django.http import HttpResponse
from django.shortcuts import render
from complaint.models import Complaints

# Create your views here.
def complaint(request):
    # ss= request.session["u_id"]
    # vv=  request.session["uid"]
    cc=Complaints.objects.all()
    context={
        'ok':cc
    }
    if request.method == "POST":
        obj = Complaints()
        obj.u_id = 1
        obj.complaint=request.POST.get('complaint')
        # obj.time=datetime.datetime.now()
        # obj.date=datetime.datetime.today()
        # obj.status="pending"
        obj.reply="pending"
        obj.save()
    return render(request, 'complaint/post_complaint.html', context)

def view_comp(request):
    obj = Complaints.objects.all()
    context = {
        'comp': obj
    }
    return render(request,'complaint/view_complaint.html',context)

def post_reply(request,idd):
    obj = Complaints.objects.get(c_id=idd)
    if request.method == "POST":

        obj.reply = request.POST.get('reply')
        obj.save()
    return render(request,'complaint/post_reply.html')

from rest_framework.views import APIView,Response
from complaint.serializers import android_serialiser


class comp_view(APIView):
    def get(self, request):
        ob = Complaints.objects.all()
        ser = android_serialiser(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = Complaints()
        ob.complaint = request.data['complaint']
        ob.reply = "pending"
        ob.u_id = request.data['u_id']
        # ob.phone = request.data['phone']
        # ob.email = request.data['email']
        # ob.status = "pending"
        # ob.gender = request.data['gender']
        ob.save()
        return HttpResponse("yessss")






