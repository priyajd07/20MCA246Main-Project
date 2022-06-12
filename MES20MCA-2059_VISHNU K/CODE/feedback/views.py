from django.shortcuts import render
from feedback.models import Feedback

# Create your views here.
def view_feedback(request):
    obj = Feedback.objects.all()
    context = {
        'comp': obj
    }
    return render(request,'feedback/view_feedback.html', context)