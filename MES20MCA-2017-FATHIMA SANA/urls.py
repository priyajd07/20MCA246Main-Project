from django.urls import path
from breakdown.views import *
from . import views

urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('register/', RegisterView.as_view(), name='reg'),
    path('registerlist/', RegisterListView.as_view(), name='registerlist'),
    path('login/', UserLogin.as_view(), name='login'),
    path('logout/', views.logout_view, name='logout'),
    # path('cutomerhome/',CustomerHome.as_view(),name='offer'),
    path('add/service/',AddServiceView.as_view(),name='addservice'),
    path('userhome/',UserView.as_view(),name='userhome'),
    path('request/',RequestView.as_view(),name='request'),
    path('services/',ServieListView.as_view(),name='services'),
    path('dashboard/',AdminView.as_view(),name='dashboard'),
    path('staff/',StaffView.as_view(),name='staff'),
    path('mechdashboard/',MechView.as_view(),name='mechdashboard'),
    path('stafflist/',StaffListView.as_view(),name='stafflist'),
    path('booking/<int:pk>',ServiceBookingView.as_view(),name='book'),
    path('paymenthandler/', views.paymenthandler, name='paymenthandler'),
    path('pay/', PaymentView.as_view(), name='pay'),
    path('feedback/',FeedbackView .as_view(), name='feedback'),
    path('feedbacklist/',FeedbackListView .as_view(), name='feedbacklist'),
    path('readmore/',ReadView.as_view(), name='readmore'),
    path('choice/', BookingListView.as_view(), name='choice'),
    path('update/<int:pk>', UpadateStatusView.as_view(), name='update'),
    path('requestlist', RequestListView.as_view(), name='requestlist'),
    path('pendinglist', PendingListView.as_view(), name='pendinglist'),
    path('progresslist', ProgressListView.as_view(), name='progresslist'),
    path('donelist', DoneListView.as_view(), name='donelist'),
    path('workstatus',  WorkStatusView.as_view(), name='workstatus'),
    path('mechassign/<int:pk>',MechanicAssignView.as_view(), name='mechassign'),
    path('mechpendinglist',MechPendingListView.as_view(), name='mechpendinglist'),
    path('mechprogresslist',MechProgressListView.as_view(), name='mechprogresslist'),
    path('mechdonelist',mechDoneListView.as_view(), name='mechdonelist'),



    
    


]

