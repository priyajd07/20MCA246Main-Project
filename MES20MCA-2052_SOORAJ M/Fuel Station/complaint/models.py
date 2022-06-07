from django.db import models

# Create your models here.
class Complaint(models.Model):
    com_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    username = models.CharField(max_length=20)
    date = models.DateField()
    complaint = models.CharField(max_length=200)
    reply = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'complaint'



