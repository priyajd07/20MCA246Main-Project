from django.shortcuts import render
from fuelstatn.models import Fuelstn
from login.models import Login
# Create your views here.
def fuelsreg(request):
    if request.method=="POST":
        obb=Fuelstn()
        obb.username=request.POST.get('name')
        obb.password=request.POST.get('pass')
        obb.address=request.POST.get('adds')
        obb.phone=request.POST.get('phone')
        obb.email=request.POST.get('mail')
        obb.save()
        obj = Login()
        obj.username = obb.username
        obj.password = obb.password
        obj.u_id = obb.fs_id
        obj.type = 'FuelStation'
        obj.save()
    return render(request,'fuelstatn/fuelsreg.html')

def viewfs(request):
    obb=Fuelstn.objects.all()
    context={
        'obval':obb
    }
    return render(request,'fuelstatn/viewstation.html', context)

def approve(request,idd):
        obb = Fuelstn.objects.get(fs_id=idd)
        obb.status ='approved'
        obb.save()
        return viewfs(request)


def reject(request,idd):
    obb = Fuelstn.objects.get(fs_id=idd)
    obb.status ='rejected'
    obb.save()
    return viewfs(request)
