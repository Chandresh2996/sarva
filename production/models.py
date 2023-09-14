from django.utils import timezone
from django.db import models
from company.models import Company
from inventory.models import Product_master
from planning.models import Bom, JobOrder
from auditlog.registry import auditlog
from django.contrib.auth.models import User

class JobCard(models.Model):

    options = (
        ('1','Active'),
        ('2','RM Indent'),
        ('3','Material Transfer'),
        ('4','Closed'),
    )
    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)
    company                         = models.ForeignKey("company.Company", verbose_name=("Company"), on_delete=models.PROTECT)

    no                              = models.CharField(("Jobwork No"), max_length=50)
    joborder                        = models.ForeignKey(JobOrder, on_delete=models.PROTECT, related_name="jobwork")
    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="jobwork")
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)
    rqty                            = models.DecimalField(max_digits=15, decimal_places=4)
    start                           = models.DateField()
    status                          = models.CharField(max_length=1, choices=options, default=1)

    def __str__(self) -> str:
        return self.no

    class Meta:
        ordering = ['-no']


class RMIndent(models.Model):

    options = (
        ('1','Active'),
        ('2','Godown'),
        ('3','Production')
    )
    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)
    company                         = models.ForeignKey("company.Company", verbose_name=("Company"), on_delete=models.PROTECT)

    no                              = models.CharField(max_length=20)
    jobcard                         = models.ForeignKey(JobCard, verbose_name=("JobCard"), on_delete=models.PROTECT, related_name='rmindent')
    status                          = models.CharField(max_length=1, choices=options)

    def __str__(self) -> str:
        return str(self.jobcard)

    class Meta:
        ordering = ['-no']

class RMIndentItems(models.Model):

    rmindent                        = models.ForeignKey("production.RMIndent", verbose_name=("Indent"), on_delete=models.CASCADE)
    bom                             = models.ForeignKey(Bom, on_delete=models.PROTECT)
    item                            = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)

    def __str__(self) -> str:
        return str(self.rmindent)+ " " + str(self.item)

    class Meta:
        ordering = ['-rmindent']

class RMItemGodown(models.Model):

    rmitem                          = models.ForeignKey(RMIndentItems, on_delete=models.CASCADE)
    rate                            = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                             = models.CharField(max_length=51)
    batch                           = models.CharField(max_length=51)
    godown                          = models.CharField(max_length=51)
    qty                             = models.DecimalField(max_digits=15,decimal_places=2)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

class ConsumableIndent(models.Model):

    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)
    company                         = models.ForeignKey("company.Company", verbose_name=("Company"), on_delete=models.PROTECT)

    no                              = models.CharField(max_length=10)
    issuer                          = models.ForeignKey(User, verbose_name=("Issuer"), on_delete=models.PROTECT, related_name='consumable_indent_issued_by')
    drawn_by                        = models.ForeignKey(User, verbose_name=("Drawn_by"), on_delete=models.PROTECT, related_name='consumable_indent_drawn_by')
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)

    def __str__(self) -> str:
        return str(self.no)

    class Meta:
        ordering = ['-no']

class ConsItems(models.Model):

    indent                          = models.ForeignKey(ConsumableIndent, on_delete=models.PROTECT, related_name='consumable_indent_items')
    item                            = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="consumableitem")
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)
    con_qty                         = models.DecimalField(max_digits=15, decimal_places=4)


class Consumption(models.Model):

    company                         = models.ForeignKey(Company, on_delete=models.PROTECT)
    created                         = models.DateTimeField(auto_now_add=True)
    updated                         = models.DateTimeField(auto_now=True)

    no                              = models.CharField(max_length=20)
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)
    jobcard                         = models.ForeignKey(JobCard, verbose_name=("JobCard"), on_delete=models.PROTECT, related_name='consumption')
    date                            = models.DateField(default=timezone.now)

    def __str__(self) -> str:
        return str(self.no)

    class Meta:
        ordering = ['-no']

class ConsumptionItems(models.Model):

    consumption                     = models.ForeignKey(Consumption, on_delete=models.CASCADE, related_name='consumption')
    item                            = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="consumption_item")
    rate                            = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                             = models.CharField(max_length=51)
    batch                           = models.CharField(max_length=51)
    qty                             = models.DecimalField(max_digits=15, decimal_places=4)

    def __str__(self) -> str:
        return str(self.consumption)

    class Meta:
        ordering = ['-consumption']


auditlog.register(JobCard)
auditlog.register(RMIndent)
auditlog.register(RMIndentItems)
auditlog.register(RMItemGodown)
auditlog.register(ConsumableIndent)
auditlog.register(ConsItems)
auditlog.register(Consumption)
auditlog.register(ConsumptionItems)
