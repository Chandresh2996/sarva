# Generated by Django 4.0.6 on 2022-10-19 09:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ledgers', '0013_alter_party_contact_details_gst_registration_type_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='party_master',
            name='is_transporter',
            field=models.BooleanField(default=False),
        ),
    ]
