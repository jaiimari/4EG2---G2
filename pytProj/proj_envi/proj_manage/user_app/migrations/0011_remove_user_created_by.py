# Generated by Django 5.1.4 on 2024-12-16 02:20

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0010_user_created_by'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='created_by',
        ),
    ]
