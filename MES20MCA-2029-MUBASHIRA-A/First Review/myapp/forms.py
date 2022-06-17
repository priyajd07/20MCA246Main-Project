from django import forms
from myapp.models import *
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class UserRegisterForm(UserCreationForm):
	class Meta:
		model=User
		fields=["username","first_name",'last_name',"email","password1","password2"]

class CategoryForm(forms.ModelForm):
	class Meta:
		model=CategoryModel
		fields=["name"]

class QuestionForm(forms.ModelForm):
	class Meta:
		model=QuestionModel
		fields=["qn","group","pic"]

class AnswerForm(forms.ModelForm):
	class Meta:
		model=AnswerModel
		fields=["answer","pic"]
		
# """class ExtendedUserForm(forms.ModelForm):
# 	class Meta:
# 		model=UserRegisterModel
# 		fields=["address"]"""