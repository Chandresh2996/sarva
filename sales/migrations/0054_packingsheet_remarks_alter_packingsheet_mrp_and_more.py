# Generated by Django 4.0.5 on 2022-12-28 07:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0053_alter_rso_rso_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='packingsheet',
            name='remarks',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
        migrations.AlterField(
            model_name='packingsheet',
            name='mrp',
            field=models.CharField(default=0, max_length=51),
        ),
        migrations.AlterField(
            model_name='packingsheet',
            name='offermrp',
            field=models.CharField(default=0, max_length=51),
        ),
    ]