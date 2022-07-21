from django.http import HttpResponse
from django.shortcuts import render
from orderfuel.models import Orderfuel, Payment
from delivery.models import Delivary
# Create your views here.
def vieworder(request):
    uid=request.session["uid"]
    obb=Orderfuel.objects.filter(fs_id=uid)
    context={
        'obval':obb
    }
    return render(request,'orderfuel/orderview.html', context)

def viewdf(request,idd):
    request.session['oid']=idd
    obb=Delivary.objects.all()
    context={
        'obval':obb
    }
    return render(request,'orderfuel/viewdb.html', context)

from django.http import HttpResponseRedirect



def assign(request,idd):
    oid=request.session['oid']
    print(oid)
    print(idd)
    ord=Orderfuel.objects.get(order_id=oid)
    ord.d_id=idd
    ord.save()
    return HttpResponseRedirect('/order/order/')


    # return render(request,'')
from rest_framework.views import APIView,Response
from orderfuel.serializers import android_serialiser, android_serialisers

import datetime
class ord_view(APIView):
    def get(self, request):
        ob =Orderfuel.objects.all()
        ser = android_serialiser(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = Orderfuel()
        ob.date = datetime.datetime.now()
        ob.u_id = request.data['u_id']
        ob.fs_id = request.data['fsid']
        ob.fuel = request.data['fuel']
        ob.qty = request.data['qty']
        ob.status="pending"
        ob.latitude='11.2596128'
        ob.longitude='75.785404'
        ob.phone = request.data['phone']
        ob.d_id ='0'
        # ob. = request.data['gender']

        # //send sms here




        ob.save()

        return HttpResponse("yessss")


class payment(APIView):
    def get(self, request):
        ob =Payment.objects.all()
        ser = android_serialisers(ob, many=True)
        return Response(ser.data)

    def post(self, request):
        ob = Payment()
        ob.order_id="1"
        ob.cardnumber=request.data['cardnumber']
        ob.card_holdername=request.data['card_holdername']
        ob.amount=int(request.data['amount'])+50
        ob.save()

        return HttpResponse("yessss")

