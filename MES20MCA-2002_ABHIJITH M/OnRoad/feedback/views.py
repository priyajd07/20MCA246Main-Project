from django.shortcuts import render
from feedback.models import Feedback
# Create your views here.
def viewfeed(request):
    ob = Feedback.objects.all()
    context = {
        'obj': ob
    }
    return render(request,'feedback/view_feedback.html',context)
