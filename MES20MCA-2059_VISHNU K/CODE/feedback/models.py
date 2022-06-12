from django.db import models

# Create your models here.
class Feedback(models.Model):
    f_id = models.AutoField(primary_key=True)
    feedback = models.CharField(max_length=1000)
    u_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'feedback'

