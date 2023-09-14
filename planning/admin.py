from import_export import resources
from import_export.admin import ImportExportModelAdmin
from django.contrib import admin


from planning.models import JobOrder


class JobOrderResource(resources.ModelResource):

    class Meta:
        model = JobOrder
        import_id_fields = ('name',)


class JobOrderAdmin(ImportExportModelAdmin):
    list_display = ('id', 'no', 'product','qty')
    resource_class = JobOrderResource

admin.site.register(JobOrder, JobOrderAdmin)