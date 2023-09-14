from django import forms
from .models import Brand, SubBrand, Category, Class, SubClass, ProductType, Godown, UnitOfMeasure, Currency
from ledgers.models import Price_level

class BrandForm(forms.ModelForm):
    class Meta: 
        model = Brand
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(BrandForm, self).__init__(*args, **kwargs)
        self.fields['under'].widget.attrs={'class': 'form-control', 'readonly': True }
        self.fields['name'].widget.attrs={'class': 'form-control', }
        self.fields['code'].widget.attrs={'class': 'form-control', }

class SubBrandForm(forms.ModelForm):
    class Meta:
        model = SubBrand
        fields = ['name',]
    def __init__(self, *args, **kwargs):
        super(SubBrandForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        
class CategoryForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['under','name',]
    def __init__(self, *args, **kwargs):
        super(CategoryForm, self).__init__(*args, **kwargs)
        self.fields['under'].widget.attrs={
            'class': 'form-control', 'readonly': True }
        self.fields['name'].widget.attrs={
            'class': 'form-control',}

class ClassForm(forms.ModelForm):
    class Meta:
        model = Class
        fields = ['name',]
    def __init__(self, *args, **kwargs):
        super(ClassForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        
class SubClassForm(forms.ModelForm):
    class Meta:
        model = SubClass
        fields = ['name',]
    def __init__(self, *args, **kwargs):
        super(SubClassForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        
class ProductTypeForm(forms.ModelForm):
    class Meta:
        model = ProductType
        fields = ['name','dl_sales','dl_purchase']
    def __init__(self, *args, **kwargs):
        super(ProductTypeForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        self.fields['dl_sales'].widget.attrs={
            'class': 'form-control',}
        self.fields['dl_sales'].label = 'Default ledger for Sales Invoice'
        self.fields['dl_purchase'].widget.attrs={
            'class': 'form-control',}
        self.fields['dl_purchase'].label = 'Default ledger for Purchase Invoice'

class GodownForm(forms.ModelForm):
    class Meta:
        model = Godown
        fields = ['parent','name','godown_type']
        
    def __init__(self, *args, **kwargs):
        super(GodownForm, self).__init__(*args, **kwargs)
        self.fields['parent'].widget.attrs={
            'class': 'form-control', }
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        self.fields['godown_type'].widget.attrs={
            'class': 'form-control w-20',}
        self.fields['godown_type'].label = 'Is Saleable'

class UnitOfMeasureForm(forms.ModelForm):
    class Meta:
        model = UnitOfMeasure
        fields = ['uqc','symbol','name', 'decimal_places']
    def __init__(self, *args, **kwargs):
        super(UnitOfMeasureForm, self).__init__(*args, **kwargs)
        self.fields['uqc'].widget.attrs={
            'class': 'form-control',}
        self.fields['uqc'].label = 'UQC'
        self.fields['symbol'].widget.attrs={
            'class': 'form-control',}
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        self.fields['name'].label = 'Formal Name'
        self.fields['decimal_places'].widget.attrs={
            'class': 'form-control',}
        self.fields['decimal_places'].label = 'No of Decimal Places'

class CurrencyForm(forms.ModelForm):
    class Meta:
        model = Currency
        fields = ['name','code','symbol']
    def __init__(self, *args, **kwargs):
        super(CurrencyForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={
            'class': 'form-control',}
        self.fields['code'].widget.attrs={
            'class': 'form-control',}
        self.fields['symbol'].widget.attrs={
            'class': 'form-control',}
        
class Price_levelForm(forms.ModelForm):
    class Meta: 
        model = Price_level
        fields = ['name',]
    def __init__(self, *args, **kwargs):
        super(Price_levelForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }