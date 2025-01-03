# Generated by Django 5.1.4 on 2025-01-01 09:06

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0049_notification_task_alter_notification_user'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='notification',
            name='task',
        ),
        migrations.AlterField(
            model_name='notification',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='notifications', to=settings.AUTH_USER_MODEL),
        ),
    ]