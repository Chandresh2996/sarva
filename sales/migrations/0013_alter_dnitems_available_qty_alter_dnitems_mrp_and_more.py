# Generated by Django 4.0.6 on 2022-09-21 07:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0012_alter_delivery_note_buyer_gstin_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dnitems',
            name='available_qty',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='dnitems',
            name='mrp',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='dnitems',
            name='pack',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='invitems',
            name='available_qty',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='invitems',
            name='mrp',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='invitems',
            name='pack',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='soitems',
            name='available_qty',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='soitems',
            name='mrp',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
        migrations.AlterField(
            model_name='soitems',
            name='pack',
            field=models.DecimalField(decimal_places=2, max_digits=15),
        ),
    ]
