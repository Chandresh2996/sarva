# Generated by Django 4.0.6 on 2022-12-20 06:34

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0045_rename_rate_creditnoteitems_rates'),
    ]

    operations = [
        migrations.RenameField(
            model_name='creditnoteitems',
            old_name='rate_diff',
            new_name='rate',
        ),
    ]