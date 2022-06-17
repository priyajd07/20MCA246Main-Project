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
	updated_on=models.DateTimeField(auto_now=True)
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

