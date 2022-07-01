from django.db import models

class User(models.Model):
    u_id = models.AutoField(primary_key=True)
    u_name = models.CharField(max_length=30)
    u_mobile = models.CharField(max_length=30)
    u_mail = models.CharField(max_length=50)
    u_location = models.CharField(max_length=30)
    u_dob = models.DateField()
    u_gender = models.CharField(max_length=30)
    u_uname = models.CharField(max_length=30)
    u_pass = models.CharField(max_length=30)
    u_profile_pic = models.CharField(max_length=500)
    u_status = models.CharField(max_length=10)

    class Meta:
        # managed = False
        db_table = 'user'
