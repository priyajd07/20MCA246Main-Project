import datetime
from django.shortcuts import render
from feedback.models import Feedback
# Create your views here.
def viewfeed(request):
    ob = Feedback.objects.all()
    context = {
        'obj': ob
    }
    return render(request,'feedback/feed.html', context)

def feedback(request):

    user=request.session["uid"]
    print(request.method)
    if request.method=="POST":
        print('hello')
        obb = Feedback()
        obb.feedback=request.POST.get('feed')
        obb.time = datetime.datetime.now()
        obb.date = datetime.date.today()
        obb.user_id = user
        obb.save()
    return render(request,'feedback/feedback.html')