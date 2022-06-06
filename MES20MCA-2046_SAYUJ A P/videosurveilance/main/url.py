from django.conf.urls import url
from main import views

urlpatterns=[
    url('^main/',views.mainn),
    url('^index/',views.index),
]