from django.db import models

# Create your models here.
class Complaint(models.Model):
    c_id = models.AutoField(primary_key=True)
    complaint = models.CharField(max_length=100)
    reply = models.CharField(max_length=100)
    u_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'complaint'

