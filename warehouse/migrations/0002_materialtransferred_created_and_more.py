# Generated by Django 4.0.6 on 2022-09-15 09:48

from django.db import migrations, models
import django.utils.timezone



class Migration(migrations.Migration):

    dependencies = [
        ('warehouse', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='materialtransferred',
            name='created',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='materialtransferred',
            name='updated',
            field=models.DateField(auto_now=True),
        ),
        migrations.AddField(
            model_name='shortagedamageentry',
            name='created',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='shortagedamageentry',
            name='updated',
            field=models.DateField(auto_now=True),
        ),
        migrations.AddField(
            model_name='stock_summary',
            name='created',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='stock_summary',
            name='updated',
            field=models.DateField(auto_now=True),
        ),
    ]