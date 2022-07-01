from django.http import HttpResponseRedirect
from django.shortcuts import render
from friend.models import Friend
from friendrequest.models import Friendrequest
from user.models import User
from django.db.models import Q
from message.models import Message

def addFriends(request):
    eid = str(request.session["u_id"])
    # ob = Friend.objects.get(f_id=eid)
    ob = []
    lst=[]
    ob = list(Friendrequest.objects.filter(Q(f_id=eid, status="Accepted") | Q(u_id=eid, status="Accepted") | Q(u_id=eid, status="Pending")))
    # print(ob)
    for i in ob:
        lst.append(i.f_id)

        # print(i.f.f_id)
    #     o = Friend.objects.exclude(f_id__in=ob)
    #     context = {
    #         'details': o
    #     }
    lst.append(int(eid))
    print(lst)
    o = User.objects.all().exclude(u_id=eid)
    context = {
        'details': o
    }
    # for i in ob:
    #     print(i.f.f_id)
    #     o = Friend.objects.exclude(f_id__in=ob)
    #     context = {
    #         'details': o
    #     }
    return render(request, 'friend/Add_Friends.html', context)
    # return render(request, 'friend/Add_Friends.html')

def alertFriends(request,idd):
    lst = []
    lst.append(int(idd))
    ob = list(Friendrequest.objects.filter(
        Q(f_id=idd, status="Accepted") | Q(u_id=idd, status="Accepted")))
    # print(ob)
    for i in ob:
        if i.f.f_id not in lst:
            lst.append(i.f.f_id)
    lst.reverse()
    lst.pop()
    print(lst)
    f = Friend.objects.filter(f_id=idd)
    o = User.objects.filter(u_id__in=lst)
    context ={
        'details': o,
        'fr': f
    }
    return render(request, 'friend/Alert_Friends.html', context)

def manageFreinds(request):
    eid = str(request.session["u_id"])
    object = Friendrequest.objects.filter(f_id=eid,status="Pending")
    # ob = Friend.objects.filter(u_id=object.f_id)
    context = {
        'details': object
    }
    return render(request, 'friend/Manage_Friends.html', context)

def viewFriends(request):
    eid = str(request.session["u_id"])
    # obj = Friend.objects.filter(f_id=eid)
    o = Friendrequest.objects.filter(Q(u_id=eid, status="Accepted"))
    context = {
        'details': o
    }
    return render(request, 'friend/View_Friends.html', context)

def fAccept(request,idd):
    eid = str(request.session["u_id"])
    ob = Friendrequest.objects.get(req_id=idd)
    ob.status = "Accepted"
    ob.save()
    return manageFreinds(request)

def fReject(request,idd):
    # ob = Friend.objects.(f_id=idd)
    eid = str(request.session["u_id"])
    o = Friendrequest.objects.get(req_id=idd)
    o.status = "Rejected"
    o.save()
    return manageFreinds(request)

def fRequest(request,idd):
    eid = str(request.session["u_id"])
    obj =Friendrequest()
    obj.status="Pending"
    obj.u_id=eid
    obj.f_id=idd

    obj.save()
    # obj.save()
    return HttpResponseRedirect('/friend/addf/')