from django.shortcuts import render
from message.models import Message
from django.core.files.storage import FileSystemStorage
from user.models import User
from friendrequest.models import Friendrequest
from friend.models import Friend
from django.db.models import Q
import datetime
from user_counsellor.models import UserCounsellor
from counsellor.models import Counsellor
from message.models import Cmessage

def createMessage(request,idd):
    eid = str(request.session["u_id"])
    # object=Message.objects.get(m_id=idd)
    # context = {
    #     'details': object
    # }
    if request.method == "POST":
        mobj = Message()
        mobj.m_content = request.POST.get('mcontent')

        myfile = request.FILES["mfile"]
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        mobj.m_pic = myfile.name

        mobj.u_id = eid
        o = Friendrequest.objects.filter(Q(u_id=eid) & Q(status="Accepted"))
        mobj.f_id = object.u_id
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        mobj.prev_id = idd
        mobj.save()
    return render(request, 'message/Create_Message.html')

def chatWithUser(request,idd):
    eid = str(request.session["u_id"])
    o = Friendrequest.objects.filter(u_id=eid, status="Accepted")
    object = Message.objects.filter(Q(Q(u_id=idd) & Q(f_id=eid)) | Q(Q(u_id=eid) & Q(f_id=idd)))
    context = {
        'details': object
    }
    return render(request, 'message/Chat_with_User.html', context)

def inbox(request,idd):
    eid = str(request.session["u_id"])
    if request.method == "post":
        ob = Message.objects.get(m_id=idd)
        # ob.m_reply = request.POST.get('reply')
        ob.save()
    return render(request, 'message/Inbox.html')

def createnew(request):
    eid = str(request.session["u_id"])
    o = Friendrequest.objects.filter(Q(u_id=eid, status="Accepted"))
    context = {
        'details': o
    }
    if request.method == "POST":
        mobj = Message()
        mobj.m_content = request.POST.get('mcontent')

        # myfile = request.FILES["mfile"]
        # fs = FileSystemStorage()
        # filename = fs.save(myfile.name, myfile)
        mobj.m_pic = "img"

        mobj.u_id = eid
        # o = Friendrequest.objects.filter(Q(u_id=eid) & Q(status="Accepted"))

        mobj.f_id = request.POST.get('to')
        f = request.POST.get('f')
        c = request.POST.get('c')
        # if f=="":
        #     mobj.type = "counsellor"
        # else:
        #     mobj.type = "friend"
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        mobj.type="user"
        # mobj.prev_id = 0
        mobj.save()
    return render(request, 'message/createnewMessage.html', context)

# def createNewMessage(request):
# def message(request,idd):
#     eid = str(request.session["u_id"])
#     obj = Message.objects.filter(m_id=idd)
#     context = {
#         'details': obj,
#         'currentuser': eid
#     }
#     return render(request,'message/Message_details.html', context)

def viewFriendsList(request):
    # eid = str(request.session["u_id"])
    obj = Message.objects.all()
    # ml = []
    # ob = list(Message.objects.filter(Q(u_id=eid)))
    # for i in ob:
    #     ml.append(i.f_id)
    #
    # ob = list(Message.objects.filter(f_id=eid))
    # for i in ob:
    #     if i.u.u_id not in ml:
    #         ml.append(i.u.u_id)
    # print(ml)
    # lst = []
    # ob = list(Friendrequest.objects.filter(
    #     Q(f_id=eid, status="Accepted")))
    # for i in ob:
    #     lst.append(i.u.u_id)
    # ob = list(Friendrequest.objects.filter(Q(u_id=eid, status="Accepted")))
    # for i in ob:
    #     if i.f.f_id not in lst:
    #         lst.append(i.f.f_id)
    # print(lst)
    # cl = []
    # for i in lst:
    #     if i in ml:
    #         cl.append(i)
    #
    # print(cl)
    o = Friend.objects.all()
    # print(o)
    # if o is not None:
    context = {
            'details': obj
    }
    return render(request, 'message/Inbox.html', context)
    # return render(request, 'message/Inbox.html')

def alertmessage(request,idd,isd):
    m = Message()
    m.u_id = '777'
    m.f_id = idd
    m.m_content = "Your friend "+isd+" is suffering from a mental disorder"
    m.m_time = datetime.datetime.now()
    m.m_date = datetime.date.today()
    m.m_pic = ""
    m.prev_id = 0
    m.save()

    return render(request,'temp/admin.html')

def chatWithC(request,idd):
    eid = str(request.session["u_id"])
    o = UserCounsellor.objects.filter(u_id=eid, status="Accepted")
    object = Cmessage.objects.filter(Q(Q(u_id=eid) & Q(c_id=idd)))

    context = {
        'details': object
    }
    return render(request, 'message/chatwithCounsellor.html', context)
def chatWithU(request,idd):
    eid = str(request.session["u_id"])
    o = UserCounsellor.objects.filter(u_id=eid, status="Accepted")
    object = Cmessage.objects.filter(Q(Q(u_id=idd) & Q(c_id=eid)) | Q(Q(u_id=eid) & Q(c_id=idd)))
    context = {
        'details': object
    }
    return render(request, 'message/chatwithuser.html', context)

def createnewC(request):
    eid = str(request.session["u_id"])
    a=[]
    o = list(UserCounsellor.objects.filter(Q(u_id=eid) & Q(status="Accepted")))
    for i in o:
        a.append(i.c_id)
    print(a)
    print("heheheheheheheheh")
    if request.method == "POST":
        mobj = Cmessage()
        mobj.m_content = request.POST.get('mc')
        mobj.u_id = eid

        # mobj.f_id = idd
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        # mobj.prev_id = 0
        mobj.sendby = eid
        mobj.save()
        print(mobj.u_id)
        print(mobj.f_id)

    return render(request, 'temp/user.html')
def viewCounList(request):
    eid = str(request.session["u_id"])
    ml = []
    ob = list(Cmessage.objects.filter(Q(u_id=eid)))
    for i in ob:
        ml.append(i.c_id)

    # ob = list(Cmessage.objects.filter(c_id=eid))
    # for i in ob:
    #     if i.u.u_id not in ml:
    #         ml.append(i.u.u_id)
    print(ml)
    lst = []
    ob = list(UserCounsellor.objects.filter(
        Q(u_id=eid, status="Accepted")))
    for i in ob:
        lst.append(i.f.c_id)
    print(lst)
    cl = []
    for i in lst:
        if i in ml:
            cl.append(i)

    print(cl)
    o = Counsellor.objects.filter(c_id__in=cl)
    # print(o)

    context = {
        'details': o
    }
    print(context)
    return render(request, 'message/InboxC.html', context)
def createnewmessage(request):
    eid = str(request.session["u_id"])
    # o = Friendrequest.objects.filter(Q(u_id=eid, status="Accepted"))
    c = UserCounsellor.objects.filter(Q(u_id=eid, status="Accepted"))
    context = {
        'details': c,
        # 'c': c
    }
    if request.method == "POST":
        mobj = Cmessage()
        mobj.m_content = request.POST.get('mcontent')

        # myfile = request.FILES["mfile"]
        # fs = FileSystemStorage()
        # filename = fs.save(myfile.name, myfile)
        # mobj.m_pic = myfile.name

        mobj.u_id = eid
        # o = Friendrequest.objects.filter(Q(u_id=eid) & Q(status="Accepted"))

        mobj.c_id = request.POST.get('to')
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        mobj.sendby = eid
        # mobj.prev_id = 0
        mobj.save()
    return render(request, 'message/createnewC.html', context)

def createMessageC(request,idd):
    eid = str(request.session["u_id"])
    object=Cmessage.objects.get(m_id=idd)
    context = {
        'details': object
    }
    if request.method == "POST":
        mobj = Cmessage()
        mobj.m_content = request.POST.get('mcontent')

        # myfile = request.FILES["mfile"]
        # fs = FileSystemStorage()
        # filename = fs.save(myfile.name, myfile)
        # mobj.m_pic = myfile.name

        mobj.u_id = eid
        o = UserCounsellor.objects.filter(Q(u_id=eid) & Q(status="Accepted"))
        mobj.c_id = object.c_id
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        # mobj.prev_id = idd
        mobj.sendby = eid
        mobj.save()
    return render(request, 'message/Create_Message_C.html', context)

def createMessageU(request,idd):
    eid = str(request.session["u_id"])
    object=Cmessage.objects.get(m_id=idd)
    context = {
        'details': object
    }
    if request.method == "POST":
        mobj = Cmessage()
        mobj.m_content = request.POST.get('mcontent')

        # myfile = request.FILES["mfile"]
        # fs = FileSystemStorage()
        # filename = fs.save(myfile.name, myfile)
        # mobj.m_pic = myfile.name

        mobj.u_id = object.u_id
        o = UserCounsellor.objects.filter(Q(u_id=eid) & Q(status="Accepted"))
        mobj.c_id = eid
        mobj.m_date = datetime.date.today()
        mobj.m_time = datetime.datetime.now()
        # mobj.prev_id = idd
        mobj.sendby = eid
        mobj.save()
    return render(request, 'message/Create_Message_C.html', context)
def viewUList(request):
    eid = str(request.session["u_id"])
    ml = []
    ob = list(Cmessage.objects.filter(Q(c_id=eid)))
    for i in ob:
        ml.append(i.u_id)

    # ob = list(Cmessage.objects.filter(c_id=eid))
    # for i in ob:
    #     if i.u.u_id not in ml:
    #         ml.append(i.u.u_id)
    print(ml)
    lst = []
    ob = list(UserCounsellor.objects.filter(
        Q(f_id=eid, status="Accepted")))
    for i in ob:
        lst.append(i.u.u_id)
    print(lst)
    cl = []
    for i in lst:
        if i in ml:
            cl.append(i)

    print(cl)
    o = User.objects.filter(u_id__in=cl)
    # print(o)

    context = {
        'details': o
    }
    print(context)
    return render(request, 'message/InboxU.html', context)