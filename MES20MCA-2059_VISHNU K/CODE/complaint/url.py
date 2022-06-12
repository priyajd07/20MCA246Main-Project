from django.conf.urls import url
from complaint import views

urlpatterns = [
    url('post_comp/', views.complaint),
    url('view_comp/', views.view_comp),
    url('post_reply/(?P<idd>\w+)',views.post_reply,name="repcomp"),
    url(r'^android/', views.comp_view.as_view())
]