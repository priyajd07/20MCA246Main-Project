from django.conf.urls import url
from temp import views

urlpatterns = [
    url('hom/',views.home),
    url('adm/',views.admin),
    url('usr/',views.user),
]