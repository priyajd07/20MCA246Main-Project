# Generated by Django 4.0.5 on 2022-06-03 16:14

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('myapp', '0002_delete_userregistermodel'),
    ]

    operations = [
        migrations.CreateModel(
            name='CategoryModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
                ('status', models.BooleanField(default=True)),
                ('created_on', models.DateTimeField(auto_now=True)),
            ],
        ),
    ]
