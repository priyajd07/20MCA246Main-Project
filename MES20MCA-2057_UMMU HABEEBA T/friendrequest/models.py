from django.db import models
from friend.models import Friend
from user.models import User
class Friendrequest(models.Model):
    req_id = models.AutoField(primary_key=True)
    # f_id = models.IntegerField()
    f = models.ForeignKey(User, to_field='u_id', on_delete=models.CASCADE,related_name='f1')
    # u_id = models.IntegerField()
    u = models.ForeignKey(User, to_field='u_id', on_delete=models.CASCADE,related_name='f2')
    status = models.CharField(max_length=30)

    class Meta:
        # managed = False
        db_table = 'friendRequest'
