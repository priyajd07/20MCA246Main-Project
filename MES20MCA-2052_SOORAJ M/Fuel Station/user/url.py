from django.conf.urls import url
from user import views

urlpatterns=[
    url('^User/',views.user),
    url(r'^android/', views.user_view.as_view()),
]
