import datetime

from django.core.files.storage import FileSystemStorage
from django.shortcuts import render

from comment.models import Comment
from friendrequest.models import Friendrequest
from post.models import Status

from post.models import Post


from luxand import luxand
from DetectingMentalDisorders import settings
import requests
from user.models import User


class facedata:
    client = luxand("36f0a9d16c554e87bd09d024842e1b50")
    obj = User.objects.all()
    url = "https://api.luxand.cloud/subject"

    payload = {}
    headers = {'token': "36f0a9d16c554e87bd09d024842e1b50"}

    response = requests.request("DELETE", url, data=payload, headers=headers)
    for ob in obj:
        imgpath = str(settings.BASE_DIR) + str(settings.STATIC_URL) + str(ob.u_profile_pic)
        print(imgpath)
        try:
            client.add_person(name=str(ob.u_id), photos=[imgpath])
        except Exception as ex:
            print(imgpath)





def createPost(request):
    eid = request.session["u_id"]
    if request.method == "POST":
        pobj = Post()
        # pobj.p_content = request.POST.get('pcontent')
        pobj.status="open"
        myfile = request.FILES["pfile"]
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        pobj.p_pic = filename
        pobj.u_id = eid
        pobj.save()
        imgpath = str(settings.BASE_DIR) + str(settings.STATIC_URL) + str(filename)
        result = facedata.client.recognize(photo=imgpath)
        #
        if len(result) > 0:
            for o in result:
                print(o["name"])
                us=o["name"]
                ob=User.objects.get(u_id=us)
                obst=Status()
                obst.p_id=pobj.p_id
                obst.u_id=ob.u_id
                obst.statusu="blocked"
                obst.save()
                obb=Post.objects.get(p_id=pobj.p_id)
                obb.status="blocked"
                obb.save()

            # rs = result[0]
            # id = rs["name"]
            #
            # print(name)




        # message = pobj.p_content
        # emo = model.predict([message])[0]

        # pobj.emotion = emo


    return render(request, 'post/Create_post.html')

def removePost(request):
    object = Post.objects.all()
    context = {
        'details': object
    }
    return render(request, 'post/Remove_Post.html',context)


def blockpost(request):
    eid = request.session["u_id"]
    object =Status.objects.filter(u_id=eid)
    context = {
        'details': object
    }
    return render(request, 'post/Remove_Post.html',context)

def ap(request,idd):
    obj=Status.objects.get(p_id=idd)
    obj.statusu="open"
    obj.save()
    ob=Post.objects.get(p_id=idd)
    ob.status="open"
    ob.save()
    return blockpost(request)
def viewPostAdmin(request):
    object = Post.objects.all()
    context = {
        'details': object
    }
    return render(request, 'post/View_Post_Admin.html', context)

def viewPostUser(request):
    eid = str(request.session["u_id"])
    o = Friendrequest.objects.get(u_id=eid, status="Accepted")
    object = Post.objects.filter(u_id=o.u_id)
    context = {
        'details': object
    }
    return render(request, 'post/View_Post_User.html', context)

def viewCommentsAdmin(request,idd):
    ob = Post.objects.get(p_id=idd)
    obj = Comment.objects.filter(p_id=ob.p_id)
    context = {
        'details': obj
    }
    return render(request, 'comment/View_Comments_Admin.html', context)

def viewCommentsUser(request,idd):
    object = Post.objects.get(p_id=idd)
    obj = Comment.objects.filter(p_id=object.p_id)
    context = {
        'details': obj
    }
    return render(request, 'comment/View_Comments_User.html', context)

def postComments(request,idd):
    eid = str( request.session["u_id"])
    o = Post.objects.get(p_id=idd)
    if request.method == "POST":
        comObj = Comment()
        comObj.com_content = request.POST.get('comcontent')

        myfile = request.FILES['comfile']
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        comObj.com_pic = myfile.name

        comObj.u_id = o.u_id
        comObj.p_id = o.p_id
        comObj.f_id = eid
        comObj.r_id = eid

        comObj.com_date = datetime.date.today()
        comObj.com_time = datetime.datetime.now()
        comObj.reply = "NULL"
        comObj.status = "Pending"
        comObj.save()
    o.save()
    return render(request, 'comment/Create_Comment.html')