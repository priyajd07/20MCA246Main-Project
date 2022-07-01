# Generated by Django 3.0.8 on 2022-06-20 11:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('user', '0001_initial'),
        ('counsellor', '0001_initial'),
        ('friend', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Message',
            fields=[
                ('m_id', models.AutoField(primary_key=True, serialize=False)),
                ('m_content', models.CharField(max_length=300)),
                ('m_pic', models.CharField(max_length=500)),
                ('m_date', models.DateField()),
                ('m_time', models.TimeField()),
                ('prev_id', models.IntegerField()),
                ('type', models.CharField(max_length=30)),
                ('f', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='friend.Friend')),
                ('u', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user.User')),
            ],
            options={
                'db_table': 'message',
            },
        ),
        migrations.CreateModel(
            name='Cmessage',
            fields=[
                ('m_id', models.AutoField(primary_key=True, serialize=False)),
                ('m_content', models.CharField(max_length=30)),
                ('m_time', models.TimeField()),
                ('m_date', models.DateField()),
                ('sendby', models.IntegerField()),
                ('c', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='counsellor.Counsellor')),
                ('u', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user.User')),
            ],
            options={
                'db_table': 'cmessage',
            },
        ),
    ]
