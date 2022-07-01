from django.db import models

# Create your models here.
class Emotion(models.Model):
    em_id = models.AutoField(primary_key=True)
    emotion = models.CharField(max_length=50)
    images = models.CharField(max_length=100)
    u_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'emotion'

