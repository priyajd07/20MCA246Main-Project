from django.shortcuts import render
from items.models import Items

# Create your views here.
def items(request):
    if request.method=="POST":
        ob=Items()
        ob.items=request.POST.get('items')
        ob.save()

    return render(request,'items/add_items.html')
def show_items(request):
    return render(request,'items/add_showcase.html')

def viewitems(request):
    ob=Items.objects.all()
    context={
        'obj':ob
    }
    return render(request,'items/view_items.html',context)
