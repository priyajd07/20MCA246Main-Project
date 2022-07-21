from django.db import models

# Create your models here.
class Feedback(models.Model):
    fb_id = models.AutoField(primary_key=True)
    feedback = models.CharField(max_length=100)
    date = models.DateField()
    time = models.TimeField()
    user_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'feedback'
