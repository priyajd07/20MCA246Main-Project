from django.conf.urls import url
from friend import views

urlpatterns=[
    url('^addf/',views.addFriends),
    url('^alertf/(?P<idd>\w+)',views.alertFriends,name='alertf'),
    url('^managef/',views.manageFreinds),
    url('^viewf/',views.viewFriends),
    url('^fAccept/(?P<idd>\w+)',views.fAccept,name="fAccept"),
    url('^fReject/(?P<idd>\w+)',views.fReject,name="fReject"),
    url('^fRequest/(?P<idd>\w+)',views.fRequest, name="fReequest"),
]