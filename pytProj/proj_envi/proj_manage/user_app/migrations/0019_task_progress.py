# Generated by Django 5.1.4 on 2024-12-31 01:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0018_remove_task_progress'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='progress',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
