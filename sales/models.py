from django.utils import timezone
from django.db import models
from company.models import Company
from inventory.models import Godown, Product_master
from ledgers.models import LedgersType, Party_master, Zone, Region, Zsm, Rsm, Asm, Se
from auditlog.registry import auditlog


class Salesorder(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Closed')
    )
    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)

    so_no                       = models.CharField(max_length=51)
    ref_no                      = models.CharField(max_length=51,null=True,blank=True)

    so_date                     = models.DateField(default=timezone.now)
    so_due_date                 = models.DateField(auto_now_add=False,null=True,blank=True)

    price_list                  = models.CharField(max_length=51,null=True,blank=True)

    isscheme                    = models.BooleanField()
    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="salesorder_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151,blank=True, null=True)
    buyer_address2              = models.CharField(max_length=151,blank=True, null=True)
    buyer_address3              = models.CharField(max_length=151,blank=True, null=True)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51,blank=True, null=True)

    shipto                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="salesorder_shipto")
    shipto_address_type         = models.CharField(max_length=51)
    shipto_country              = models.CharField(max_length=51)
    shipto_state                = models.CharField(max_length=51)
    shipto_city                 = models.CharField(max_length=51)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151,blank=True, null=True)
    shipto_address2             = models.CharField(max_length=151,blank=True, null=True)
    shipto_address3             = models.CharField(max_length=151,blank=True, null=True)
    shipto_pincode              = models.CharField(max_length=51)
    shipto_gstin                = models.CharField(max_length=51,blank=True, null=True)
    shipto_pan_no               = models.CharField(max_length=51,blank=True, null=True)
    mode_of_payment             = models.CharField(max_length=51,null=True,blank=True)
    other_reference             = models.CharField(max_length=51,null=True,blank=True)
    order_no                    = models.CharField(max_length=51,null=True,blank=True)
    terms_of_delivery           = models.CharField(max_length=51,null=True,blank=True)

    scheme                      = models.CharField(max_length=51,null=True,blank=True)
    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    narration                   = models.TextField(null=True,blank=True)

    def __str__(self) -> str:
        return self.so_no

    class Meta:
        ordering = ['so_no']
        unique_together = ['company','so_no']

class SoItems(models.Model):

    so                          = models.ForeignKey(Salesorder, on_delete=models.CASCADE)
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)

    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)
    pack                        = models.DecimalField(max_digits=15, decimal_places=2)
    available_qty               = models.DecimalField(max_digits=15, decimal_places=2)

    offer_mrp                   = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    discount                    = models.DecimalField(max_digits=4, decimal_places=2)
    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


    def __str__(self) -> str:
        return str(self.item)

#---------------------------------------------------------------------------------------------------------------- Delivery Note--------------------------------#


class Delivery_note(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Closed')
    )
    status                      = models.CharField(max_length=20,choices=options,default=1)
    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    sales_order                 = models.OneToOneField(Salesorder, on_delete=models.PROTECT, null=True, related_name="dn")

    dn_no                       = models.CharField(max_length=51)
    dn_date                     = models.DateField(default=timezone.now)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="deliverynote_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151,blank=True, null=True)
    buyer_address2              = models.CharField(max_length=151,blank=True, null=True)
    buyer_address3              = models.CharField(max_length=151,blank=True, null=True)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51,blank=True, null=True)

    shipto                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="deliverynote_shipto")
    shipto_address_type         = models.CharField(max_length=51)
    shipto_country              = models.CharField(max_length=51)
    shipto_state                = models.CharField(max_length=51)
    shipto_city                 = models.CharField(max_length=51)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151,blank=True, null=True)
    shipto_address2             = models.CharField(max_length=151,blank=True, null=True)
    shipto_address3             = models.CharField(max_length=151,blank=True, null=True)
    shipto_pincode              = models.CharField(max_length=51)
    shipto_gstin                = models.CharField(max_length=51,blank=True, null=True)
    shipto_pan_no               = models.CharField(max_length=51,blank=True, null=True)

    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    scheme                      = models.CharField(max_length=51,null=True,blank=True)
    price_list                  = models.CharField(max_length=51,null=True,blank=True)

    narration                   = models.TextField(null=True,blank=True)

    mode_of_payment             = models.CharField(max_length=51,null=True,blank=True)
    other_reference             = models.CharField(max_length=51,null=True,blank=True)
    terms_of_delivery           = models.CharField(max_length=51,null=True,blank=True)
    order_no                    = models.CharField(max_length=51,null=True,blank=True)

    dispatch_doc_no             = models.CharField(max_length=51,null=True,blank=True)
    dispatch_through            = models.CharField(max_length=51,null=True,blank=True)
    destintaion                 = models.CharField(max_length=51,null=True,blank=True)
    carrier_agent               = models.CharField(max_length=51,null=True,blank=True)
    carrier_agent_id            = models.CharField(max_length=51,null=True,blank=True)
    lr_no                       = models.CharField(max_length=51,null=True,blank=True)
    lr_date                     = models.DateField(auto_now_add=False,null=True,blank=True)
    vehical_no                  = models.CharField(max_length=51,null=True,blank=True)
    vehical_type                = models.CharField(max_length=51,null=True,blank=True)

    ls_status                   = models.BooleanField(default=False)
    ps_status                   = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.dn_no

    class Meta:
        ordering = ['-dn_date']

class DnItems(models.Model):

    dn                          = models.ForeignKey(Delivery_note, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)

    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)
    offer_mrp                   = models.DecimalField(max_digits=15, decimal_places=2)
    pack                        = models.DecimalField(max_digits=15, decimal_places=2)
    available_qty               = models.DecimalField(max_digits=15, decimal_places=2)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    prate                       = models.DecimalField(max_digits=15, decimal_places=2)

    discount                    = models.DecimalField(max_digits=4, decimal_places=2)
    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)

    godown                      = models.ManyToManyField(Godown)

#---------------------------------------------------------------------------------------------------------------- Invoice--------------------------------#


class Invoice(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Sent to tally'),
        ('4','Mailed')
    )

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)
    dn                          = models.OneToOneField(Delivery_note, on_delete=models.PROTECT , null=True,blank=True ,related_name='inv')

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    inv_no                      = models.CharField(max_length=51)
    inv_date                    = models.DateField(default=timezone.now)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="invoice_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    division                    = models.CharField(max_length=51)
    channel                     = models.CharField(max_length=51)
    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151)
    buyer_address2              = models.CharField(max_length=151)
    buyer_address3              = models.CharField(max_length=151)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51, null=True, blank=True)

    shipto                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="invoice_shipto")
    shipto_address_type         = models.CharField(max_length=51)
    shipto_country              = models.CharField(max_length=51)
    shipto_state                = models.CharField(max_length=51)
    shipto_city                 = models.CharField(max_length=51)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=51)
    shipto_gstin                = models.CharField(max_length=51, null=True, blank=True)
    shipto_pan_no               = models.CharField(max_length=51, null=True, blank=True)

    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)

    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    mrpvalue                    = models.DecimalField(max_digits=15, decimal_places=2)
    omrpvalue                   = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    scheme                      = models.CharField(max_length=51,null=True,blank=True)

    narration                   = models.TextField(null=True,blank=True)
    price_list                  = models.CharField(max_length=51,null=True,blank=True)

    mode_of_payment             = models.CharField(max_length=100,null=True,blank=True)
    other_reference             = models.CharField(max_length=100,null=True,blank=True)
    terms_of_delivery           = models.CharField(max_length=100,null=True,blank=True)
    order_no                    = models.CharField(max_length=100,null=True,blank=True)

    dispatch_doc_no             = models.CharField(max_length=51,null=True,blank=True)
    dispatch_through            = models.CharField(max_length=51,null=True,blank=True)
    destination                 = models.CharField(max_length=51,null=True,blank=True)
    carrier_agent               = models.CharField(max_length=100,null=True,blank=True)
    carrier_agent_id            = models.CharField(max_length=100,null=True,blank=True)
    lr_no                       = models.CharField(max_length=51,null=True,blank=True)
    lr_date                     = models.DateField(auto_now_add=False, null=True, blank=True)
    vehical_type                = models.CharField(max_length=51,null=True,blank=True)
    vehical_no                  = models.CharField(max_length=51,null=True,blank=True)

    is_ict                      = models.BooleanField(default=False)
    is_ivt                      = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.inv_no

    class Meta:
        ordering = ['-inv_date']
        unique_together = ['company','inv_no']

class InvItems(models.Model):

    inv                         = models.ForeignKey(Invoice, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)
    offer_mrp                   = models.DecimalField(max_digits=15, decimal_places=2)
    pack                        = models.DecimalField(max_digits=15, decimal_places=2)
    available_qty               = models.DecimalField(max_digits=15, decimal_places=2)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    nb_qty                      = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    nf_qty                      = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    new_rate                    = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    prate                       = models.DecimalField(max_digits=15, decimal_places=2)

    discount                    = models.DecimalField(max_digits=4, decimal_places=2)
    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


class ProformaInvoice(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Inovice'),
        ('4','Mailed')
    )

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)
    dn                          = models.OneToOneField(Delivery_note, on_delete=models.PROTECT , null=True, related_name='proformainv')

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    inv_no                      = models.CharField(max_length=51)
    inv_date                    = models.DateField(default=timezone.now)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="proformainvoice_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    division                    = models.CharField(max_length=51)
    channel                     = models.CharField(max_length=51)
    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151)
    buyer_address2              = models.CharField(max_length=151)
    buyer_address3              = models.CharField(max_length=151)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51, null=True, blank=True)

    shipto                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="proformainvoice_shipto")
    shipto_address_type         = models.CharField(max_length=51)
    shipto_country              = models.CharField(max_length=51)
    shipto_state                = models.CharField(max_length=51)
    shipto_city                 = models.CharField(max_length=51)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=51)
    shipto_gstin                = models.CharField(max_length=51, null=True, blank=True)
    shipto_pan_no               = models.CharField(max_length=51, null=True, blank=True)

    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)

    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    mrpvalue                    = models.DecimalField(max_digits=15, decimal_places=2)
    omrpvalue                   = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    scheme                      = models.CharField(max_length=51,null=True,blank=True)

    narration                   = models.TextField(null=True,blank=True)
    price_list                  = models.CharField(max_length=51,null=True,blank=True)

    mode_of_payment             = models.CharField(max_length=51,null=True,blank=True)
    other_reference             = models.CharField(max_length=51,null=True,blank=True)
    terms_of_delivery           = models.CharField(max_length=51,null=True,blank=True)
    order_no                    = models.CharField(max_length=51,null=True,blank=True)

    dispatch_doc_no             = models.CharField(max_length=51,null=True,blank=True)
    dispatch_through            = models.CharField(max_length=51,null=True,blank=True)
    destintaion                 = models.CharField(max_length=51,null=True,blank=True)
    carrier_agent               = models.CharField(max_length=51,null=True,blank=True)
    carrier_agent_id            = models.CharField(max_length=51,null=True,blank=True)
    lr_no                       = models.CharField(max_length=51,null=True,blank=True)
    lr_date                     = models.DateField(auto_now_add=False, null=True, blank=True)
    vehical_type                = models.CharField(max_length=51,null=True,blank=True)
    vehical_no                  = models.CharField(max_length=51,null=True,blank=True)

    is_ict                      = models.BooleanField(default=False)
    is_ivt                      = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.inv_no

    class Meta:
        ordering = ['-inv_date']

class ProformaInvItems(models.Model):

    inv                         = models.ForeignKey(ProformaInvoice, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)
    offer_mrp                   = models.DecimalField(max_digits=15, decimal_places=2)
    pack                        = models.DecimalField(max_digits=15, decimal_places=2)
    available_qty               = models.DecimalField(max_digits=15, decimal_places=2)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=3)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    nb_qty                     = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    nf_qty                     = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    new_rate                    = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    prate                       = models.DecimalField(max_digits=15, decimal_places=2)

    discount                    = models.DecimalField(max_digits=4, decimal_places=2)
    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


class CreditNote(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Sent to tally'),
        ('4','Mailed')
    )
    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    inv                         = models.ForeignKey(Invoice, on_delete=models.PROTECT , null=True)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    cn_no                       = models.CharField(max_length=51)
    cn_date                     = models.DateField(auto_now_add=True)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="cn_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    division                    = models.CharField(max_length=51)
    channel                     = models.CharField(max_length=51)
    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151)
    buyer_address2              = models.CharField(max_length=151)
    buyer_address3              = models.CharField(max_length=151)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51, null=True, blank=True)

    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)
    mrpvalue                    = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    omrpvalue                   = models.DecimalField(max_digits=15, decimal_places=2, default=0)

    scheme                      = models.CharField(max_length=51,null=True,blank=True)

    narration                   = models.TextField(null=True,blank=True)
    def __str__(self) -> str:
        return self.cn_no

    class Meta:
        ordering = ['-cn_date']

class CreditNoteItems(models.Model):

    inv                  = models.ForeignKey(CreditNote, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)

    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    rates                       = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    discount                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)

class Qdn(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Sent to tally'),
        ('4','Mailed')
    )

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    inv                         = models.ForeignKey(Invoice, on_delete=models.PROTECT , null=True)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    qdn_no                      = models.CharField(max_length=51)
    qdn_date                    = models.DateField(auto_now_add=True)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="qdn_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51)

    division                    = models.CharField(max_length=51)
    channel                     = models.CharField(max_length=51)
    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=151)
    buyer_address1              = models.CharField(max_length=151)
    buyer_address2              = models.CharField(max_length=151)
    buyer_address3              = models.CharField(max_length=151)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51, null=True, blank=True)

    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)
    mrpvalue                    = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    omrpvalue                   = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    narration                   = models.TextField(null=True,blank=True)
    def __str__(self) -> str:
        return self.qdn_no

    class Meta:
        ordering = ['-qdn_date']

class QdnItems(models.Model):

    inv                         = models.ForeignKey(Qdn, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="sales_qdn_item")

    billed                      = models.DecimalField(max_digits=15, decimal_places=2)
    billed_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    discount                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


class Rso(models.Model):

    options = (
        ('1','Active'),
        ('2','Cancelled'),
        ('3','Sent to tally'),
        ('4','Mailed')
    )

    company                     = models.ForeignKey(Company,on_delete = models.PROTECT)
    inv                         = models.ForeignKey(Invoice, on_delete=models.PROTECT , null=True, blank=True)
    status                      = models.CharField(max_length=20,choices=options,default=1)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT,related_name="rso_buyer")
    buyer_address_type          = models.CharField(max_length=51)
    buyer_gst_reg_type          = models.CharField(max_length=51, null=True, blank=True)

    buyer_state                 = models.CharField(max_length=51)
    buyer_country               = models.CharField(max_length=51)
    buyer_city                  = models.CharField(max_length=51)
    division                    = models.CharField(max_length=51)
    channel                     = models.CharField(max_length=51)

    buyer_mailingname           = models.CharField(max_length=51)
    buyer_address1              = models.CharField(max_length=100)
    buyer_address2              = models.CharField(max_length=100)
    buyer_address3              = models.CharField(max_length=100)
    buyer_pincode               = models.CharField(max_length=51)
    buyer_gstin                 = models.CharField(max_length=51, null=True, blank=True)
    rso_no                      = models.CharField(max_length=51)
    rso_date                    = models.DateField(default=timezone.now)

    rso_ref                     = models.CharField(max_length=51, null=True, blank=True)
    ref_date                    = models.DateField(null=True, blank=True)
    bill_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    discount                    = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    mrpvalue                    = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    omrpvalue                   = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    is_ivt                      = models.BooleanField(default=False)
    is_cm                       = models.BooleanField(default=False)
    narration                   = models.TextField(null=True,blank=True)
    def __str__(self) -> str:
        return self.rso_no

    class Meta:
        ordering = ['-rso_date']

class RsoItems(models.Model):

    inv                         = models.ForeignKey(Rso, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)

    billed                  = models.DecimalField(max_digits=15, decimal_places=2)
    billed_qty                      = models.DecimalField(max_digits=15, decimal_places=2)
    free_qty                      = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                         = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    discount                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)

class LoadingSheet(models.Model):

    company                     = models.ForeignKey(Company,on_delete = models.CASCADE)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    dn                          = models.ForeignKey(Delivery_note, on_delete=models.CASCADE)
    item                        = models.ForeignKey(Product_master, on_delete=models.CASCADE)
    prate                       = models.DecimalField(max_digits=15, decimal_places=2)
    mrp                         = models.CharField(max_length=51)
    batch                       = models.CharField(max_length=51)
    offermrp                    = models.CharField(max_length=51)
    godown                      = models.CharField(max_length=51)
    qty                         = models.DecimalField(max_digits=15,decimal_places=2)

class PackingSheet(models.Model):

    company                     = models.ForeignKey(Company,on_delete = models.CASCADE)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    dn                          = models.ForeignKey(Delivery_note, on_delete=models.PROTECT)
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    mrp                         = models.CharField(max_length=51,default=0)
    offermrp                    = models.CharField(max_length=51,default=0)
    qty                         = models.DecimalField(max_digits=15,decimal_places=2)
    from_box                    = models.IntegerField()
    to_box                      = models.IntegerField()
    total_box                   = models.IntegerField(null=True, blank=True)
    remarks                     = models.CharField(max_length=51,null=True, blank=True)
    status                      = models.BooleanField(default=False)

class SaleQty(models.Model):

    company                     = models.ForeignKey(Company,on_delete = models.CASCADE)

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

    product                     = models.ForeignKey(Product_master, on_delete=models.CASCADE)
    qty                         = models.DecimalField(max_digits=15,decimal_places=2)

    def __str__(self) -> str:
        return str(self.product)

    class Meta:
        ordering = ['product']

class SalesTarget(models.Model):

    zone                        = models.ForeignKey(Zone, on_delete=models.PROTECT)
    region                      = models.ForeignKey(Region, on_delete=models.PROTECT)
    se                          = models.ForeignKey(Se, on_delete=models.PROTECT)
    asm                         = models.ForeignKey(Asm, on_delete=models.PROTECT)
    rsm                         = models.ForeignKey(Rsm, on_delete=models.PROTECT)
    zsm                         = models.ForeignKey(Zsm, on_delete=models.PROTECT)
    buyer                       = models.ForeignKey(Party_master, on_delete=models.PROTECT)
    target                      = models.DecimalField(max_digits=20,decimal_places=2)
    months                      = models.DateField()

    created                     = models.DateField(auto_now_add=True)
    updated                     = models.DateField(auto_now=True)

auditlog.register(Salesorder)
auditlog.register(SoItems)
auditlog.register(Delivery_note)
auditlog.register(DnItems)
auditlog.register(Invoice)
auditlog.register(InvItems)
auditlog.register(ProformaInvoice)
auditlog.register(ProformaInvItems)
auditlog.register(CreditNote)
auditlog.register(CreditNoteItems)
auditlog.register(Qdn)
auditlog.register(QdnItems)
auditlog.register(Rso)
auditlog.register(RsoItems)
auditlog.register(LoadingSheet)
auditlog.register(PackingSheet)
auditlog.register(SaleQty)
auditlog.register(SalesTarget)
