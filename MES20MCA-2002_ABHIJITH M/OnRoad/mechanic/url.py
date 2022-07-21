from django.conf.urls import url
from mechanic import views

urlpatterns=[
    url('^mechreg/',views.mech_reg),
    url('^viewitems/',views.viewitems),
    url('arv/(?P<idd>\w+)',views.aprove,name='aprv'),
    url('rej/(?P<idd>\w+)',views.reject,name='reject')
]