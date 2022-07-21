from django.conf.urls import url
from delivery import views

urlpatterns=[
    url('dreg/',views.delreg),
    url('viewd/',views.viewd),
    url('arv/(?P<idd>\w+)', views.approve, name='approved'),
    url('rej/(?P<idd>\w+)', views.reject, name='rejected'),
    url('randroid/', views.deli_view.as_view()),
    url('dandroid/', views.deli_boyview.as_view()),
    url('updstatus/', views.deli_updstatus.as_view()),
    url('fileup/',views.simple_upload),

]
