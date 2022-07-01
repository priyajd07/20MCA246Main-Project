from django.db import models

# Create your models here.
class User(models.Model):
    user_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=20)
    address = models.CharField(max_length=100)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'user'
