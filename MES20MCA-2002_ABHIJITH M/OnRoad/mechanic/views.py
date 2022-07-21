from django.shortcuts import render
from mechanic.models import Mechanic
from login.models import Login

# Create your views here.
def mech_reg(request):
    if request.method=="POST":
        obb=Mechanic()
        obb.username=request.POST.get('name')
        obb.password=request.POST.get('Password')
        obb.email=request.POST.get('Email')
        obb.phone_no=request.POST.get('phoneno')
        obb.address=request.POST.get('Address')
        obb.specilization=request.POST.get('special')
        obb.save()
        obj=Login()
        obj.username=obb.username
        obj.password=obb.password
        obj.u_id=obb.mech_id
        obj.type='mech'
        obj.save()
    return render(request,'mechanic/mech_register.html')

def viewitems(request):
    ob=Mechanic.objects.all()
    context={
        'obj':ob
    }
    return render(request,'mechanic/view_mech.html',context)

def aprove(request,idd):
    obj=Mechanic.objects.get(mech_id=idd)
    obj.status='aprove'
    obj.save()
    return  viewitems(request)
def reject(request,idd):
    obj=Mechanic.objects.get(mech_id=idd)
    obj.status='reject'
    obj.save()
    return viewitems(request)