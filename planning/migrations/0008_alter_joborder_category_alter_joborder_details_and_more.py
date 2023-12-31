# Generated by Django 4.0.5 on 2022-11-04 11:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('planning', '0007_alter_joborder_name'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joborder',
            name='category',
            field=models.CharField(max_length=150, verbose_name='Category'),
        ),
        migrations.AlterField(
            model_name='joborder',
            name='details',
            field=models.CharField(max_length=150, verbose_name='Details'),
        ),
        migrations.AlterField(
            model_name='joborder',
            name='issuedby',
            field=models.CharField(max_length=151, verbose_name='Issued By'),
        ),
        migrations.AlterField(
            model_name='joborder',
            name='no',
            field=models.CharField(max_length=150, verbose_name='Job Order No'),
        ),
        migrations.AlterField(
            model_name='joborder',
            name='ref',
            field=models.CharField(max_length=150, verbose_name='Reference'),
        ),
    ]
