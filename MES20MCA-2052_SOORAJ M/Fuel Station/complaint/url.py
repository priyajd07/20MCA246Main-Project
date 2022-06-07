from django.conf.urls import url
from complaint import views

urlpatterns=[
    url('^com/',views.vcomplaint),
    url('reply/(?P<idd>\w+)',views.reply,name="reply"),
    url(r'^android/', views.comp_view.as_view()),
]
