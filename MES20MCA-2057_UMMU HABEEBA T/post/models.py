from django.db import models
from user.models import User
# from comment.models import Comment
class Post(models.Model):
    p_id = models.AutoField(primary_key=True)
    p_pic = models.CharField(max_length=500)
    u = models.ForeignKey(User,on_delete=models.CASCADE)
    status = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'post'

class Status(models.Model):
    s_id = models.AutoField(primary_key=True)
    # p_id = models.IntegerField()
    p=models.ForeignKey(Post,to_field='p_id',on_delete=models.CASCADE,related_name="pic")
    u_id = models.IntegerField()
    statusu = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'status'
