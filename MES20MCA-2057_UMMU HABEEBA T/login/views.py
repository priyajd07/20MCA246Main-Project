from django.shortcuts import render
from login.models import Login

def login(request):
    if request.method == "POST":
        username = request.POST.get("luname")
        password = request.POST.get("lpass")
        obj = Login.objects.filter(username=username, password=password)
        type = ""
        for ob in obj:
            type = ob.type
            u_id = ob.u_id
            if type == "admin":
                request.session["u_id"] = u_id
                return render(request, 'temp/admin.html')
            elif type == "user":
                request.session["u_id"] = u_id
                context={
                    'det': username
                }
                return render(request, 'temp/user.html', context)
            elif type == "counsellor":
                request.session["u_id"] = u_id
                context = {
                    'det': username
                }
                return render(request, 'temp/counsellor.html',context)
            # else:
        objlist = "Username or Password incorrect... Please try again...!"
        context = {
            'msg': objlist,
        }
        return render(request, 'login/login.html', context)
    return render(request, 'login/Login.html')
