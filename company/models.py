from django.db import models
from auditlog.registry import auditlog


class Company(models.Model):

    name                        = models.CharField(max_length=51)
    tally_name                  = models.CharField(max_length=51)
    ledger_name                 = models.CharField(max_length=51)
    ipaddress                   = models.CharField(max_length=100, default="http://localhost:9001")

    dis_addtype                 = models.CharField(max_length=100)
    dis_name                    = models.CharField(max_length=100)
    dis_add1                    = models.CharField(max_length=100)
    dis_add2                    = models.CharField(max_length=100)
    dis_add3                    = models.CharField(max_length=100)
    dis_country                 = models.CharField(max_length=100)
    dis_state                   = models.CharField(max_length=100)
    dis_city                    = models.CharField(max_length=100)
    dis_pincode                 = models.CharField(max_length=100)
    dis_gstin                   = models.CharField(max_length=100)
    pan_no                      = models.CharField(max_length=10)
    so_series                   = models.CharField(max_length=10)
    dn_series                   = models.CharField(max_length=10)
    inv_series                  = models.CharField(max_length=10)
    pinv_series                 = models.CharField(max_length=10)
    debitnote_series            = models.CharField(max_length=10)
    sales_qdn_series            = models.CharField(max_length=10)
    rso_series                  = models.CharField(max_length=10)

    po_series                   = models.CharField(max_length=10)
    ict_series                  = models.CharField(max_length=10)
    grn_series                  = models.CharField(max_length=10)
    pi_series                   = models.CharField(max_length=10)
    creditnote_series           = models.CharField(max_length=10)
    purchase_qdn_series         = models.CharField(max_length=10)
    purchase_return_series      = models.CharField(max_length=10)

    joborder_series             = models.CharField(verbose_name="Job Order Series",max_length=10)
    job_series                  = models.CharField(verbose_name="Job Card Series",max_length=10)
    rm_series                   = models.CharField(verbose_name="RMIndent Series",max_length=10)
    cms_series                  = models.CharField(verbose_name="Consumables Series",max_length=10)
    pds_series                  = models.CharField(verbose_name="Production Series",max_length=10)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

auditlog.register(Company)
