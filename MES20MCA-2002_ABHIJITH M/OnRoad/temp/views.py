from django.shortcuts import render

# Create your views here.
def index(request):
    return render(request,'temp/index.html')

def admin(request):

    return render(request,'temp/sample.html')

def sample(request):
    return render(request,'temp/sample.html')