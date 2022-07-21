from django.http import HttpResponse
from django.shortcuts import render
from delivery.models import Delivary
from login.models import Login
from orderfuel.models import Orderfuel
# Create your views here.
def delreg(request):
    if request.method=="POST":
        obb=Delivary()
        obb.username=request.POST.get('name')
        obb.password=request.POST.get('pass')
        obb.address=request.POST.get('adds')
        obb.phone=request.POST.get('phone')
        obb.email=request.POST.get('mail')
        obb.save()
        obj = Login()
        obj.username = obb.username
        obj.password = obb.password
        obj.u_id = obb.d_id
        obj.type = 'Delivery'
        obj.save()
    return render(request,'delivery/delreg.html')

def viewd(request):
    obb=Delivary.objects.all()
    context={
        'obval':obb
    }
    return render(request,'delivery/viewdel.html', context)

def approve(request,idd):
     obb = Delivary.objects.get(d_id=idd)
     obb.status ='approved'
     obb.save()
     return viewd(request)


def reject(request,idd):
    obb = Delivary.objects.get(d_id=idd)
    obb.status ='rejected'
    obb.save()
    return viewd(request)


from rest_framework.views import APIView,Response
from delivery.serializers import android_serialiser, android_serialiser2


class deli_view(APIView):
    def get(self, request):
        ob = Delivary.objects.all()
        ser = android_serialiser(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = Delivary()
        ob.username = request.data['username']
        ob.password = request.data['password']
        ob.phone = request.data['phone']
        ob.email = request.data['email']
        ob.address = request.data['address']
        ob.status="pending"
        ob.vechicle=request.data['veh']
        ob.img="pending"
        # ob. = request.data['gender']
        ob.save()

        obj=Login()
        obj.username=request.data['username']
        obj.password=request.data['password']
        obj.type="Delivery"
        obj.u_id=ob.d_id
        obj.save()
        return HttpResponse("yessss")


class deli_boyview(APIView):
    def get(self, request):
        ob = Orderfuel.objects.all()
        ser = android_serialiser2(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        did=request.data['did']
        ob = Orderfuel.objects.filter(d_id=did)
        ser = android_serialiser2(ob, many=True)
        return Response(ser.data)

class deli_updstatus(APIView):
    def get(self, request):
        ob = Orderfuel.objects.all()
        ser = android_serialiser2(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        oid = request.data['ordid']
        ob = Orderfuel.objects.get(order_id=oid)
        ob.status="Delivered"
        ob.save()

        return HttpResponse("yessss")



        # return HttpResponse("yessss")
from django.core.files.storage import FileSystemStorage
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from fuelstation import settings
# Create your views here.

@csrf_exempt
def simple_upload(request):
    if request.method == 'POST' and request.FILES['file']:
        myfile = request.FILES['file']
        fs = FileSystemStorage()
        fpath = str(settings.BASE_DIR) + str(settings.STATIC_URL) +myfile.name
        # filename = fs.save(myfile.name, myfile)
        filename = fs.save(fpath, myfile)

        obj=Delivary.objects.filter(img='pending')
        if len(obj)>0:
            ob=obj[0]
            ob.img=filename
            ob.save()

        return HttpResponse("uploaded")
    return HttpResponse("hello")