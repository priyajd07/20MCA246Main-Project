from django.conf.urls import url
from temp import views

urlpatterns=[
    url('^temp/',views.index),
    url('^admin/',views.admin),
    url('^sample/',views.sample),

    ]
