from django.db import models

class Login(models.Model):
    username = models.CharField(max_length=30)
    password = models.CharField(max_length=30)
    u_id = models.IntegerField()
    type = models.CharField(max_length=30)

    class Meta:
        # managed = False
        db_table = 'login'
