from django.db import models

# Create your models here.
class Orderfuel(models.Model):
    order_id = models.AutoField(primary_key=True)
    date = models.DateField()
    u_id = models.IntegerField()
    fuel = models.CharField(max_length=20)
    qty = models.CharField(max_length=20)
    latitude = models.CharField(max_length=50)
    longitude = models.CharField(max_length=50)
    status = models.CharField(max_length=20)
    fs_id = models.IntegerField()
    phone = models.CharField(max_length=20)
    d_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'orderfuel'




class Payment(models.Model):
    p_id = models.AutoField(primary_key=True)
    amount = models.CharField(max_length=50)
    order_id = models.IntegerField()
    cardnumber = models.CharField(max_length=50)
    card_holdername = models.CharField(max_length=70)

    class Meta:
        managed = False
        db_table = 'payment'

