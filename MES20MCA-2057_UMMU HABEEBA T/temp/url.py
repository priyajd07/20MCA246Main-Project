from django.conf.urls import url
from temp import views

urlpatterns = [
    url(r'^admin/', views.admin),
    url(r'^adminform/', views.adminform),
    url(r'^counsellor/', views.counsellor),
    url(r'^counsellorform/', views.counsellorform),
    url(r'^user/', views.user),
    url(r'^userform/', views.userform),
    url(r'^home/', views.home),
    url(r'^homeform/', views.homeform),
    url(r'^viewp/', views.viewP, name='viewp'),
    url(r'^viewc/(?P<idd>\w+)', views.viewC, name='viewc'),
    url(r'^createc/(?P<idd>\w+)', views.createC, name='createc'),
    url(r'^viewProfile/(?P<idd>\w+)', views.viewProfile, name='viewProfile'),
    url(r'^updateProfile/(?P<idd>\w+)', views.update, name='updateProfile'),
    # url(r'^update/(?P<idd>\w+)', views.update, name='update'),
    url(r'^myProfile/', views.myProfile, name='myProfile'),

]