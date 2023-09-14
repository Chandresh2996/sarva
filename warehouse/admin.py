from django.contrib import admin

from warehouse.models import MaterialTransferred, PalletTransferEntry, ShortageDamageEntry


@admin.register(ShortageDamageEntry)
class ShortageDamageEntryAdmin(admin.ModelAdmin):
    list_display = ('id', 'godown' , 'item')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

@admin.register(PalletTransferEntry)
class PalletTransferEntryAdmin(admin.ModelAdmin):
    list_display = ('id', 'fgodown' ,'tgodown' , 'item','created','createdby')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False

@admin.register(MaterialTransferred)
class MaterialTransferredAdmin(admin.ModelAdmin):
    list_display = ('id', 'indent' ,'item' , 'godown','qty','rate')
    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else: 
            return False