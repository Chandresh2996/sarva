# Generated by Django 4.0.6 on 2022-11-08 10:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('warehouse', '0002_materialtransferred_created_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='stock_summary',
            name='batch',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
    ]
