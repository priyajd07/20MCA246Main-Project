
from django.contrib.auth.models import User
from django.db import models

# Create your models here.

# class UserRegisterModel(models.Model):
# 	user=models.OneToOneField(User,on_delete=models.CASCADE)
# 	address=models.TextField(max_length=80)
# 	status=models.BooleanField(default=True)
# 	created_on=models.DateTimeField(auto_now=True)

# 	def __str__(self):
# 		return (self.user.first_name+" "+self.user.last_name)

class ServiceModel(models.Model):
    service_name=models.TextField(max_length=20)
    description=models.TextField(max_length=100)
    service_charge=models.CharField(max_length=20)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)

    def __str__(self):
        return (self.service_name)
        

class RequestModel(models.Model):
    username=models.ForeignKey(User,on_delete=models.CASCADE)
    vehicle_no=models.CharField(max_length=10,null=False)
    vehicle_name= models.CharField(max_length=40,null=False) 
    vehicle_brand= models.CharField(max_length=15,null=False) 
    vehicle_model= models.CharField(max_length=15,null=False) 
    problem_descripition=models.TextField(max_length=10,null=False)
    longitude = models.FloatField(default=0)
    lattitude = models.FloatField(default=0)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return str(self.username)


class ServiceBookingModel(models.Model):
    username=models.ForeignKey(User,on_delete=models.CASCADE)
    service_name=models.TextField(max_length=20)
    service_charge=models.CharField(max_length=20)
    payment_status=models.BooleanField(default=False)
    pickup_date=models.DateField(null=False)
    address=models.TextField(max_length=300,null=False)
    place=models.CharField(max_length=300,default='DEFAULT VALUE')
    num=models.IntegerField(default=0)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    type_choice=((' pending','pending'),
                  ('work_in_progress','work_in_progress'),
                  ('done','done'))
    type=models.CharField(max_length=20,choices=type_choice,default='pending') 
    mechanic = models.ForeignKey(User,limit_choices_to={'is_staff': True}, null=True,on_delete=models.CASCADE,related_name='mechanic_assigned')
                              
    
     
class FeedbackModel(models.Model):
    username=models.ForeignKey(User,on_delete=models.CASCADE)
    feedback=models.TextField(max_length=20,null=True)
    suggestions=models.TextField(max_length=20,null=True)


