from django.db import models
from auditlog.registry import auditlog

class Godown(models.Model):

    parent                          = models.ForeignKey("self", on_delete=models.PROTECT, default=1, null=True,blank=True)
    godown_type                     = models.BooleanField(default=False)
    name                            = models.CharField(max_length=151, unique=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['godown_type', 'name']


class Brand(models.Model):

    under                           = models.CharField(max_length=151, default="Primary")
    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, unique=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return str(self.name)

    class Meta:
        ordering = ['name']

class SubBrand(models.Model):

    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, blank=True, null=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Category(models.Model):

    under                           = models.CharField(max_length=151, default="Primary")
    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, blank=True, null=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Class(models.Model):

    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, blank=True, null=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class SubClass(models.Model):
    
    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, blank=True, null=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class ProductType(models.Model):

    name                            = models.CharField(max_length=151, unique=True)
    code                            = models.CharField(max_length=151, blank=True, null=True)

    dl_sales                        = models.ForeignKey("ledgers.LedgersType", on_delete=models.PROTECT,default="1", related_name="product_type_sales_ledger")
    dl_purchase                     = models.ForeignKey("ledgers.LedgersType", on_delete=models.PROTECT,default="1", related_name="product_type_purchase_ledger")

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Uqc(models.Model):

    name                            = models.CharField(max_length=151)
    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class UnitOfMeasure(models.Model):

    uqc                             = models.ForeignKey(Uqc, on_delete=models.PROTECT)
    uom_type                        = models.CharField(max_length=151, null=True, blank=True)
    symbol                          = models.CharField(max_length=151)
    name                            = models.CharField(max_length=151, unique=True)
    decimal_places                  = models.DecimalField(decimal_places=0, max_digits=1)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.symbol

    class Meta:
        ordering = ['name']

class Scheme(models.Model):
    
    options = (
        ('1', 'Type 1'),
        ('2', 'Type 2'),
        ('3', 'Type 3'),
        ('4', 'Type 4'),
    )
    name = models.CharField(max_length=151, choices=options)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        ordering = ['name']

class Product_master(models.Model):

    cm_options = (('2', 'At Zero Cost'), ('1', 'Avg. Cost'), ('3', 'FIFO'), ('4', 'FIFO Perpetual'), ('5',
                  'Last Purchase Cost'), ('6', 'LIFO Annual'), ('7', 'LIFO Perpetual'), ('8', 'Monthly Avg. Cost'), ('9', 'Std. Cost'))

    vm_options = (('1', 'Avg. Price'), ('2', 'Std. Price'),
                  ('3', 'Last Sale Price'), ('4', 'At Zero Price'))

    product_name                    = models.CharField(max_length=151, unique=True)
    product_code                    = models.CharField(max_length=151, unique=True)

    dl_sales                        = models.ForeignKey( "ledgers.LedgersType", on_delete=models.PROTECT, related_name="sales_ledger", null=True, blank=True)
    dl_purchase                     = models.ForeignKey( "ledgers.LedgersType", on_delete=models.PROTECT, related_name="purchase_ledger", null=True, blank=True)

    description                     = models.CharField(max_length=255, null=True, blank=True)
    notes                           = models.CharField(max_length=151, null=True, blank=True)

    brand                           = models.ForeignKey(Brand, on_delete=models.PROTECT)
    category                        = models.ForeignKey(Category, on_delete=models.PROTECT)
    product_class                   = models.ForeignKey(Class, on_delete=models.PROTECT, default=1)
    sub_class                       = models.ForeignKey(SubClass, on_delete=models.PROTECT, default=1)
    sub_brand                       = models.ForeignKey(SubBrand, on_delete=models.PROTECT, default=1)
    product_type                    = models.ForeignKey(ProductType, on_delete=models.PROTECT)

    units_of_measure                = models.ForeignKey( UnitOfMeasure, on_delete=models.PROTECT, related_name="uom")
    additional_units                = models.ForeignKey( UnitOfMeasure, on_delete=models.PROTECT, null=True, blank=True, related_name="adduom")

    is_saleable                     = models.BooleanField(default=False)
    is_batch                        = models.BooleanField(default=False)
    track_dom                       = models.BooleanField(default=False)
    exp_date                        = models.BooleanField(default=False)
    bill_of_material                = models.BooleanField(default=False)
    set_std_rate                    = models.BooleanField(default=False)

    costing_method                  = models.CharField( max_length=151, choices=cm_options, default=1)
    valuation_method                = models.CharField( max_length=151, choices=vm_options, default=1)

    article_code                    = models.CharField(max_length=151, unique=True)
    ean_code                        = models.CharField( max_length=151, null=True, blank=True)
    old_product_code                = models.CharField( max_length=151, null=True, blank=True)
    mrp                             = models.DecimalField(max_digits=15,decimal_places=2, null=True, blank=True)
    gst                             = models.DecimalField(max_digits=15,decimal_places=2, null=True, blank=True)
    hsn                             = models.CharField(max_length=10, null=True, blank=True)

    opening_balance                 = models.CharField(max_length=151, null=True, blank=True)

    shape_code                      = models.CharField(max_length=151, null=True, blank=True)
    size                            = models.CharField(max_length=151, null=True, blank=True)
    style_shape                     = models.CharField(max_length=151, null=True, blank=True)
    series                          = models.CharField(max_length=151, null=True, blank=True)
    pattern                         = models.CharField(max_length=151, null=True, blank=True)
    country_of_origin               = models.CharField(max_length=151, null=True, blank=True)
    color_shade_theme               = models.CharField(max_length=151, null=True, blank=True)
    inner_qty                       = models.DecimalField( max_digits=15, decimal_places=2, null=True, blank=True)
    outer_qty                       = models.DecimalField( max_digits=15, decimal_places=2, null=True, blank=True)
    imported_by                     = models.CharField(max_length=151, null=True, blank=True)
    mfd_by                          = models.CharField(max_length=151, null=True, blank=True)
    mkt_by                          = models.CharField(max_length=151, null=True, blank=True)
    product_portfolio               = models.CharField(max_length=151, null=True, blank=True)

    isgstapplicable                 = models.BooleanField(default=True)

    behaviour                       = models.BooleanField(default=False)
    ipd                             = models.BooleanField(default=False)
    ins                             = models.BooleanField(default=False)
    tsm                             = models.BooleanField(default=False)
    tpc                             = models.BooleanField(default=False)
    trs                             = models.BooleanField(default=False)

    created                         = models.DateField(auto_now_add=True,blank=True, null=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return str(self.product_code)

    class Meta:
        ordering = ['product_code']

class Std_rate(models.Model):

    options                         = (('1', 'Purchase Cost'), ('2', 'Sales Price'))

    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    rate_type                       = models.CharField(choices=options, max_length=20)
    applicable_from                 = models.DateField()
    rate                            = models.DecimalField(max_digits=15, decimal_places=2)
    uom                             = models.CharField(max_length=151, null=True, blank=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.product.product_name

    class Meta:
        unique_together = ('product','rate_type')

class Gst_list(models.Model):

    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name='gstdetail')
    applicable_from                 = models.DateField()
    discription                     = models.CharField(max_length=151,null=True, blank=True)
    hsncode                         = models.CharField(max_length=151,null=True, blank=True)
    is_Non_gst                      = models.BooleanField()
    calc_type                       = models.CharField(max_length=151)
    taxability                      = models.CharField(max_length=151)
    reverse_charge                  = models.BooleanField()
    input_credit_ineligible         = models.BooleanField()
    cgstrate                        = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                        = models.DecimalField(max_digits=4, decimal_places=2)
    igstrate                        = models.DecimalField(max_digits=4, decimal_places=2)
    suply_type                      = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)
    
    def __str__(self) -> str:
        return self.product.product_name

class Currency(models.Model):
    name = models.CharField(max_length=20)
    code = models.CharField(max_length=3)
    symbol = models.CharField(max_length=10)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

auditlog.register(Godown)
auditlog.register(Brand)
auditlog.register(SubBrand)
auditlog.register(Category)
auditlog.register(Class)
auditlog.register(SubClass)
auditlog.register(ProductType)
auditlog.register(Uqc)
auditlog.register(UnitOfMeasure)
auditlog.register(Scheme)
auditlog.register(Product_master)
auditlog.register(Std_rate)
auditlog.register(Gst_list)
auditlog.register(Currency)