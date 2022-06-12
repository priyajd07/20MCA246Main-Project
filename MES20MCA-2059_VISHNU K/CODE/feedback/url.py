from django.conf.urls import url
from feedback import views

urlpatterns = [
    url('view_feedback/', views.view_feedback)
]