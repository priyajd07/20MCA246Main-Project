from django.conf.urls import url
from temp import views

urlpatterns=[
    url('home/',views.hom),
    url('flst',views.fuels),
    url('admin',views.Adm),
]