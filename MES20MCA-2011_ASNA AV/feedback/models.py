from django.db import models
from user.models import User
# Create your models here.
class Feedback(models.Model):
    fd_id = models.AutoField(primary_key=True)
    feedback = models.CharField(max_length=100)
    date = models.DateField()
    time = models.TimeField()
    # user_id = models.IntegerField()
    user= models.ForeignKey(User, to_field='user_id', on_delete=models.CASCADE)
    class Meta:
        managed = False
        db_table = 'feedback'

