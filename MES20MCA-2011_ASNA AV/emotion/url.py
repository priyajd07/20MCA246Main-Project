from django.conf.urls import url
from emotion import views

urlpatterns=[
    url('mp/',views.musicplay),
    url('like/(?P<idd>\w+)',views.like,name='like'),

]