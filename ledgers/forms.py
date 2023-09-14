from django import forms
from .models import Country, Zone, Region, State, City, Zsm, Division, PartyType, Rsm, Asm, Se, Party_master

class CountryForm(forms.ModelForm):
    class Meta: 
        model = Country
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(CountryForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }
        
class ZoneForm(forms.ModelForm):
    class Meta: 
        model = Zone
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(ZoneForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }

class RegionForm(forms.ModelForm):
    class Meta: 
        model = Region
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(RegionForm, self).__init__(*args, **kwargs)
        self.fields['zone'].widget.attrs={'class': 'form-control', }
        self.fields['name'].widget.attrs={'class': 'form-control', }

class StateForm(forms.ModelForm):
    class Meta: 
        model = State
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(StateForm, self).__init__(*args, **kwargs)
        self.fields['country'].widget.attrs={'class': 'form-control', }
        self.fields['name'].widget.attrs={'class': 'form-control', }

class CityForm(forms.ModelForm):
    country = forms.ModelChoiceField(queryset=Country.objects.all())
    state = forms.ModelChoiceField(queryset=State.objects.all())

    class Meta: 
        model = City
        fields = ['country', 'state', 'name']
    def __init__(self, *args, **kwargs):
        super(CityForm, self).__init__(*args, **kwargs)
        self.fields['country'].widget.attrs={'class': 'form-control', }
        self.fields['state'].widget.attrs={'class': 'form-control', }
        self.fields['name'].widget.attrs={'class': 'form-control', }

class ZsmForm(forms.ModelForm):
    class Meta: 
        model = Zsm
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(ZsmForm, self).__init__(*args, **kwargs)
        self.fields['zone'].widget.attrs={'class': 'form-control', }
        self.fields['name'].widget.attrs={'class': 'form-control', }

class DivisionForm(forms.ModelForm):
    class Meta: 
        model = Division
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(DivisionForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }

class PartyTypeForm(forms.ModelForm):
    class Meta: 
        model = PartyType
        fields = ['name',]
    def __init__(self, *args, **kwargs):
        super(PartyTypeForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }

class RsmForm(forms.ModelForm):
    class Meta: 
        model = Rsm
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(RsmForm, self).__init__(*args, **kwargs)
        self.fields['zone'].widget.attrs={'class': 'form-control', }
        self.fields['region'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].label = 'ZSM'
        self.fields['name'].widget.attrs={'class': 'form-control', }

class AsmForm(forms.ModelForm):
    class Meta: 
        model = Asm
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(AsmForm, self).__init__(*args, **kwargs)
        self.fields['zone'].widget.attrs={'class': 'form-control', }
        self.fields['region'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].label = 'ZSM'
        self.fields['rsm'].widget.attrs={'class': 'form-control', }
        self.fields['rsm'].label = 'RSM'
        self.fields['name'].widget.attrs={'class': 'form-control', }

class SeForm(forms.ModelForm):
    class Meta: 
        model = Se
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(SeForm, self).__init__(*args, **kwargs)
        self.fields['zone'].widget.attrs={'class': 'form-control', }
        self.fields['region'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].widget.attrs={'class': 'form-control', }
        self.fields['zsm'].label = 'ZSM'
        self.fields['rsm'].widget.attrs={'class': 'form-control', }
        self.fields['rsm'].label = 'RSM'
        self.fields['asm'].widget.attrs={'class': 'form-control', }
        self.fields['asm'].label = 'ASM'
        self.fields['name'].widget.attrs={'class': 'form-control', }

class CustomerForm(forms.ModelForm):
    class Meta: 
        model = Party_master
        fields = "__all__"
    def __init__(self, *args, **kwargs):
        super(CustomerForm, self).__init__(*args, **kwargs)
        self.fields['name'].widget.attrs={'class': 'form-control', }
        self.fields['name'].label ='Customer Name'
        self.fields['vendor_code'].widget.attrs={'class': 'form-control', 'readonly': True }
        self.fields['vendor_code'].label ='Customer Code'
        