# Generated by Django 3.1.2 on 2021-12-15 04:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Draw', '0004_auto_20211215_1016'),
    ]

    operations = [
        migrations.AlterField(
            model_name='label',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, null=True),
        ),
        migrations.AlterField(
            model_name='label',
            name='updated_at',
            field=models.DateTimeField(auto_now=True, null=True),
        ),
    ]
