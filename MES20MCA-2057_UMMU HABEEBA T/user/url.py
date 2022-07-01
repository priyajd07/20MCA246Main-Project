from django.conf.urls import url
from user import views

urlpatterns=[
    url('^block/',views.blockUnblockUser),
    url('^blockreport/',views.viewBlockReport),
    url('^userreg/',views.userRegisteration),
    url('^viewuAdmin/',views.viewUserAdmin),
    url('^viewuCounsellor/',views.viewUserCounsellor),
    url('^blockUser/(?P<idd>\w+)', views.blockUser, name="blockuser"),
    url('^unblockUser/(?P<idd>\w+)', views.unblockUser, name="unblockuser"),
]