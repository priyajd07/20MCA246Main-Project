from django.conf.urls import url
from message import views

urlpatterns=[
    url('^createm/(?P<idd>\w+)', views.createMessage,name="reply"),
    url('^createmc/(?P<idd>\w+)', views.createMessageC,name="replyC"),
    url('^createmu/(?P<idd>\w+)', views.createMessageU,name="replyU"),
    url('^chatwithC/(?P<idd>\w+)', views.createnewC,name="chatwithC"),
    url('^createnewmessage/', views.createnew, name="createnew"),
    url('^createnewC/', views.createnewmessage, name="createnewC"),
    url('^chat/(?P<idd>\w+)', views.chatWithUser, name='chat'),
    url('^chatc/(?P<idd>\w+)', views.chatWithC, name='chatC'),
    url('^chatu/(?P<idd>\w+)', views.chatWithU, name='chatU'),
    url('^inbox/(?P<idd>\w+)', views.inbox, name="inbox"),
    url('^alertmessage/(?P<idd>\w+)/(?P<isd>\w+)', views.alertmessage, name="alertmessage"),
    url('^viewflist/',views.viewFriendsList),
    url('^viewclist/',views.viewCounList),
    url('^viewulist/',views.viewUList),
]