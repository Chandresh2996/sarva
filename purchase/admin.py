from django.contrib import admin
from import_export.widgets import ForeignKeyWidget
from import_export import resources, fields
from import_export.admin import ImportExportModelAdmin
from inventory.models import Product_master
from ledgers.models import Party_master
from .models import DebitNote, DebitNoteItems, Grn, PiItems, PoItems, Purchase, Purchase_order, PurchaseReturn, PurchaseReturnItems, Qdn, QdnItems, grnItems
# Register your models here.

class PoResourse(resources.ModelResource):


    seller = fields.Field(column_name="seller", attribute="seller",
                           widget=ForeignKeyWidget(Party_master, field="vendor_code"))

    class Meta:
        model = Purchase_order
        import_id_fields = ('id',)


class PoAdmin(ImportExportModelAdmin):

    list_display = ('id', 'po_no')
    resource_class = PoResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class PoItemsResourse(resources.ModelResource):

    po = fields.Field(column_name="po", attribute="po",
                       widget=ForeignKeyWidget(Purchase_order, field="po_no"))
    po = fields.Field(column_name="item", attribute="item",
                       widget=ForeignKeyWidget(Product_master, field="po_no"))
    class Meta:
        model = PoItems
        import_id_fields = ('id',)


class PoItemsAdmin(ImportExportModelAdmin):

    list_display = ('id','po' ,'product_code')
    resource_class = PoItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False
            
class GrnResourse(resources.ModelResource):


    seller = fields.Field(column_name="seller", attribute="seller", widget=ForeignKeyWidget(Party_master, field="vendor_code"))

    class Meta:
        model = Grn
        import_id_fields = ('id',)


class GrnAdmin(ImportExportModelAdmin):

    list_display = ('id', 'grn_no')
    resource_class = GrnResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class GrnItemsResourse(resources.ModelResource):
    grn = fields.Field(column_name="grn", attribute="grn", widget=ForeignKeyWidget(Grn, field="grn_no"))

    class Meta:
        model = grnItems
        import_id_fields = ('id',)

# class GrnItemsAdmin(admin.ModelAdmin):
#     def has_delete_permission(self, request, obj=None):
#         is_superuser = request.user.is_superuser
#         if is_superuser:
#             return True
#         else: 
#             return False

class GrnItemsAdmin(ImportExportModelAdmin):

    list_display = ('id', 'grn', 'item', 'batch')
    resource_class = GrnItemsResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class PiResourse(resources.ModelResource):


    seller = fields.Field(column_name="seller", attribute="seller",
                           widget=ForeignKeyWidget(Party_master, field="vendor_code"))

    class Meta:
        model = Purchase
        import_id_fields = ('id',)


class PiAdmin(ImportExportModelAdmin):

    list_display = ('id',)
    resource_class = PiResourse

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class PiItemsAdmin(admin.ModelAdmin):

    list_display = ('id','item','pi')

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class DebitItemsAdmin(admin.ModelAdmin):

    list_display = ('id',)

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

class DebitAdmin(admin.ModelAdmin):

    list_display = ('id','db_no')

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False


admin.site.register(DebitNote,DebitAdmin)
admin.site.register(DebitNoteItems,DebitItemsAdmin)
admin.site.register(PiItems, PiItemsAdmin)
admin.site.register(PoItems, PoItemsAdmin)
admin.site.register(Grn, GrnAdmin)
admin.site.register(grnItems, GrnItemsAdmin)
admin.site.register(Purchase_order, PoAdmin)
admin.site.register(Purchase, PiAdmin)


@admin.register(Qdn)
class QdnAdmin(admin.ModelAdmin):
    list_display = ('id', 'company', 'qdn_no' , 'pi_no')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

@admin.register(QdnItems)
class QdnitemsAdmin(admin.ModelAdmin):
    list_display = ('id', 'qdn' , 'item')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

@admin.register(PurchaseReturn)
class PurchaseReturnAdmin(admin.ModelAdmin):
    list_display = ('id', 'company', 'pr_no' , 'pi_no')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

@admin.register(PurchaseReturnItems)
class PurchaseReturnitemsAdmin(admin.ModelAdmin):
    list_display = ('id', 'pr' , 'item')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

