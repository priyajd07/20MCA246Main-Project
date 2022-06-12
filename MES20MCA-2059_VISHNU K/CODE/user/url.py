from django.conf.urls import url
from user import views

urlpatterns = [
    url('^user_reg/', views.user_reg),
    url(r'^android/', views.user_view.as_view()),
    url('view_user/', views.view_user)

]