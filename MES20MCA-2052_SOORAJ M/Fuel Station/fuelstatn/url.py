from django.conf.urls import url
from fuelstatn import views

urlpatterns=[
    url('fuelstation/',views.fuelsreg),
    url('viewfs/',views.viewfs),
    url('arvd/(?P<idd>\w+)', views.approve, name='approve'),
    url('rejd/(?P<idd>\w+)', views.reject, name='reject'),
]
