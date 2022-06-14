from django.conf.urls import url
from user import views

urlpatterns=[
    url('^userreg/',views.user_reg),
]