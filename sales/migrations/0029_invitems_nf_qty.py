# Generated by Django 4.0.6 on 2022-11-21 08:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0028_rename_new_qty_invitems_nb_qty'),
    ]

    operations = [
        migrations.AddField(
            model_name='invitems',
            name='nf_qty',
            field=models.DecimalField(decimal_places=2, default=0, max_digits=15),
        ),
    ]
