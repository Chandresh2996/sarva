# Generated by Django 4.0.6 on 2022-09-07 10:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0009_rso_rso_ref'),
    ]

    operations = [
        migrations.AlterField(
            model_name='salesorder',
            name='created',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='salesorder',
            name='updated',
            field=models.DateTimeField(auto_now=True),
        ),
    ]
