from django.db import models

# Create your models here.
class Musiclist(models.Model):
    m_id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=50)
    type = models.CharField(max_length=50)
    filename = models.CharField(max_length=5000)
    likees = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'musiclist'
