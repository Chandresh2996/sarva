from django.db import models
from company.models import Company
from inventory.models import Godown, Product_master
from ledgers.models import LedgersType, Party_master
from auditlog.registry import auditlog
from django.utils import timezone


dispatch_through_choices = (
    ('0','Not Selected'),
    ('1','Road'),
    ('2','Rail'),
    ('3','Air'),
    ('4','Ship'),
)

class Purchase_order(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'GRN'),
        ('4', 'All GRN'),
        ('5', 'Closed')
    )


    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    status                      = models.CharField(max_length=20, choices=options, default=1)

    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)

    po_no                       = models.CharField(max_length=151)
    ref_no                      = models.CharField( max_length=151, unique=True, null=True, blank=True)

    po_date                     = models.DateField(auto_now_add=True)
    po_due_date                 = models.DateField(auto_now_add=False, null=True, blank=True)

    seller                      = models.ForeignKey( Party_master, on_delete=models.PROTECT, related_name="po")
    seller_address_type         = models.CharField(max_length=151)
    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151, null=True, blank=True)
    seller_address2             = models.CharField(max_length=151, null=True, blank=True)
    seller_address3             = models.CharField(max_length=151, null=True, blank=True)
    seller_state                = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_pincode              = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="poshipped")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151, null=True, blank=True)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)

    currency                    = models.CharField(max_length=20, default="INR")
    ex_rate                     = models.DecimalField(max_digits=7, decimal_places=2, default=1)

    other_ledger                = models.ForeignKey( LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    dispatch_through            = models.CharField(max_length=151,choices=dispatch_through_choices, null=True, blank=True)
    destintaion                 = models.CharField(max_length=151, null=True, blank=True)
    narration                   = models.TextField(null=True, blank=True)

    def __str__(self) -> str:
        return self.po_no

    class Meta:
        ordering = ['po_no']
        unique_together = ['company','po_no']

class PoItems(models.Model):

    po                          = models.ForeignKey(Purchase_order, on_delete=models.CASCADE)
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    product_code                = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151, default=0)
    basic_qty                   = models.DecimalField(max_digits=15, decimal_places=2)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    amend_qty                   = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)

    def __str__(self) -> str:
        return str(self.po)

#------------------------------------------------------------------------ Purchase Invoice--------------------------------#


class Purchase(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'Sent to tally')
    )
    status                      = models.CharField(max_length=20, choices=options, default=1)
    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)

    pi_no                       = models.CharField(max_length=151)
    pi_date                     = models.DateField(auto_now_add=True)

    seller                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="pi")
    seller_address_type         = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)
    seller_state                = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)
    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151)
    seller_address2             = models.CharField(max_length=151)
    seller_address3             = models.CharField(max_length=151)
    seller_pincode              = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="pishipped")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151)
    shipto_pan_no               = models.CharField(max_length=151, null=True, blank=True)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)
    dispatch_through            = models.CharField(max_length=151, null=True, blank=True, choices=dispatch_through_choices)
    destination                 = models.CharField(max_length=151, null=True, blank=True)

    supplier_invoice            = models.CharField(max_length=51)
    supplier_date               = models.DateField()

    currency                    = models.CharField(max_length=20, default="INR")
    ex_rate                     = models.DecimalField(max_digits=7, decimal_places=2, default=1)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    narration                   = models.TextField(null=True, blank=True)
    is_ict                      = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.pi_no

    class Meta:
        ordering = ['pi_no']
        unique_together = ['company','pi_no']

#------------------------------------------------------------------------------- GRN
class Grn(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'Closed')
    )
    status                      = models.CharField(max_length=20, choices=options, default=1)
    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)
    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    po                          = models.ForeignKey(Purchase_order, on_delete=models.PROTECT, blank=True, null=True, related_name="grn")
    pi                          = models.ForeignKey(Purchase, on_delete=models.SET_NULL, blank=True, null=True, related_name="grn")
    grn_no                      = models.CharField(max_length=151)
    grn_date                    = models.DateField(auto_now_add=True)

    seller                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="grn")
    seller_address_type         = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)

    seller_state                = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)

    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151)
    seller_address2             = models.CharField(max_length=151, null=True, blank=True)
    seller_address3             = models.CharField(max_length=151, null=True, blank=True)
    seller_pincode              = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="grnshipped")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151, null=True, blank=True)
    shipto_address3             = models.CharField(max_length=151, null=True, blank=True)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151)
    shipto_pan_no               = models.CharField(max_length=151, null=True, blank=True)

    currency                    = models.CharField(max_length=20, default="INR")
    ex_rate                     = models.DecimalField(max_digits=7, decimal_places=2, default=1)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    other_ledger                = models.ForeignKey(LedgersType, on_delete=models.PROTECT, null=True, blank=True)
    other                       = models.DecimalField(max_digits=15, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)

    narration                   = models.TextField(null=True, blank=True)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)

    dispatch_through            = models.CharField(max_length=151,choices=dispatch_through_choices,null=True, blank=True)
    destintaion                 = models.CharField(max_length=151, null=True, blank=True)

    def __str__(self) -> str:
        return self.grn_no

    class Meta:
        ordering = ['grn_no']
        unique_together = ['company','grn_no']

class grnItems(models.Model):

    grn                         = models.ForeignKey(Grn, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    product_code                = models.CharField(max_length=151)
    batch                       = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151)
    mrp                         = models.CharField(max_length=151)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    recd_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)

    godown                      = models.ManyToManyField(Godown)


class PiItems(models.Model):

    pi                          = models.ForeignKey("purchase.Purchase", verbose_name=("Purchase Invoice"), on_delete=models.CASCADE)
    grn                         = models.ForeignKey("purchase.Grn", on_delete=models.CASCADE, null=True)
    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    product_code                = models.CharField(max_length=151)
    batch                       = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151)
    mrp                         = models.CharField(max_length=151)
    basic_qty                   = models.DecimalField(max_digits=15, decimal_places=2)
    recd_qty                    = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)
    created                     = models.DateTimeField(default=timezone.now)

class DebitNote(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'Sent to tally')
    )

    status                      = models.CharField(max_length=20, choices=options, default=1)

    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)

    pi_no                       = models.ForeignKey(Purchase, on_delete=models.PROTECT)
    db_no                       = models.CharField(max_length=151)
    db_date                     = models.DateField(auto_now_add=True)

    seller                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="debitnote_seller")
    seller_address_type         = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)
    seller_state                = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)
    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151)
    seller_address2             = models.CharField(max_length=151)
    seller_address3             = models.CharField(max_length=151)
    seller_pincode              = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="debitnote_shipto")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151, null=True, blank=True)
    shipto_pan_no               = models.CharField(max_length=151)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)
    dispatch_through            = models.CharField(max_length=151, null=True, blank=True)
    destination                 = models.CharField(max_length=151, null=True, blank=True)

    narration                   = models.TextField(null=True, blank=True)

    currency                    = models.CharField(max_length=20, default="INR")
    ex_rate                     = models.DecimalField(max_digits=7, decimal_places=2, default=1)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)


    def __str__(self) -> str:
        return str(self.db_no)


class DebitNoteItems(models.Model):

    debitNote                   = models.ForeignKey(DebitNote, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    product_code                = models.CharField(max_length=151)
    batch                       = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151)
    mrp                         = models.CharField(max_length=151)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    actual_rate                 = models.DecimalField(max_digits=15, decimal_places=2)
    rate_diff                   = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


class Qdn(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'Sent to tally')
    )

    status                      = models.CharField(max_length=20, choices=options, default=1)

    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    company                     = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="purchase_qdn_seller")

    pi_no                       = models.ForeignKey(Purchase, on_delete=models.PROTECT)
    qdn_no                      = models.CharField(max_length=151)
    qdn_date                    = models.DateField(auto_now_add=True)

    seller                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="purchase_qdn_seller")
    seller_address_type         = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)
    seller_state                = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)
    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151)
    seller_address2             = models.CharField(max_length=151)
    seller_address3             = models.CharField(max_length=151)
    seller_pincode              = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="purchase_qdn_shipto")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151, null=True, blank=True)
    shipto_pan_no               = models.CharField(max_length=151)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)
    dispatch_through            = models.CharField(max_length=151, null=True, blank=True)
    destination                 = models.CharField(max_length=151, null=True, blank=True)
    narration                   = models.TextField(null=True, blank=True)

    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)


    def __str__(self) -> str:
        return str(self.qdn_no)


class QdnItems(models.Model):

    qdn                         = models.ForeignKey(Qdn, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name="purchase_qdn_item")
    product_code                = models.CharField(max_length=151)
    batch                       = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151)
    mrp                         = models.CharField(max_length=151)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    qdn_qty                     = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)
    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)



class PurchaseReturn(models.Model):

    options = (
        ('1', 'Active'),
        ('2', 'Cancelled'),
        ('3', 'Sent to tally')
    )

    status                      = models.CharField(max_length=20, choices=options, default=1)

    created                     = models.DateTimeField(auto_now_add=True)
    updated                     = models.DateTimeField(auto_now=True)
    company                     = models.ForeignKey(Company, on_delete=models.PROTECT)

    pi_no                       = models.ForeignKey(Purchase, on_delete=models.PROTECT)
    pr_no                       = models.CharField(max_length=151)
    pr_date                     = models.DateField(auto_now_add=True)

    seller                      = models.ForeignKey(Party_master, on_delete=models.PROTECT, related_name="pr_seller")
    seller_address_type         = models.CharField(max_length=151)
    seller_gst_reg_type         = models.CharField(max_length=151)
    seller_state                = models.CharField(max_length=151)
    seller_country              = models.CharField(max_length=151)
    seller_city                 = models.CharField(max_length=151)
    seller_mailingname          = models.CharField(max_length=151)
    seller_address1             = models.CharField(max_length=151)
    seller_address2             = models.CharField(max_length=151)
    seller_address3             = models.CharField(max_length=151)
    seller_pincode              = models.CharField(max_length=151)
    seller_gstin                = models.CharField(max_length=151, null=True, blank=True)

    shipto                      = models.ForeignKey(Company, on_delete=models.PROTECT, related_name="pr_shipto")
    shipto_address_type         = models.CharField(max_length=151)
    shipto_country              = models.CharField(max_length=151)
    shipto_state                = models.CharField(max_length=151)
    shipto_city                 = models.CharField(max_length=151)
    shipto_mailingname          = models.CharField(max_length=151)
    shipto_address1             = models.CharField(max_length=151)
    shipto_address2             = models.CharField(max_length=151)
    shipto_address3             = models.CharField(max_length=151)
    shipto_pincode              = models.CharField(max_length=151)
    shipto_gstin                = models.CharField(max_length=151, null=True, blank=True)
    shipto_pan_no               = models.CharField(max_length=151)

    mode_of_payment             = models.CharField(max_length=151, null=True, blank=True)
    other_reference             = models.CharField(max_length=151, null=True, blank=True)
    terms_of_delivery           = models.CharField(max_length=151, null=True, blank=True)
    dispatch_through            = models.CharField(max_length=151, null=True, blank=True)
    destination                 = models.CharField(max_length=151, null=True, blank=True)
    narration                   = models.TextField(null=True, blank=True)
    ammount                     = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    tcs                         = models.DecimalField(max_digits=15, decimal_places=2)
    ol_rate                     = models.DecimalField(max_digits=4, decimal_places=2)
    round_off                   = models.DecimalField(max_digits=3, decimal_places=2)
    total                       = models.DecimalField(max_digits=15, decimal_places=2)


    def __str__(self) -> str:
        return str(self.pr_no)


class PurchaseReturnItems(models.Model):

    pr                          = models.ForeignKey(PurchaseReturn, on_delete=models.CASCADE)

    item                        = models.ForeignKey(Product_master, on_delete=models.PROTECT)
    product_code                = models.CharField(max_length=151)
    batch                       = models.CharField(max_length=151)
    pack                        = models.CharField(max_length=151)
    mrp                         = models.CharField(max_length=151)
    actual_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    return_qty                  = models.DecimalField(max_digits=15, decimal_places=2)
    rate                        = models.DecimalField(max_digits=15, decimal_places=2)

    igstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    sgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)
    cgstrate                    = models.DecimalField(max_digits=4, decimal_places=2)

    igst                        = models.DecimalField(max_digits=15, decimal_places=2)
    sgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    cgst                        = models.DecimalField(max_digits=15, decimal_places=2)
    amount                      = models.DecimalField(max_digits=15, decimal_places=2)


auditlog.register(Purchase_order)
auditlog.register(PoItems)
auditlog.register(Grn)
auditlog.register(grnItems)
auditlog.register(Purchase)
auditlog.register(DebitNote)
auditlog.register(DebitNoteItems)
auditlog.register(Qdn)
auditlog.register(QdnItems)
auditlog.register(PurchaseReturn)
auditlog.register(PurchaseReturnItems)