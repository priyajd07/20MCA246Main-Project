from django.shortcuts import render

# Create your views here.
def hom (request):
    return render(request,'temp/home.html')

def Adm (request):
    return render(request,'temp/admin.html')

def fuels (request):
    return render(request,'temp/fuelstation.html')
