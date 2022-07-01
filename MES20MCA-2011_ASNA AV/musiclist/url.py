from django.conf.urls import url
from musiclist import views

urlpatterns=[
    url('^ml/',views.Music),
    url('^vml/',views.viewmusic),

]