from dataclasses import fields
from django import forms
from account.models import *
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class UserRegisterForm(UserCreationForm):
	class Meta:
		model=User
		fields=["username","password1","password2","email"]

class ExtendedUserForm(forms.ModelForm):
	class Meta:
		model=UserRegisterModel
		fields=["ward_no",'house_no','rationcard_no',"address",'phone_no']
  
# Registration of Visitors   
        
class VisitorForm(forms.ModelForm):
    class Meta:
        model=VisitorModel
        fields=["name",'email','address','phone_no']
  
class MemberForm(forms.ModelForm):
    class Meta:
        model=AddMemberModel
        fields=["name",'age','adhaar_no','designation']
        
#.....Add pet....


class PetForm(forms.ModelForm):
    class Meta:
        model=PetModel
        fields=["name",'type','Is_vaccinated','image']
        
# Registration of Vehicle

class VehicleForm(forms.ModelForm):
    class Meta:
        model=VehicleModel
        fields=["name",'email','address','phone_no','car_model','plate_number','image']
 
class DonationForm(forms.ModelForm):
        class Meta:
          model=DonationModel
          fields=['amount']

class PostForm(forms.ModelForm):
        class Meta:
          model=PostModel
          fields=['title','subtitle','image','type','description']

class PostForm(forms.ModelForm):
    class Meta:
        model=PostCategoryModel
        fields=['type']
        




# #....Post......
# class PostForm(forms.ModelForm):
#     class Meta:
#         model=PostModel
        
#.....Reserve Rent/Sell...
# Class ReserveForm(forms.ModelForm): 


#       
			
    