from django.conf.urls import url
from post import views

urlpatterns=[
    url('^createp/',views.createPost),
    url('^removep/',views.removePost),
    url('^blk/',views.blockpost),
    url('^viewpAdmin/',views.viewPostAdmin),
    url('^viewpUser/',views.viewPostUser),
    url('^viewCommentsAdmin/(?P<idd>\w+)', views.viewCommentsAdmin, name='viewCadmin'),
    url('^viewCommentsUser/(?P<idd>\w+)', views.viewCommentsUser, name='viewCuser'),
    url('^postComment/(?P<idd>\w+)', views.postComments, name='postComment'),
    url('^ap/(?P<idd>\w+)', views.ap, name='blockopen'),
]