from django.http import HttpResponseRedirect
from django.shortcuts import render
from login.models import Login

# Create your views here.
def login(request):
    if request.method == "POST":
        uname = request.POST.get("name")
        passw = request.POST.get("pass")
        print(uname)
        obj = Login.objects.filter(username=uname, password=passw)
        tp = ""
        for ob in obj:
            tp = ob.type
            uid = ob.u_id
            if tp == "admin":
                request.session["uid"] = uid
                return render(request,'temp/admin.html')
            elif tp == "user":
                request.session["uid"] = uid
                return render(request,'temp/user.html')
            # elif tp == "subadmin":
            #     request.session["uid"] = uid
            #     return render(request, 'login/s_subhome.html')
            # else:
        objlist = "Username or Password incorrect... Please try again...!"
        context = {
            'msg': objlist,
        }
        return render(request, 'login/login.html', context)
    return render(request, 'login/login.html')