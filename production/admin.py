from import_export import resources
from import_export.admin import ImportExportModelAdmin
from django.contrib import admin
from production.models import Consumption, JobCard, RMIndent, RMIndentItems, RMItemGodown


class RmIndentResource(resources.ModelResource):

    class Meta:
        model = RMIndent
        import_id_fields = ('id',)


class RmIndentAdmin(ImportExportModelAdmin):
    list_display = ('id',)
    resource_class = RmIndentResource

admin.site.register(RMIndent, RmIndentAdmin)

class JobCardResource(resources.ModelResource):

    class Meta:
        model = JobCard
        import_id_fields = ('id',)


class JobCardAdmin(ImportExportModelAdmin):
    list_display = ('id', 'no', 'joborder', 'product','qty')
    resource_class = JobCardResource

admin.site.register(JobCard, JobCardAdmin)


class RmIndentItemsResource(resources.ModelResource):

    class Meta:
        model = RMIndentItems
        import_id_fields = ('id',)


class RmIndentItemsAdmin(ImportExportModelAdmin):
    list_display = ('id', 'rmindent')
    resource_class = RmIndentItemsResource

admin.site.register(RMIndentItems, RmIndentAdmin)


class RmItemGodownResource(resources.ModelResource):

    class Meta:
        model = RMItemGodown
        import_id_fields = ('id',)


class RmItemGodownAdmin(ImportExportModelAdmin):
    list_display = ('id', 'rmitem', 'qty')
    resource_class = RmItemGodownResource

admin.site.register(RMItemGodown, RmItemGodownAdmin)


class ConsumptionResource(resources.ModelResource):

    class Meta:
        model = Consumption
        import_id_fields = ('id',)


class ConsumptionAdmin(ImportExportModelAdmin):
    list_display = ('id', 'no', 'jobcard')
    resource_class = ConsumptionResource

admin.site.register(Consumption, ConsumptionAdmin)