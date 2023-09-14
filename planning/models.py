from django.db import models
from auditlog.registry import auditlog
from inventory.models import Product_master

class Bom(models.Model):

    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)
    description                     = models.TextField()
    last_date                       = models.DateField(null=True, blank=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['product']

class BomItems(models.Model):

    bom                             = models.ForeignKey(Bom, on_delete=models.PROTECT)
    item                            = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    qty                             = models.DecimalField(max_digits=24, decimal_places=4)

    def __str__(self) -> str:
        return self.bom.name

    class Meta:
        ordering = ['bom']

class JobOrder(models.Model):

    options = (
        ('1','Active'),
        ('2','In Progress'),
        ('3','Completed')
    )
    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)
    company                         = models.ForeignKey("company.Company", verbose_name=("Company"), on_delete=models.CASCADE)

    no                              = models.CharField(("Job Order No"), max_length=150)
    name                            = models.CharField(verbose_name=("Job Name"), max_length=100)
    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="jobcard")
    bom                             = models.ForeignKey(Bom, on_delete=models.PROTECT, related_name="jobcard")
    qty                             = models.DecimalField(max_digits=25, decimal_places=4)
    remain_qty                      = models.DecimalField(max_digits=25, decimal_places=4)
    date                            = models.DateField(verbose_name=("Job Card Date"), auto_now=False, auto_now_add=False)
    due_date                        = models.DateField()
    ref                             = models.CharField(verbose_name=("Reference"), max_length=150)
    details                         = models.CharField(verbose_name=("Details"), max_length=150)
    category                        = models.CharField(verbose_name=("Category"), max_length=150)

    issuedby                        = models.CharField(verbose_name="Issued By", max_length=151)
    remarks                         = models.TextField()
    status                          = models.CharField(max_length=1, choices=options, default=1)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['-date']


class SalesProjection(models.Model):

    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)

    product                         = models.ForeignKey("inventory.Product_master", verbose_name=("Product"), on_delete=models.CASCADE)
    p_qty                           = models.DecimalField(max_digits=15, decimal_places=4)
    a_qty                           = models.DecimalField(max_digits=15, decimal_places=4)
    division                        = models.ForeignKey("ledgers.Division", verbose_name=("Division"), on_delete=models.CASCADE)
    from_date                       = models.DateField(("From Date"), auto_now=False, auto_now_add=False)
    to_date                         = models.DateField(("To Date"), auto_now=False, auto_now_add=False)

    class Meta:
        unique_together = ('product','division','from_date', 'to_date')
        ordering = ['product']


auditlog.register(Bom)
auditlog.register(BomItems)
auditlog.register(JobOrder)
auditlog.register(SalesProjection)
