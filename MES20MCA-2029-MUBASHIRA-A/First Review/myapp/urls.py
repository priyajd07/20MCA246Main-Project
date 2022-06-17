from django.urls import path
from .views import*

urlpatterns = [
    path('', index, name='index'),
    path('register/',RegisterView.as_view(), name='register'),
    path('login/', UserLogin.as_view(), name='login'),
    path('logout/', logout_view, name='logout'),
    path('contact.html/', contact, name='contact'),
    path('admindash/', adminindex, name='adminindex'),
    path('addcategory/', CategoryView.as_view(), name='addcategory'),
    path('addqn/', QuestionView.as_view(), name='addqn'),
    path('addans/<int:pk>', AnswerView.as_view(), name='addans'),
    path('qnlist/', QuestionList.as_view(), name='qnlist'),
    path('anslist/', AnswerList.as_view(), name='anslist'),
    path('answers/<int:pk>', Answers.as_view(), name='answers'),


]