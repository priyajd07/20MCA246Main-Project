from django.conf.urls import url
from orderfuel import views

urlpatterns=[
    url('^order/',views.vieworder),
    url(r'^android/', views.ord_view.as_view()),
    url(r'^bill/', views.payment.as_view()),
    url('^delb/(?P<idd>\w+)', views.viewdf,name='delb'),
    url('^assign/(?P<idd>\w+)', views.assign, name='assign'),
]
