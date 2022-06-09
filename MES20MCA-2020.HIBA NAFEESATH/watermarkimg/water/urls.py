from django.urls import path
from.import views


urlpatterns=[
    
    path('',views.index,name="index"),
    path('index/',views.index,name="index"),
    path('register/',views.register,name="register"),
    path('login/',views.login,name="login"),
    path('log/',views.log,name="log"),
    path('home/',views.home,name="home"),
    path('image/',views.image,name="image"),
    path('thanku/',views.thanku,name="thanku"),
    
    
]