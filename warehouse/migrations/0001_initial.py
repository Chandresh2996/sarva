# Generated by Django 4.0.5 on 2022-08-26 17:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('company', '0001_initial'),
        ('inventory', '0001_initial'),
        ('production', '0001_initial'),
        ('purchase', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Stock_summary',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('mrp', models.CharField(max_length=51)),
                ('batch', models.CharField(max_length=51)),
                ('rate', models.DecimalField(decimal_places=2, max_digits=15)),
                ('closing_balance', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('company', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='stock', to='company.company')),
                ('godown', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.godown')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.product_master')),
            ],
        ),
        migrations.CreateModel(
            name='ShortageDamageEntry',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('shoratage', models.CharField(choices=[('1', 'Purchase'), ('2', 'Warehouse'), ('3', 'Production')], max_length=2)),
                ('sqty', models.DecimalField(decimal_places=4, default=0, max_digits=15)),
                ('dqty', models.DecimalField(decimal_places=4, default=0, max_digits=15)),
                ('rate', models.DecimalField(decimal_places=2, max_digits=15)),
                ('sremarks', models.TextField()),
                ('dremarks', models.TextField()),
                ('godown', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.godown', verbose_name='Godown')),
                ('item', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.product_master')),
                ('jobwork', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='production.jobcard')),
                ('purchase', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='purchase.purchase')),
            ],
        ),
        migrations.CreateModel(
            name='MaterialTransferred',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('qty', models.DecimalField(decimal_places=4, max_digits=15)),
                ('rate', models.DecimalField(decimal_places=2, max_digits=15)),
                ('godown', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='material_transferred', to='inventory.godown', verbose_name='Godown')),
                ('indent', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='material_transferred', to='production.rmindent')),
                ('item', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='material_transferred', to='inventory.product_master')),
            ],
        ),
    ]
