from django.shortcuts import render
from complaint.models import Complaint

# Create your views here.
def viewcomplaint(request):
    ob = Complaint.objects.all()
    context = {
        'obj': ob
    }
    print(len(ob))
    return render(request,'complaint/complaint.html',context)

def reply(request,idd):
    ob = Complaint.objects.get(c_id=idd)
    context = {
        'obj': ob
    }
    if request.method=="POST":
        ob=Complaint.objects.get(c_id=idd)
        ob.reply=request.POST.get('reply')
        ob.save()
    return render(request,'complaint/reply.html',context)