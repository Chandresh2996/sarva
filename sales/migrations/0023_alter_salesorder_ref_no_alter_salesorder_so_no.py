# Generated by Django 4.0.6 on 2022-10-08 12:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0022_salesorder_shipto_pan_no'),
    ]

    operations = [
        migrations.AlterField(
            model_name='salesorder',
            name='ref_no',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
        migrations.AlterField(
            model_name='salesorder',
            name='so_no',
            field=models.CharField(max_length=51),
        ),
    ]
