# Generated by Django 4.0.6 on 2022-11-04 08:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('planning', '0006_alter_joborder_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joborder',
            name='name',
            field=models.CharField(max_length=100, verbose_name='Job Name'),
        ),
    ]
