"""Village URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.urls import path
from account.views import *
from . import views

urlpatterns = [
    path('', IndexView.as_view(), name='home'),
    path('register/', views.adduser, name='reg'),
    path('login/', UserLogin.as_view(), name='login'),
    path('logout/', views.logout_view, name='logout'),
    
    path('house/', HouseView.as_view(), name='house'),
    path('member/', MemberView.as_view(), name='member'),
    path('pet/', PetView.as_view(), name='pet'),
    path('vehicle/',VehicleView.as_view(), name='vehicle'),
    path('post/',PostView.as_view(), name='post'),
    path('userlist/',UserView.as_view(), name='userlist'),
    path('admindash/',AdmindashView.as_view(), name='admindash'),
    path('visitor/', VisitorView.as_view(), name='visitor'),
    path('staff/', StaffView.as_view(), name='staff'),
    path('visitorlist/', StaffListView.as_view(), name='visitorlist'),
    path('paymenthandler/', views.paymenthandler, name='paymenthandler'),
    path('pay/', PaymentView.as_view(), name='pay'),
    path('donation/', DonationView.as_view(), name='donate'),
    

    
]
