# Generated by Django 4.0.6 on 2022-12-22 04:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0010_alter_product_master_created'),
    ]

    operations = [
        migrations.AlterField(
            model_name='gst_list',
            name='hsncode',
            field=models.CharField(blank=True, max_length=151, null=True),
        ),
    ]