from typing import Set
from django.contrib import admin
from django.contrib.auth.models import User, Group
from django.contrib.auth.admin import UserAdmin
from import_export import resources, fields
from import_export.admin import ImportExportModelAdmin
from accounts.models import LoggedInUser
from django.contrib.sessions.models import Session


# Unregister the provided model admin
admin.site.unregister(User)
admin.site.unregister(Group)
admin.site.register(LoggedInUser)


@admin.register(Session)
class CustomGroupAdmin(ImportExportModelAdmin):
    list_display = ['session_key','expire_date']


class UserResource(resources.ModelResource):
    class Meta:
        model = User
        fields = '__all__'

@admin.register(User)
class CustomUserAdmin(ImportExportModelAdmin,UserAdmin):
    list_display = ('id','username','first_name', 'is_active','last_name', 'email')
    # def get_form(self, request, obj=None, **kwargs):
    #     form = super().get_form(request, obj, **kwargs)
    #     is_superuser = request.user.is_superuser
    #     disabled_fields = set()

    #     if (not is_superuser and obj is not None):
    #         disabled_fields |= {
    #             'is_superuser',
    #         }

    #     for f in disabled_fields:
    #         if f in form.base_fields:
    #             form.base_fields[f].disabled = True

    #     return form

    def has_delete_permission(self, request, obj=None):
        is_superuser = request.user.is_superuser
        if is_superuser:
            return True
        else:
            return False

class GroupResource(resources.ModelResource):
    class Meta:
        model = Group
        fields = '__all__'

@admin.register(Group)
class CustomGroupAdmin(ImportExportModelAdmin):

    list_display = ['name']