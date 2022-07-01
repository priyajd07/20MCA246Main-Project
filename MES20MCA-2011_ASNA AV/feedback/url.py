from django.conf.urls import url
from feedback import views

urlpatterns=[
    url('^vfeed/',views.viewfeed),
    url('^feedback/',views.feedback)


]