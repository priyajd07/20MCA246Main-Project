from django.http import HttpResponseRedirect
from django.shortcuts import render
from login.models import Login
# Create your views here.
def login(request):
    if request.method == "POST":
        uname = request.POST.get("username")
        passw = request.POST.get("password")
        obj = Login.objects.filter(username=uname,password=passw)
        tp = ""
        for ob in obj:
            tp = ob.type
            uid = ob.u_id
            if tp == "admin":
                request.session["uid"] = uid
                return HttpResponseRedirect('/temp/admin/')
            elif tp == "User":
                request.session["uid"] = uid
                return HttpResponseRedirect('/fuelstation/viewfs/')
            elif tp == "FuelStation":
                request.session["uid"] = uid
                return HttpResponseRedirect('/temp/flst/')
            elif tp == "Delivery":
                request.session["uid"] = uid
                return HttpResponseRedirect('/fuelstation/viewfs/')
            # else:
        objlist = "Username or Password incorrect... Please try again...!"
        context = {
            'msg': objlist,
            }
        return render(request, 'login/login.html', context)
    return render(request,'login/login.html')