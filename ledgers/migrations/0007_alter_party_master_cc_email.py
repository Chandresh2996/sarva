# Generated by Django 4.0.6 on 2022-09-30 06:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ledgers', '0006_asm_created_asm_updated_currency_created_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='party_master',
            name='cc_email',
            field=models.TextField(blank=True, max_length=250, null=True),
        ),
    ]
