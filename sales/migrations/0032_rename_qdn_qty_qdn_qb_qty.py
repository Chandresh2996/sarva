# Generated by Django 4.0.6 on 2022-11-21 09:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0031_proformainvitems_nf_qty'),
    ]

    operations = [
        migrations.RenameField(
            model_name='qdn',
            old_name='qdn_qty',
            new_name='qb_qty',
        ),
    ]
