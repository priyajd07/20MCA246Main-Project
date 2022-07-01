from django.core.files.storage import FileSystemStorage
from django.shortcuts import render
from musiclist.models import Musiclist
from category.models import Category
# Create your views here.
def Music (request):
    obj=Category.objects.all()
    context={
        'ok':obj
    }
    if request.method == "POST":
        myfile = request.FILES['file']
        fs = FileSystemStorage()
        filename = fs.save(myfile.name, myfile)
        # comObj.com_pic =

        obb = Musiclist()
        obb.title = request.POST.get('ml')
        obb.type = request.POST.get('cat')
        obb.filename = myfile.name
        obb.save()
    return render(request,'musiclist/music.html',context)

def viewmusic (request):
    obb=Musiclist.objects.all()
    context={
        'obval':obb
    }
    return render(request,'musiclist/viewmusic.html',context)