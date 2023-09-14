from django.contrib import admin
from company.models import Company
from django.forms import ModelForm
from django.forms.widgets import TextInput


class CategoryForm(ModelForm):
    class Meta:
        model = Company
        fields = '__all__'
        widgets = {
            'color': TextInput(attrs={'type': 'color'}),
        }


@admin.register(Company)
class CompanyAdmin(admin.ModelAdmin):
    form = CategoryForm
    list_display = ('id', 'name')
