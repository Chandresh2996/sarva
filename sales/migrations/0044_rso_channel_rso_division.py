# Generated by Django 4.0.6 on 2022-12-20 06:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sales', '0043_qdn_buyer_qdn_buyer_address1_qdn_buyer_address2_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='rso',
            name='channel',
            field=models.CharField(default=1, max_length=51),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='rso',
            name='division',
            field=models.CharField(default=1, max_length=51),
            preserve_default=False,
        ),
    ]