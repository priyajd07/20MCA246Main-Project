from django.conf.urls import url
from doctor import views

urlpatterns = [
    url('doc_reg/', views.doc_reg),
    url('doc/', views.doc),
]