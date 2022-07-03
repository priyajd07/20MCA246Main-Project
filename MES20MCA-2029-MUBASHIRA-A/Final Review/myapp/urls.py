from django.urls import path
from .views import*

urlpatterns = [
    path('', index.as_view(), name='index'),
    path('register/',RegisterView.as_view(), name='register'),
    path('login/', UserLogin.as_view(), name='login'),
    path('logout/', logout_view, name='logout'),
    path('contact.html/', contact, name='contact'),
    path('dash/', AdminIndex.as_view(), name='dash'),
    path('addcategory/', CategoryView.as_view(), name='addcategory'),
    path('addqn/', QuestionView.as_view(), name='addqn'),
    path('addans/<int:pk>', AnswerView.as_view(), name='addans'),
    path('qnlist/', QuestionList.as_view(), name='qnlist'),
    path('answers/<int:pk>', Answers.as_view(), name='answers'),
    path('addans/', AnswerView.as_view(), name='addans'),
    path("<int:pk>/", chatroom, name="chatroom"),
    path("ajax/<int:pk>/",ajax_load_messages, name="chatroom-ajax"),
    path('save-upvote',save_upvote,name='save-upvote'),
    path('save-downvote',save_downvote,name='save-downvote'),
    path('save-comment',save_comment,name='save-comment'),
    path('userlist/', UserList.as_view(), name='userlist'),
    path('categorylist/<int:pk>', CategoryList.as_view(), name='categorylist'),
    path('pendinglist/', PendingList.as_view(), name='pendinglist'),
    path('pending/update/<int:pk>', updatependinganswer.as_view(), name='pendingupdate'),
    path('search/',search,name='search'),
]