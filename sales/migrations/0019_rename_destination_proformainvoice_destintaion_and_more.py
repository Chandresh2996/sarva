# Generated by Django 4.0.5 on 2022-10-03 05:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0018_alter_proformainvitems_inv'),
    ]

    operations = [
        migrations.RenameField(
            model_name='proformainvoice',
            old_name='destination',
            new_name='destintaion',
        ),
        migrations.AlterField(
            model_name='proformainvoice',
            name='status',
            field=models.CharField(choices=[('1', 'Active'), ('2', 'Cancelled'), ('3', 'Inovice')], default=1, max_length=20),
        ),
    ]
