from django.shortcuts import render
from category.models import Category

# Create your views here.
def cat (request):
    if request.method == "POST":
        obb = Category()
        obb.category = request.POST.get('catn')
        obb.save()
    return render(request,'category/cat.html')

