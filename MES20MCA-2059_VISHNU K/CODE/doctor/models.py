from django.db import models

# Create your models here.
class Doctor(models.Model):
    d_id = models.AutoField(primary_key=True)
    doctor_name = models.CharField(db_column='doctor name', max_length=50)  # Field renamed to remove unsuitable characters.
    address = models.CharField(max_length=50)
    phone = models.IntegerField()
    email = models.CharField(max_length=20)
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'doctor'

