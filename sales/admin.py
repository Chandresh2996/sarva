from django.contrib import admin
from company.models import Company
from import_export.widgets import ForeignKeyWidget
from import_export import resources, fields
from import_export.admin import ImportExportModelAdmin
from inventory.models import Product_master
from ledgers.models import Party_master

from sales.models import CreditNote, CreditNoteItems, Delivery_note, DnItems, InvItems, Invoice, LoadingSheet,PackingSheet, Qdn, QdnItems, Rso, RsoItems, SaleQty, SalesTarget, Salesorder, SoItems, ProformaInvoice, ProformaInvItems


class SoResourse(resources.ModelResource):
    buyer = fields.Field(column_name="buyer", attribute="buyer",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    shipto = fields.Field(column_name="shipto", attribute="shipto",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    class Meta:
        model = Salesorder
        import_id_fields = ('id',)


class SoAdmin(ImportExportModelAdmin):

    list_display = ('id', 'company', 'so_no' , 'so_date')
    resource_class = SoResourse

admin.site.register(Salesorder,SoAdmin)


class SoqtyResourse(resources.ModelResource):

    company = fields.Field(column_name="company", attribute="company",
                         widget=ForeignKeyWidget(Company, field="name"))

    product = fields.Field(column_name="product", attribute="product",
                         widget=ForeignKeyWidget(Product_master, field="product_code"))
    class Meta:
        model = SaleQty
        import_id_fields = ('id',)


class SoAdmin(ImportExportModelAdmin):

    list_display = ('id', 'company', 'product' , 'qty')
    resource_class = SoqtyResourse

admin.site.register(SaleQty,SoAdmin)

class SoItemsResourse(resources.ModelResource):

    so = fields.Field(column_name="so", attribute="so",
                       widget=ForeignKeyWidget(Salesorder, field="so_no"))
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))
    class Meta:
        model = SoItems
        import_id_fields = ('id',)


class SoItemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'so' , 'item','mrp')
    resource_class = SoItemsResourse

admin.site.register(SoItems,SoItemsAdmin)


class DnItemsResourse(resources.ModelResource):

    dn = fields.Field(column_name="dn", attribute="dn",
                       widget=ForeignKeyWidget(Delivery_note, field="dn_no"))
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))
    class Meta:
        model = DnItems
        import_id_fields = ('id',)


class DnItemsAdmin(ImportExportModelAdmin):

    list_display = ('id','dn' ,'mrp')
    resource_class = DnItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(DnItems,DnItemsAdmin)

class DnResourse(resources.ModelResource):
    buyer = fields.Field(column_name="buyer", attribute="buyer",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    shipto = fields.Field(column_name="shipto", attribute="shipto",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    sales_order = fields.Field(column_name="sales_order", attribute="sales_order",
                        widget=ForeignKeyWidget(Salesorder, field="so_no"))
    class Meta:
        model = Delivery_note
        import_id_fields = ('id',)


class DnAdmin(ImportExportModelAdmin):
    list_display = ('id', 'company', 'dn_no' , 'dn_date' , 'sales_order')

    resource_class = DnResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(Delivery_note,DnAdmin)

class InvResourse(resources.ModelResource):

    buyer = fields.Field(column_name="buyer", attribute="buyer",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    shipto = fields.Field(column_name="shipto", attribute="shipto",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    # dn = fields.Field(column_name="dn", attribute="dn",
    #                     widget=ForeignKeyWidget(Delivery_note, field="dn_no"))
    def get_queryset(self):
        return super().get_queryset().select_related('company', 'shipto', 'buyer','other_ledger')

    class Meta:
        model = Invoice
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        use_bulk = True
        # force_init_instance = True
        batch_size = 1000

class InvAdmin(ImportExportModelAdmin):

    list_display = ('id', 'company', 'inv_no' , 'inv_date' , 'ammount','division','channel')
    resource_class = InvResourse
    list_filter = ('channel',)

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(Invoice,InvAdmin)
admin.site.register(ProformaInvoice)
@admin.register(ProformaInvItems)
class ProformaInvItemsAdmin(admin.ModelAdmin):
    list_display = ('id','item','actual_qty' , 'inv')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

class InvForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            company=row["company"],
            inv_no=row["inv"]
        )

class InvitemsResourse(resources.ModelResource):
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))

    inv = fields.Field(column_name="inv", attribute="inv",
                        widget=InvForeignKeyWidget(Invoice, field="inv_no"))

    def get_queryset(self):
        return super().get_queryset().select_related('inv','item')

    class Meta:
        model = InvItems
        import_id_fields = ('id',)
        skip_diff = True
        skip_html_diff = True
        use_bulk = True
        force_init_instance = True
        batch_size = 1000
        # fields  = ('id','inv','inv__company','item','amount','billed_qty','discount','mrp','offer_mrp','pack','available_qty','actual_qty','nb_qty','nf_qty','free_qty','rate','new_rate','prate','igst','sgst','cgst','igstrate','cgstrate','sgstrate')

class InvitemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'item')
    resource_class = InvitemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(InvItems,InvitemsAdmin)

@admin.register(LoadingSheet)
class LsAdmin(admin.ModelAdmin):
    list_display = ('id', 'company', 'qty' , 'godown', 'dn')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

@admin.register(PackingSheet)
class PsAdmin(admin.ModelAdmin):
    list_display = ('id', 'company', 'qty' , 'dn')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

@admin.register(SalesTarget)
class SalesTargetAdmin(admin.ModelAdmin):
    list_display = ('id', 'months', 'buyer' , 'target')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return


class CreditNoteResourse(resources.ModelResource):

    inv = fields.Field(column_name="inv", attribute="inv",
                        widget=InvForeignKeyWidget(Invoice, field="inv_no"))

    class Meta:
        model = CreditNote
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        # use_bulk = True
        # force_init_instance = True
        # fields = ('inv','id','cn_no','company','status','cn_no','cn_date','inv__buyer', 'inv__buyer_address_type', 'inv__buyer_gst_reg_type', 'inv__division', 'inv__channel', 'inv__buyer_state', 'inv__buyer_country', 'inv__buyer_city', 'inv__buyer_mailingname', 'inv__buyer_address1', 'inv__buyer_address2', 'inv__buyer_address3', 'inv__buyer_pincode', 'inv__buyer_gstin', 'ammount', 'mrpvalue', 'omrpvalue', 'discount', 'sgst', 'cgst', 'igst', 'tcs', 'round_off', 'total', 'other_ledger', 'other', 'ol_rate','scheme','narration','created','updated')

class CreditNoteAdmin(ImportExportModelAdmin):

    list_display = ('id', 'company', 'cn_no' , 'inv')
    resource_class = CreditNoteResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False
admin.site.register(CreditNote,CreditNoteAdmin)

class CreditNoteForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            company=row["company"],
            cn_no=row["creditNote"]
        )
class CreditNoteItemsResourse(resources.ModelResource):
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))

    # CreditNote = fields.Field(column_name="creditNote", attribute="creditNote",
    #                     widget=CreditNoteForeignKeyWidget(CreditNote, field="cn_no"))

    class Meta:
        model = CreditNoteItems
        fields = ('inv','id','item','billed_qty','rate','rate_diff','mrp','igstrate','sgstrate','cgstrate','discount','igst','sgst','cgst','amount')
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        # use_bulk = True
        # force_init_instance = True

class CreditNoteItemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'item')
    resource_class = CreditNoteItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(CreditNoteItems,CreditNoteItemsAdmin)

class RsoForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            company=row["company"],
            rso_no=row["inv"]
        )
class RsoResourse(resources.ModelResource):

    buyer = fields.Field(column_name="buyer", attribute="buyer",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    inv = fields.Field(column_name="inv", attribute="inv",
                        widget=InvForeignKeyWidget(Invoice, field="inv_no"))

    def get_queryset(self):
        return super().get_queryset().select_related('company', 'inv', 'buyer')

    class Meta:
        model = Rso
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        use_bulk = True
        # force_init_instance = True
        batch_size = 1000
        # fields = ('inv','id','company','status','rso_no','rso_date','rso_ref','ref_date','buyer', 'buyer_address_type', 'buyer_gst_reg_type', 'buyer__devision__name', 'buyer__party_type__name', 'buyer_state', 'buyer_country', 'buyer_city', 'buyer_mailingname', 'buyer_address1', 'buyer_address2', 'buyer_address3', 'buyer_pincode', 'buyer_gstin', 'rb_qty', 'rf_qty','ammount', 'mrpvalue', 'omrpvalue', 'discount', 'sgst', 'cgst', 'igst', 'tcs', 'round_off', 'total', 'other_ledger', 'other', 'ol_rate','is_ivt','is_cm','narration','created','updated')

class RsoAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'rso_no', 'rso_date','ammount','division','channel')
    resource_class = RsoResourse

    # def get_confirm_import_form(self):
    #     return False


    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(Rso,RsoAdmin)


class RsoItemsResourse(resources.ModelResource):
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))

    inv = fields.Field(column_name="inv", attribute="inv",
                        widget=RsoForeignKeyWidget(Rso, field="rso_no"))
    def get_queryset(self):
        return super().get_queryset().select_related('inv','item')

    class Meta:
        model = RsoItems
        # fields = ('inv','inv__company','id','item','billed_qty','rate','billed','free_qty','mrp','igstrate','sgstrate','cgstrate','discount','igst','sgst','cgst','amount')
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        use_bulk = True
        # force_init_instance = True
        batch_size = 1000

class RsoItemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'item')
    resource_class = RsoItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(RsoItems,RsoItemsAdmin)

class QdnForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            company=row["company"],
            qdn_no=row["qdn"]
        )
class QdnResourse(resources.ModelResource):

    inv = fields.Field(column_name="inv", attribute="inv",
                        widget=InvForeignKeyWidget(Invoice, field="inv_no"))

    class Meta:
        model = Qdn
        import_id_fields = ('id',)
        # skip_diff = True
        # skip_html_diff = True
        # use_bulk = True
        # force_init_instance = True
        # fields = ('inv','id','cn_no','company','status','qdn_no','qdn_date','inv__buyer', 'inv__buyer_address_type', 'inv__buyer_gst_reg_type', 'inv__division', 'inv__channel', 'inv__buyer_state', 'inv__buyer_country', 'inv__buyer_city', 'inv__buyer_mailingname', 'inv__buyer_address1', 'inv__buyer_address2', 'inv__buyer_address3', 'inv__buyer_pincode', 'inv__buyer_gstin', 'qb_qty', 'qf_qty', 'ammount', 'mrpvalue', 'omrpvalue', 'discount', 'sgst', 'cgst', 'igst', 'tcs', 'round_off', 'total', 'other_ledger', 'other', 'ol_rate','scheme','narration','created','updated')

class QdnAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'qdn_no','qdn_date', 'ammount','buyer_state')
    resource_class = QdnResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(Qdn,QdnAdmin)


class QdnItemsResourse(resources.ModelResource):
    item = fields.Field(column_name="item", attribute="item",
                        widget=ForeignKeyWidget(Product_master, field="product_code"))

    # qdn = fields.Field(column_name="qdn", attribute="qdn",
    #                     widget=QdnForeignKeyWidget(Qdn, field="qdn_no"))

    class Meta:
        model = QdnItems
        import_id_fields = ('id',)
        # fields = ('qdn','qdn__company','id' ,'item','billed_qty','rate','qb_qty','qf_qty','mrp','igstrate','sgstrate','cgstrate','discount','igst','sgst','cgst','amount')
        # fields  = ('id','inv','inv__company','item','amount','inv__discount','billed_qty','discount','mrp','free_qty','igst','sgst','cgst','igstrate','cgstrate','sgstrate')

class QdnItemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'inv' , 'item')
    resource_class = QdnItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

admin.site.register(QdnItems,QdnItemsAdmin)