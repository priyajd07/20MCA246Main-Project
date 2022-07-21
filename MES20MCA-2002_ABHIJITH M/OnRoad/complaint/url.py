from django.conf.urls import url
from complaint import views

urlpatterns=[
    url('^viewcomp/',views.viewcomplaint),
    url('^reply/(?P<idd>\w+)',views.reply,name="reply"),
    ]
