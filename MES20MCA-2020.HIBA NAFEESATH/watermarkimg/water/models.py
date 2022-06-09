from django.db import models

# Create your models here.
class registration(models.Model):
    firstname=models.CharField(max_length=200,null=True)
    lastname=models.CharField(max_length=200,null=True)
    email=models.CharField(max_length=200,null=True)
    username=models.CharField(max_length=200,null=True)
    password=models.CharField(max_length=200,null=True)
    phone=models.CharField(max_length=200,null=True)


