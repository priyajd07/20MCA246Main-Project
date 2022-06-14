from django.conf.urls import url
from django.shortcuts import render
from complaint.models import Complaint

from items import views


def complaint(request):
    # ss= request.session["u_id"]
    # vv=  request.session["uid"]
    cc=Complaint.objects.all()
    context={
        'ok':cc
    }
    if request.method == "POST":
        obj = Complaint()
        obj.u_id = 1
        obj.complaint=request.POST.get('complaint')
        # obj.time=datetime.datetime.now()
        # obj.date=datetime.datetime.today()
        # obj.status="pending"
        obj.reply="pending"
        obj.save()
    return render(request, 'complaint/post_complaint.html', context)

def view_comp(request):
    obj = Complaint.objects.all()
    context = {
        'obval': obj
    }
    return render(request,'complaint/view_complaint.html', context)

def post_reply(request,idd):
    obj = Complaint.objects.get(c_id=idd)
    if request.method == "POST":

        obj.reply = request.POST.get('reply')
        obj.save()
    return render(request,'complaint/reply.html')

def viewreply(request):
    ss=request.session["uid"]
    objval= Complaint.objects.filter(c_id=ss)
    context={
        'ok':objval
    }
    return render(request,'complaint/view_reply.html',context)