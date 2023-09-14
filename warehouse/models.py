from django.db import models
from company.models import Company
from inventory.models import Godown, Product_master
from production.models import JobCard, RMIndent
from auditlog.registry import auditlog
from purchase.models import Purchase

class Stock_summary(models.Model):

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT, related_name='stock')

    product                     = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    godown                      = models.ForeignKey(Godown, on_delete=models.PROTECT)
    mrp                         = models.CharField(max_length=51)
    batch                       = models.CharField(max_length=51, null=True, blank=True)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    closing_balance             = models.DecimalField(max_digits=15, decimal_places=4, null=True, blank=True)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return str(self.godown)


class MaterialTransferred(models.Model):

    indent                      = models.ForeignKey(RMIndent, on_delete=models.PROTECT, related_name="material_transferred")
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="material_transferred")
    godown                      = models.ForeignKey(Godown, verbose_name="Godown", on_delete=models.PROTECT, related_name="material_transferred")
    qty                         = models.DecimalField(max_digits=15, decimal_places=4)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

class ShortageDamageEntry(models.Model):

    options = (
        ( '1', 'Purchase'),
        ( '2', 'Warehouse'),
        ( '3', 'Production'),
    )

    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)
    shoratage                   = models.CharField(choices=options, max_length=2, )
    purchase                    = models.ForeignKey(Purchase, on_delete=models.PROTECT,blank=True,null=True)
    jobwork                     = models.ForeignKey(JobCard, on_delete=models.PROTECT,blank=True,null=True)
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    godown                      = models.ForeignKey(Godown, verbose_name="Godown", on_delete=models.PROTECT)
    sqty                        = models.DecimalField(max_digits=15, decimal_places=4,default=0)
    dqty                        = models.DecimalField(max_digits=15, decimal_places=4,default=0)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    sremarks                    = models.TextField()
    dremarks                    = models.TextField()

    createdby                   = models.CharField(max_length=15)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)


class PalletTransferEntry(models.Model):

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT, related_name='pallet')
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    fgodown                     = models.CharField(max_length=30)
    tgodown                     = models.CharField(max_length=30)
    qty                         = models.DecimalField(max_digits=15, decimal_places=4,default=0)
    created                     = models.DateField(auto_now_add=True)
    createdby                   = models.CharField(max_length=15)

auditlog.register(PalletTransferEntry)
auditlog.register(Stock_summary)
auditlog.register(ShortageDamageEntry)
auditlog.register(MaterialTransferred)
