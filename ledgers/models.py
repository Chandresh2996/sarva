from email.policy import default
from django.db import models
from auditlog.registry import auditlog
from inventory.models import Product_master

# Create your models here.

class Group(models.Model):
    name                            = models.CharField(max_length=151, unique=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self):
        return str(self.name)

    class Meta:
        ordering = ['name']

class LedgersType(models.Model):

    options = (
        ('1', 'Goods'),
        ('2', 'Serives'))

    applicable = (
        ('1', 'Applicable'),
        ('2', 'Not Applicable'),
        ('3', 'Undefined'))

    name                            = models.CharField(max_length=151)
    under                           = models.ForeignKey(Group, on_delete=models.PROTECT)
    gst_applicable                  = models.CharField(max_length=151, choices=applicable)
    type_of_supply                  = models.CharField(max_length=151, choices=options)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['name']

class Zone(models.Model):

    name                            = models.CharField(max_length=151, unique=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Region(models.Model):

    zone                            = models.ForeignKey(Zone, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        unique_together = ('zone','name')
        ordering        = ['name']

    def __str__(self) -> str:
        return self.name

class Zsm(models.Model):

    zone                            = models.ForeignKey(Zone, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        unique_together = ('zone', 'name',)
        ordering        = ['name']

    def __str__(self) -> str:
        return  self.name

class Rsm(models.Model):

    zone                            = models.ForeignKey(Zone, on_delete=models.PROTECT)
    region                          = models.ForeignKey(Region, on_delete=models.PROTECT)
    zsm                             = models.ForeignKey(Zsm, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        unique_together = ('zone','region', 'zsm' ,'name',)
        ordering        = ['name']

    def __str__(self) -> str:
        return  self.name


class Asm(models.Model):

    zone                            = models.ForeignKey(Zone, on_delete=models.PROTECT)
    region                          = models.ForeignKey(Region, on_delete=models.PROTECT)
    zsm                             = models.ForeignKey(Zsm, on_delete=models.PROTECT)
    rsm                             = models.ForeignKey(Rsm, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        unique_together = ('zone','region','zsm','rsm','name',)
        ordering        = ['name']

    def __str__(self) -> str:
        return self.name


class Se(models.Model):

    zone                            = models.ForeignKey(Zone, on_delete=models.PROTECT)
    region                          = models.ForeignKey(Region, on_delete=models.PROTECT)
    zsm                             = models.ForeignKey(Zsm, on_delete=models.PROTECT)
    rsm                             = models.ForeignKey(Rsm, on_delete=models.PROTECT)
    asm                             = models.ForeignKey(Asm, on_delete=models.PROTECT)
    name                            = models.CharField(max_length=151)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    class Meta:
        unique_together = ('zone','region','zsm','rsm','asm' ,'name',)
        ordering        = ['name']

    def __str__(self) -> str:
        return self.name


class PartyType(models.Model):

    code                            = models.CharField(max_length=151, blank=True, null=True, unique=True)
    name                            = models.CharField(max_length=151, unique=True)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name
        
    class Meta:
        ordering = ['name']


class Country(models.Model):
    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    name = models.CharField(max_length=151, unique=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']


class State(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    country                         = models.ForeignKey(Country, on_delete=models.PROTECT, default=1)
    name                            = models.CharField(max_length=151)

    class Meta:
        ordering = ['name']
        unique_together = ('country', 'name',)

    def __str__(self) -> str:
        return self.name


class City(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    state                           = models.ForeignKey(State, on_delete=models.PROTECT, default=1)
    name                            = models.CharField(max_length=151)

    class Meta:
        ordering = ['name']
        unique_together = ('state', 'name')

    def __str__(self) -> str:
        return self.name


class Price_level(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    name                            = models.CharField(max_length=151)
    code                            = models.CharField(max_length=151, blank=True, null=True, unique=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Division(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)
    name                            = models.CharField(("Name"), max_length=50, unique=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        ordering = ['name']

class Price_list(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    price_level                     = models.ForeignKey(Price_level, on_delete=models.PROTECT)
    product                         = models.ForeignKey(Product_master, on_delete=models.PROTECT, related_name = "pricelist")
    applicable_from                 = models.DateField(auto_now=True)
    rate                            = models.DecimalField(max_digits=15, decimal_places=2, default=0)

    class Meta:
        ordering        = ('product',)
        unique_together = ('price_level','product')


class Party_master(models.Model):

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    name                            = models.CharField(max_length=151)
    group                           = models.ForeignKey(Group, on_delete=models.PROTECT)
    price_level                     = models.ForeignKey(Price_level, on_delete=models.PROTECT, default=1)
    maintain_bill_by_bill           = models.BooleanField(default=True)
    dafault_credit_period           = models.CharField(max_length=151,null=True,blank=True)
    check_credit_days               = models.BooleanField(default=True)
    credit_limit                    = models.CharField(max_length=151,null=True,blank=True)
    closing_balance                 = models.CharField(max_length=151,null=True,blank=True)
    override_credit_limit           = models.BooleanField(default=False)

    payment_terms                   = models.CharField(max_length=151,null=True,blank=True)
    is_transporter                  = models.BooleanField(default=False)
    zone                            = models.ForeignKey(Zone,on_delete=models.PROTECT,null=True,blank=True)
    region                          = models.ForeignKey(Region,on_delete=models.PROTECT,null=True,blank=True)
    zsm                             = models.ForeignKey(Zsm,on_delete=models.PROTECT,null=True,blank=True)
    rsm                             = models.ForeignKey(Rsm,on_delete=models.PROTECT,null=True,blank=True)
    asm                             = models.ForeignKey(Asm,on_delete=models.PROTECT,null=True,blank=True)
    se                              = models.ForeignKey(Se,on_delete=models.PROTECT,null=True,blank=True)

    devision                        = models.ForeignKey(Division, on_delete=models.PROTECT)
    party_type                      = models.ForeignKey(PartyType, on_delete=models.PROTECT)
    allow_loose_packing             = models.BooleanField(default = True)
    istcsapplicable                 = models.BooleanField(default = False)
    vendor_code                     = models.CharField(max_length=151, unique=True,null=True,blank=True)

    mailing_name                    = models.CharField(max_length=151)
    addressline1                    = models.CharField(max_length=151, null=True,blank=True)
    addressline2                    = models.CharField(max_length=151, null=True,blank=True)
    addressline3                    = models.CharField(max_length=151, null=True,blank=True)

    country                         = models.ForeignKey(Country, on_delete=models.PROTECT)
    state                           = models.ForeignKey(State, on_delete=models.PROTECT)
    city                            = models.ForeignKey(City, on_delete=models.PROTECT)
    pin_code                        = models.CharField(max_length=6,null=True,)
    mobile_no                       = models.CharField(max_length=12,null=True,)

    contact_details                 = models.BooleanField(default=False)
    contact_person                  = models.CharField(max_length=151,null=True,blank=True)
    phone_no                        = models.CharField(max_length=12,null=True,blank=True)
    fax_no                          = models.CharField(max_length=12,null=True,blank=True)
    email_id                        = models.EmailField(max_length=250,null=True,blank=True)
    cc_email                        = models.TextField(max_length=250,null=True,blank=True)
    website                         = models.CharField(max_length=151,null=True,blank=True)

    multiple_address_list           = models.BooleanField(default=False)

    gst_registration_type           = models.CharField(max_length=151)
    gstin                           = models.CharField(max_length=151,null=True,blank=True)
    pan_no                          = models.CharField(max_length=151,null=True,blank=True)

    transation_type                 = models.CharField(max_length=151,null=True,blank=True)
    bank                            = models.CharField(max_length=151,null=True,blank=True)
    ifsc_code                       = models.CharField(max_length=151,null=True,blank=True)
    account_no                      = models.CharField(max_length=151,null=True,blank=True)
    account_name                    = models.CharField(max_length=151,null=True,blank=True)

    products                        = models.ManyToManyField(Product_master, related_name="party")

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    def __str__(self) -> str:
        return self.name

    class Meta:
        unique_together = ('name','group')

class Party_contact_details(models.Model):


    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

    party                           = models.ForeignKey(Party_master, on_delete=models.PROTECT)

    address_type                    = models.CharField(max_length=151)
    mailing_name                    = models.CharField(max_length=151,null=True,blank=True)
    addressline1                    = models.CharField(max_length=151,null=True,blank=True)
    addressline2                    = models.CharField(max_length=151,null=True,blank=True)
    addressline3                    = models.CharField(max_length=151,null=True,blank=True)

    country                         = models.ForeignKey(Country, on_delete=models.PROTECT)
    state                           = models.ForeignKey(State, on_delete=models.PROTECT)
    city                            = models.ForeignKey(City, on_delete=models.PROTECT)
    pin_code                        = models.CharField(max_length=12,null=True,blank=True)

    contact_person                  = models.CharField(max_length=151,null=True,blank=True)
    phone_no                        = models.CharField(max_length=12,null=True,blank=True)
    mobile_no                       = models.CharField(max_length=12,null=True,blank=True)
    fax_no                          = models.CharField(max_length=12,null=True,blank=True)
    email_id                        = models.EmailField(max_length=250,null=True,blank=True)
    pan_no                          = models.CharField(max_length=250,null=True,blank=True)

    gst_registration_type           = models.CharField(max_length=151,null=True,blank=True)
    gstin                           = models.CharField(max_length=151,null=True,blank=True)

    def __str__(self) -> str:
        return str(self.party) +"-->"+ self.address_type

class Currency(models.Model):

    code                            = models.CharField(max_length=3)
    name                            = models.CharField(max_length=25)

    created                         = models.DateField(auto_now_add=True)
    updated                         = models.DateField(auto_now=True)

auditlog.register(Group)
auditlog.register(LedgersType)
auditlog.register(Zone)
auditlog.register(Region)
auditlog.register(Zsm)
auditlog.register(Asm)
auditlog.register(Se)
auditlog.register(PartyType)
auditlog.register(Country)
auditlog.register(State)
auditlog.register(City)
auditlog.register(Price_level)
auditlog.register(Division)
auditlog.register(Price_list)
auditlog.register(Party_master)
auditlog.register(Party_contact_details)
auditlog.register(Currency)