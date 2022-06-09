from django import forms
from .models import registration



class registerform(forms.ModelForm):
    class Meta:
        model=registration
        fields=('firstname','lastname','email','username','password','phone')
        widigets={
                    'firstname':forms.TextInput(attrs={'class' :'form-control'}),
                    'lastname':forms.TextInput(attrs={'class' :'form-control'}),
                    'email':forms.TextInput(attrs={'class' :'form-control'}),
                    'username':forms.TextInput(attrs={'class' :'form-control'}),
                    'password':forms.TextInput(attrs={'class' :'form-control'}),
                    'phone':forms.TextInput(attrs={'class' :'form-control'}),
        }          


    