# Generated by Django 5.1.4 on 2024-12-31 01:50

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0023_task_progress'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='task',
            name='progress',
        ),
    ]
