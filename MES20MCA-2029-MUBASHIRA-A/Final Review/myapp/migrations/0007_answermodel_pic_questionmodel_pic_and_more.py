# Generated by Django 4.0.5 on 2022-06-06 06:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0006_alter_answermodel_answer_alter_questionmodel_qn'),
    ]

    operations = [
        migrations.AddField(
            model_name='answermodel',
            name='pic',
            field=models.ImageField(blank=True, upload_to='anspic/'),
        ),
        migrations.AddField(
            model_name='questionmodel',
            name='pic',
            field=models.ImageField(blank=True, upload_to='qnpic/'),
        ),
        migrations.AlterField(
            model_name='answermodel',
            name='approval_status',
            field=models.CharField(choices=[('approval', 'Approval'), ('pending', 'Pending'), ('reject', 'Reject')], default='pending', max_length=30),
        ),
    ]
