from django.db import models

# Create your models here.
class Mechanic(models.Model):
    mech_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    phone_no = models.CharField(max_length=11)
    address = models.CharField(max_length=100)
    specilization = models.CharField(max_length=100)
    status = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'mechanic'


