from django.conf.urls import url
from category import views
urlpatterns=[
    url('cat/',views.cat),

]