from dataclasses import field, fields
from xml.parsers.expat import model
from django import forms
from breakdown.models import FeedbackModel, RequestModel, ServiceModel,ServiceBookingModel
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from django.forms import widgets

class UserRegisterForm(UserCreationForm):
	class Meta:
		model=User
		fields=["username","first_name","last_name","password1","password2","email"]

class ServiceForm(forms.ModelForm):
	class Meta:
		model=ServiceModel
		fields=["service_name","description","service_charge"]
		
class RequestForm(forms.ModelForm):
	class Meta:
		model=RequestModel
		fields=["vehicle_no","vehicle_name","vehicle_brand","vehicle_model","problem_descripition","longitude","lattitude"]

class StaffRegisterForm(UserCreationForm):
	class Meta:
		model=User
		fields=["username","first_name","last_name","password1","password2","email"]

class DateInput(forms.DateInput):
	input_type='date'

class ServiceBookingForm(forms.ModelForm):
	class Meta:
		model=ServiceBookingModel
		fields=['pickup_date','address','place','num']
		widget={
			'pickup_date':DateInput()
			}
class FeedbackForm(forms.ModelForm):
	class Meta:
		model=FeedbackModel
		fields=['feedback','suggestions']



		