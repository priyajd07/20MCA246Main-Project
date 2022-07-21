from django.db import models

# Create your models here.
class Delivary(models.Model):
    d_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=20)
    password = models.CharField(max_length=11)
    address = models.CharField(max_length=100)
    phone = models.CharField(max_length=11)
    email = models.CharField(max_length=50)
    status = models.CharField(max_length=11)
    img = models.CharField(max_length=1000)
    vechicle = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'delivary'

