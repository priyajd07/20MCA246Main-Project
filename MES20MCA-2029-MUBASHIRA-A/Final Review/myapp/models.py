from django.db import models
from django.contrib.auth.models import User
from django.views import View

# Create your models here.
class CategoryModel(models.Model):
	name=models.CharField(max_length=30)
	status=models.BooleanField(default=True)
	created_on=models.DateTimeField(auto_now=True)

	def __str__(self):
		return self.name

class QuestionModel(models.Model):
	user=models.ForeignKey(User,on_delete=models.CASCADE)
	qn=models.TextField(max_length=1000)
	pic=models.ImageField(upload_to="qnpic/",blank=True)
	group=models.ForeignKey(CategoryModel,on_delete=models.CASCADE)
	status=models.BooleanField(default=True)
	created_on=models.DateTimeField(auto_now=True)
	updated_on=models.DateTimeField(auto_now=True)

	def __str__(self):
		return self.qn


Approval=(
	('approval','Approval'),
	('pending','Pending'),
	('reject','Reject'),
)
class AnswerModel(models.Model):
	user=models.ForeignKey(User,on_delete=models.CASCADE)
	qn=models.ForeignKey(QuestionModel,on_delete=models.CASCADE)
	answer=models.TextField(max_length=1000)
	pic=models.ImageField(upload_to="anspic/",blank=True)
	approval_status=models.CharField(max_length=30,choices=Approval,default='pending')
	status=models.BooleanField(default=True)
	created_on=models.DateTimeField(auto_now=True)
	up_vote=models.IntegerField(default=0)
	down_vote=models.IntegerField(default=0)

	def __str__(self):
		return self.answer

"""
class UserRegisterModel(models.Model):
	user=models.OneToOneField(User,on_delete=models.CASCADE)
	address=models.TextField(max_length=80)
	status=models.BooleanField(default=True)
	created_on=models.DateTimeField(auto_now=True)

	def __str__(self):
		return (self.user.first_name+" "+self.user.last_name)"""

# chat
class Message(models.Model):

    sender = models.ForeignKey(User, related_name="sent_messages", on_delete=models.CASCADE)
    receiver = models.ForeignKey(User, related_name="received_messages", on_delete=models.CASCADE)
    message = models.TextField()
    seen = models.BooleanField(default=False)
    date_created = models.DateTimeField(auto_now=True)

    def __str__(self):
        return str(self.sender)

# UpVotes
class UpVote(models.Model):
    answer=models.ForeignKey(AnswerModel,on_delete=models.CASCADE)
    user=models.ForeignKey(User,on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

# DownVotes
class DownVote(models.Model):
    answer=models.ForeignKey(AnswerModel,on_delete=models.CASCADE)
    user=models.ForeignKey(User,on_delete=models.CASCADE)

    def __str__(self):
        return str(self.id)

#comment
class Comment(models.Model):
    answer=models.ForeignKey(AnswerModel,on_delete=models.CASCADE)
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    comment=models.TextField(default='')
    add_time=models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.comment

