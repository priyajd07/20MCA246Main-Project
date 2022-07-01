from django.db import models
from user.models import User
from friendrequest.models import Friend
from counsellor.models import Counsellor
class Message(models.Model):
    m_id = models.AutoField(primary_key=True)
    m_content = models.CharField(max_length=200)
    u_id = models.IntegerField()
    # f_id = models.IntegerField()
    f=models.ForeignKey(User,to_field='u_id',on_delete=models.CASCADE)
    class Meta:
        managed = False
        db_table = 'message'

class Cmessage(models.Model):
    m_id = models.AutoField(primary_key=True)
    # u_id = models.IntegerField()
    u = models.ForeignKey(User, to_field='u_id', on_delete=models.CASCADE)
    # c_id = models.IntegerField()
    c = models.ForeignKey(Counsellor, to_field='c_id', on_delete=models.CASCADE)
    m_content = models.CharField(max_length=30)
    m_time = models.TimeField()
    m_date = models.DateField()
    sendby = models.IntegerField()

    class Meta:
        # managed = False
        db_table = 'cmessage'
