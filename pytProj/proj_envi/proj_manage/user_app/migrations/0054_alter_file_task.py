# Generated by Django 5.1.4 on 2025-01-02 07:53

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0053_fileassignment'),
    ]

    operations = [
        migrations.AlterField(
            model_name='file',
            name='task',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='files', to='user_app.task'),
        ),
    ]
