# Generated by Django 4.0.5 on 2022-12-01 16:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0005_company_pinv_series'),
        ('sales', '0037_alter_invoice_carrier_agent_and_more'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='invoice',
            unique_together={('company', 'inv_no')},
        ),
    ]
