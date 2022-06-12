from django.db import models

# Create your models here.
class Complaints(models.Model):
    c_id = models.AutoField(primary_key=True)
    complaint = models.CharField(max_length=1000)
    reply = models.CharField(max_length=1000)
    u_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'complaints'
