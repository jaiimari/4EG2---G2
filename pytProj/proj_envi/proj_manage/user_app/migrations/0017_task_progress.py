# Generated by Django 5.1.4 on 2024-12-31 01:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0016_remove_task_progress_percentage_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='progress',
            field=models.FloatField(default=0),
        ),
    ]
