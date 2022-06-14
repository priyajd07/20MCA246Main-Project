from django.conf.urls import url
from complaint import views

urlpatterns=[
    url('^complaint/',views.complaint),
    url('view_comp/', views.view_comp),
    url('reply/(?P<idd>\w+)', views.post_reply, name="repcomp"),
    url('^viewreply/',views.viewreply),
]