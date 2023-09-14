# Generated by Django 4.0.5 on 2022-08-26 17:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Brand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('under', models.CharField(default='Primary', max_length=151)),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(max_length=151, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('under', models.CharField(default='Primary', max_length=151)),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(blank=True, max_length=151, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Class',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(blank=True, max_length=151, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Godown',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('godown_type', models.BooleanField(default=False)),
                ('name', models.CharField(max_length=151)),
            ],
        ),
        migrations.CreateModel(
            name='Gst_list',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('applicable_from', models.DateField()),
                ('discription', models.CharField(blank=True, max_length=151, null=True)),
                ('hsncode', models.CharField(max_length=151)),
                ('is_Non_gst', models.BooleanField()),
                ('calc_type', models.CharField(choices=[('1', 'On Item Rate'), ('2', 'On Value')], max_length=151)),
                ('taxability', models.CharField(choices=[('1', 'Exempt'), ('2', 'Nil Rated'), ('3', 'Taxable')], max_length=151)),
                ('reverse_charge', models.BooleanField()),
                ('input_credit_ineligible', models.BooleanField()),
                ('cgstrate', models.DecimalField(decimal_places=2, max_digits=4)),
                ('sgstrate', models.DecimalField(decimal_places=2, max_digits=4)),
                ('igstrate', models.DecimalField(decimal_places=2, max_digits=4)),
                ('suply_type', models.CharField(choices=[('1', 'Goods'), ('2', 'Services')], max_length=151)),
            ],
        ),
        migrations.CreateModel(
            name='Product_master',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('product_name', models.CharField(max_length=151, unique=True)),
                ('product_code', models.CharField(max_length=151, unique=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
                ('notes', models.CharField(blank=True, max_length=151, null=True)),
                ('is_saleable', models.BooleanField(default=False)),
                ('is_batch', models.BooleanField(default=False)),
                ('track_dom', models.BooleanField(default=False)),
                ('exp_date', models.BooleanField(default=False)),
                ('bill_of_material', models.BooleanField(default=False)),
                ('set_std_rate', models.BooleanField(default=False)),
                ('costing_method', models.CharField(choices=[('2', 'At Zero Cost'), ('1', 'Avg. Cost'), ('3', 'FIFO'), ('4', 'FIFO Perpetual'), ('5', 'Last Purchase Cost'), ('6', 'LIFO Annual'), ('7', 'LIFO Perpetual'), ('8', 'Monthly Avg. Cost'), ('9', 'Std. Cost')], default=1, max_length=151)),
                ('valuation_method', models.CharField(choices=[('1', 'Avg. Price'), ('2', 'Std. Price'), ('3', 'Last Sale Price'), ('4', 'At Zero Price')], default=1, max_length=151)),
                ('article_code', models.CharField(max_length=151, unique=True)),
                ('ean_code', models.CharField(blank=True, max_length=151, null=True)),
                ('old_product_code', models.CharField(blank=True, max_length=151, null=True)),
                ('mrp', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('gst', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('hsn', models.CharField(blank=True, max_length=10, null=True)),
                ('opening_balance', models.CharField(blank=True, max_length=151, null=True)),
                ('shape_code', models.CharField(blank=True, max_length=151, null=True)),
                ('size', models.CharField(blank=True, max_length=151, null=True)),
                ('style_shape', models.CharField(blank=True, max_length=151, null=True)),
                ('series', models.CharField(blank=True, max_length=151, null=True)),
                ('pattern', models.CharField(blank=True, max_length=151, null=True)),
                ('country_of_origin', models.CharField(blank=True, max_length=151, null=True)),
                ('color_shade_theme', models.CharField(blank=True, max_length=151, null=True)),
                ('inner_qty', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('outer_qty', models.DecimalField(blank=True, decimal_places=2, max_digits=15, null=True)),
                ('imported_by', models.CharField(blank=True, max_length=151, null=True)),
                ('mfd_by', models.CharField(blank=True, max_length=151, null=True)),
                ('mkt_by', models.CharField(blank=True, max_length=151, null=True)),
                ('product_portfolio', models.CharField(blank=True, max_length=151, null=True)),
                ('isgstapplicable', models.BooleanField(default=True)),
                ('behaviour', models.BooleanField(default=False)),
                ('ipd', models.BooleanField(default=False)),
                ('ins', models.BooleanField(default=False)),
                ('tsm', models.BooleanField(default=False)),
                ('tpc', models.BooleanField(default=False)),
                ('trs', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='ProductType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(blank=True, max_length=151, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Scheme',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(choices=[('1', 'Type 1'), ('2', 'Type 2'), ('3', 'Type 3'), ('4', 'Type 4')], max_length=151)),
            ],
        ),
        migrations.CreateModel(
            name='SubBrand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(blank=True, max_length=151, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='SubClass',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=151, unique=True)),
                ('code', models.CharField(blank=True, max_length=151, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Uqc',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=151)),
            ],
        ),
        migrations.CreateModel(
            name='UnitOfMeasure',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uom_type', models.CharField(blank=True, max_length=151, null=True)),
                ('symbol', models.CharField(max_length=151)),
                ('name', models.CharField(max_length=151)),
                ('decimal_places', models.DecimalField(decimal_places=0, max_digits=1)),
                ('uqc', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.uqc')),
            ],
        ),
        migrations.CreateModel(
            name='Std_rate',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rate_type', models.CharField(choices=[('1', 'Purchase Cost'), ('2', 'Sales Price')], max_length=20)),
                ('applicable_from', models.DateField()),
                ('rate', models.DecimalField(decimal_places=2, max_digits=15)),
                ('uom', models.CharField(blank=True, max_length=151, null=True)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.product_master')),
            ],
        ),
        migrations.AddField(
            model_name='product_master',
            name='additional_units',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='adduom', to='inventory.unitofmeasure'),
        ),
        migrations.AddField(
            model_name='product_master',
            name='brand',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.brand'),
        ),
        migrations.AddField(
            model_name='product_master',
            name='category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='inventory.category'),
        ),
    ]
