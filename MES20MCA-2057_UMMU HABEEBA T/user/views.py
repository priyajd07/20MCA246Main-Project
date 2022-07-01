import datetime

from django.shortcuts import render
from user.models import User
from friend.models import Friend
from django.core.files.storage import FileSystemStorage
from login.models import Login
from friendrequest.models import Friendrequest
from user_counsellor.models import UserCounsellor

def blockUnblockUser(request):
    object = User.objects.filter(u_status="Active")
    context = {
        'details': object
    }
    return render(request, 'user/Block_Unblock_User.html', context)

def userRegisteration(request):
    if request.method == "POST":
        dd = request.POST.get('udob')
        ab = dd[0:4]
        rr = datetime.date.today().year
        # type(rr)
        print(rr)
        if int(ab) >= int(rr):
            msg = "Invalid Birth Year...!!!"
            context = {
                'mmm': msg
            }
            return render(request, 'user/User_Registeration.html', context)
        else:
            # eid = str(request.session["u_id"])
            uobj = User()
            uobj.u_name = request.POST.get('uname')
            uobj.u_mobile = request.POST.get('umob')
            uobj.u_mail = request.POST.get('umail')
            uobj.u_gender = request.POST.get('ugen')
            uobj.u_dob = request.POST.get('udob')
            uobj.u_location = request.POST.get('uloc')

            myfile = request.FILES["u_pic"]
            fs = FileSystemStorage()
            filename = fs.save(myfile.name, myfile)
            uobj.u_profile_pic = myfile.name

            uobj.u_status = "Active"
            uobj.u_uname = request.POST.get('uuname')
            uobj.u_pass = request.POST.get('upass')
            uobj.save()


            # fobj = Friend()
            # fobj.f_name = request.POST.get('uname')
            # fobj.f_mobile = request.POST.get('umob')
            # fobj.f_mail = request.POST.get('umail')
            # fobj.f_gender = request.POST.get('ugen')
            # fobj.f_dob = request.POST.get('udob')
            # fobj.f_location = request.POST.get('uloc')
            #
            # fobj.f_profile_pic = myfile.name
            #
            # fobj.f_uname = request.POST.get('uuname')
            # fobj.f_pass = request.POST.get('upass')
            # fobj.u_id = eid
            # fobj.a_id="1"
            # fobj.status = "Pending"
            # fobj.save()
            #
            # fro = Friendrequest()
            # fro.f_id = 777
            # fro.u_id = eid
            # fro.status = "Accepted"
            # fro.save()


            obj = Login()
            obj.username = request.POST.get('uuname')
            obj.password = request.POST.get('upass')
            obj.type = "user"
            obj.u_id = uobj.u_id
            obj.save()

            objlist = "Registered Succesfully"
            context = {
                'success': objlist
            }

            return render(request, 'user/User_Registeration.html',context)
    return render(request, 'user/User_Registeration.html')

def viewBlockReport(request):
    object = User.objects.filter(u_status="Blocked")
    context = {
        'details': object
    }
    return render(request, 'user/View_Block_Report.html', context)

def viewUserAdmin(request):
    object = User.objects.all()
    context = {
        'details': object
    }
    return render(request, 'user/View_User_Admin.html', context)

def viewUserCounsellor(request):
    eid = request.session["u_id"]
    object = UserCounsellor.objects.filter(f_id=eid)
    context = {
        'details': object
    }
    return render(request, 'user/View_User_Counsellor.html', context)

def blockUser(request,idd):
    ob = User.objects.get(u_id=idd)
    ob.u_status = "Blocked"
    ob.save()
    return blockUnblockUser(request)

def unblockUser(request, idd):
        ob = User.objects.get(u_id=idd, u_status="Blocked")
        ob.u_status = "Active"
        ob.save()
        return viewBlockReport(request)



