# Generated by Django 4.0.6 on 2022-09-07 11:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0011_alter_invoice_shipto_gstin_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='delivery_note',
            name='buyer_gstin',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
        migrations.AlterField(
            model_name='delivery_note',
            name='shipto_gstin',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
        migrations.AlterField(
            model_name='salesorder',
            name='buyer_gstin',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
        migrations.AlterField(
            model_name='salesorder',
            name='shipto_gstin',
            field=models.CharField(blank=True, max_length=51, null=True),
        ),
    ]
