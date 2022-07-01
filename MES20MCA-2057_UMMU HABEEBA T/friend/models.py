from django.db import models
from user.models import User

class Friend(models.Model):
    f_id = models.AutoField(primary_key=True)
    f_name = models.CharField(max_length=30)
    f_mobile = models.CharField(max_length=30)
    f_mail = models.CharField(max_length=50)
    f_gender = models.CharField(max_length=30)
    f_dob = models.DateField()
    f_location = models.CharField(max_length=30)
    f_uname = models.CharField(max_length=30)
    f_pass = models.CharField(max_length=30)
    f_profile_pic = models.CharField(max_length=500)
    # u = models.ForeignKey(User, to_field='u_id', on_delete=models.CASCADE)
    # a_id = models.IntegerField()
    status = models.CharField(max_length=50)

    class Meta:
        # managed = False
        db_table = 'friend'


