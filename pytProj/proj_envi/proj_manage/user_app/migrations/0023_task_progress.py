# Generated by Django 5.1.4 on 2024-12-31 01:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0022_remove_task_progress'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='progress',
            field=models.DecimalField(decimal_places=2, default=0, max_digits=5),
        ),
    ]
