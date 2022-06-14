from django.conf.urls import url
from items import views

urlpatterns=[
    url('^items/',views.items),
    url('^show/',views.show_items),
    url('^viewitems',views.viewitems),
]