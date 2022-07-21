from django.conf.urls import url
from feedback import views

urlpatterns=[
    url('^viewfeed/',views.viewfeed),
    ]
