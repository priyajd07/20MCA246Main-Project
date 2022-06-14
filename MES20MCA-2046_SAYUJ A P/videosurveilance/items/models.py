from django.db import models

# Create your models here.
class Items(models.Model):
    item_id = models.AutoField(primary_key=True)
    items = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'items'