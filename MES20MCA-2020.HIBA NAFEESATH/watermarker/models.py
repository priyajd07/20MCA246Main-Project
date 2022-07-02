# -*- coding: utf-8 -*-

from django.db import models
from django.utils.translation import gettext_lazy as _


class Watermark(models.Model):

    name = models.CharField(max_length=50, verbose_name=_("name"))
    image = models.ImageField(upload_to="watermarks", verbose_name=_("image"))
    is_active = models.BooleanField(default=True, blank=True, verbose_name=_("is active"))

    # for internal use...

    date_created = models.DateTimeField(auto_now_add=True)
    date_updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["name"]
        verbose_name = _("watermark")
        verbose_name_plural = _("watermarks")

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if self.is_active:
            # select all other active items
            qs = self.__class__.objects.filter(name__exact=self.name, is_active=True)
            # except self (if self already exists)
            if self.pk:
                qs = qs.exclude(pk=self.pk)
            # and deactive them
            qs.update(is_active=False)

        super(Watermark, self).save(*args, **kwargs)
from django.db import models

# Create your models here.
class registration(models.Model):
    firstname=models.CharField(max_length=200,null=True)
    lastname=models.CharField(max_length=200,null=True)
    email=models.CharField(max_length=200,null=True)
    username=models.CharField(max_length=200,null=True)
    password=models.CharField(max_length=200,null=True)
    phone=models.CharField(max_length=200,null=True)



