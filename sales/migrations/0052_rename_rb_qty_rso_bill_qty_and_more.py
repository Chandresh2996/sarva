# Generated by Django 4.0.6 on 2022-12-22 05:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0051_rename_rb_qty_rsoitems_billed_qty_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='rso',
            old_name='rb_qty',
            new_name='bill_qty',
        ),
        migrations.RenameField(
            model_name='rso',
            old_name='rf_qty',
            new_name='free_qty',
        ),
    ]