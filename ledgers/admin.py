from django.contrib import admin
from company.models import Company
from import_export.widgets import ForeignKeyWidget
from import_export import resources, fields
from import_export.admin import ImportExportModelAdmin
from inventory.models import Godown, Product_master
from ledgers.models import Asm, City, Country, Division, Group, LedgersType, Party_contact_details, Party_master, PartyType, Price_level, Price_list, Region, Rsm, Se, State, Zone, Zsm
from warehouse.models import Stock_summary

# -------------------------------------------------------------------------ForeginKey Widget

class RegionForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            zone__name=row["zone"],
            name=row["region"]
        )

class ZsmForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            zone__name=row["zone"],
            name=row["zsm"]
        )

class RsmForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            zone__name=row["zone"],
            zsm__name=row["zsm"],
            region__name=row["region"],
            name=row["rsm"]
        )

class AsmForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            zone__name=row["zone"],
            region__name=row["region"],
            zsm__name=row["zsm"],
            rsm__name=row["rsm"],
            name=row["asm"]
        )


class SeForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            zone__name=row["zone"],
            region__name=row["region"],
            zsm__name=row["zsm"],
            rsm__name=row["rsm"],
            asm__name=row["asm"],
            name=row["se"]
        )

class StateForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            country__name=row["country"],
            name=row["state"]
        )

class CityForeignKeyWidget(ForeignKeyWidget):
    def get_queryset(self, value, row, *args, **kwargs):
        return self.model.objects.filter(
            state__name=row["state"],
            name=row["city"]
        )

# Register your models here.
class LedgersResource(resources.ModelResource):

    class Meta:
        model = LedgersType
        import_id_fields = ('name',)


class LedgersAdmin(ImportExportModelAdmin):
    list_display = ('id', 'under', 'name')
    resource_class = LedgersResource


# -------------------------------------------------------------------------Party Master
class Party_masterResource(resources.ModelResource):

    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))
    region = fields.Field(column_name="region", attribute="region",
                          widget=RegionForeignKeyWidget(Region, field="name"))
    zsm = fields.Field(column_name="zsm", attribute="zsm",
                            widget=ZsmForeignKeyWidget(Zsm, field="name"))
    rsm = fields.Field(column_name="rsm", attribute="rsm",
                            widget=RsmForeignKeyWidget(Rsm, field="name"))
    asm = fields.Field(column_name="asm", attribute="asm",
                            widget=AsmForeignKeyWidget(Asm, field="name"))
    se = fields.Field(column_name="se", attribute="se",
                           widget=SeForeignKeyWidget(Se, field="name"))
    party_type = fields.Field(column_name="party_type", attribute="party_type",
                              widget=ForeignKeyWidget(PartyType, field="name"))
    group = fields.Field(column_name="group", attribute="group",
                         widget=ForeignKeyWidget(Group, field="name"))
    price_level = fields.Field(column_name="price_level", attribute="price_level",
                               widget=ForeignKeyWidget(Price_level, field="name"))
    country = fields.Field(column_name="country", attribute="country",
                           widget=ForeignKeyWidget(Country, field="name"))
    state = fields.Field(column_name="state", attribute="state",
                         widget=StateForeignKeyWidget(State, field="name"))
    city = fields.Field(column_name="city", attribute="city",
                        widget=CityForeignKeyWidget(City, field="name"))
    devision = fields.Field(column_name="devision", attribute="devision",
                        widget=ForeignKeyWidget(Division, field="name"))

    class Meta:
        model = Party_master
        import_id_fields = ('id',)


class Party_masterAdmin(ImportExportModelAdmin):
    list_display = ('id', 'group', 'name','vendor_code',
                    'price_level', 'region', 'zone', 'pin_code')

    resource_class = Party_masterResource

# -------------------------------------------------------------------------Party Contact Details


class Party_contact_detailsResource(resources.ModelResource):
    party = fields.Field(column_name="party", attribute="party",
                        widget=ForeignKeyWidget(Party_master, field="vendor_code"))
    country = fields.Field(column_name="country", attribute="country",
                           widget=ForeignKeyWidget(Country, field="name"))
    state = fields.Field(column_name="state", attribute="state",
                         widget=StateForeignKeyWidget(State, field="name"))
    city = fields.Field(column_name="city", attribute="city",
                        widget=CityForeignKeyWidget(City, field="name"))    
    class Meta:
        model = Party_contact_details
        import_id_fields = ('id',)


class Party_contact_detailsAdmin(ImportExportModelAdmin):
    list_display = ('id', 'party', 'address_type', 'pin_code', 'gstin')
    resource_class = Party_contact_detailsResource

# -------------------------------------------------------------------------Party Type


class PartyTypeResource(resources.ModelResource):

    class Meta:
        model = PartyType
        import_id_fields = ('name',)


class PartyTypeAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = PartyTypeResource

# -------------------------------------------------------------------------Price Level


class Price_levelResource(resources.ModelResource):


    class Meta:
        model = Price_level
        import_id_fields = ('id',)


class Price_levelAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = Price_levelResource

# -------------------------------------------------------------------------Price List


class Price_listResource(resources.ModelResource):


    price_level = fields.Field(column_name="price_level", attribute="price_level",
                         widget=ForeignKeyWidget(Price_level, field="name"))

    product = fields.Field(column_name="product", attribute="product",
                         widget=ForeignKeyWidget(Product_master, field="product_code"))

    class Meta:
        model = Price_list
        import_id_fields = ('id',)


class Price_listAdmin(ImportExportModelAdmin):
    list_display = ('id', 'price_level', 'product', 'rate', 'applicable_from')
    resource_class = Price_listResource

# -------------------------------------------------------------------------Zone


class ZoneResource(resources.ModelResource):

    class Meta:
        model = Zone
        import_id_fields = ('name',)


class ZoneAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = ZoneResource

# -------------------------------------------------------------------------Region


class RegionResource(resources.ModelResource):

    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))

    class Meta:
        model = Region
        import_id_fields = ('zone','name',)


class RegionAdmin(ImportExportModelAdmin):
    list_display = ('id', 'zone', 'name')
    resource_class = RegionResource

# -------------------------------------------------------------------------Zsm

class ZsmResource(resources.ModelResource):

    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))

    class Meta:
        model = Zsm
        import_id_fields = ('zone', 'name')



class ZsmAdmin(ImportExportModelAdmin):
    list_display = ('id','zone', 'name')
    resource_class = ZsmResource
# -------------------------------------------------------------------------Zsm

class RsmResource(resources.ModelResource):

    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))
    region = fields.Field(column_name="region", attribute="region",
                          widget=RegionForeignKeyWidget(Region, field="name"))
    zsm = fields.Field(column_name="zsm", attribute="zsm",
                          widget=ZsmForeignKeyWidget(Zsm, field="name"))

    class Meta:
        model = Rsm
        import_id_fields = ('zone','region','zsm','name')



class RsmAdmin(ImportExportModelAdmin):
    list_display = ('id','zone', 'zsm','region', 'name')
    resource_class = RsmResource

# -------------------------------------------------------------------------Asm


class AsmResource(resources.ModelResource):

    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))

    region = fields.Field(column_name="region", attribute="region",
                          widget=RegionForeignKeyWidget(Region, field="name"))

    zsm = fields.Field(column_name="zsm", attribute="zsm",
                          widget=ZsmForeignKeyWidget(Zsm, field="name"))

    rsm = fields.Field(column_name="rsm", attribute="rsm",
                          widget=RsmForeignKeyWidget(Rsm, field="name"))

    class Meta:
        model = Asm
        import_id_fields = ('zone','region','zsm','rsm','name')

class AsmAdmin(ImportExportModelAdmin):
    list_display = ('id','zone', 'region', 'zsm','rsm', 'name')
    resource_class = AsmResource


# -------------------------------------------------------------------------Se
class SeResource(resources.ModelResource):
    zone = fields.Field(column_name="zone", attribute="zone",
                        widget=ForeignKeyWidget(Zone, field="name"))

    region = fields.Field(column_name="region", attribute="region",
                          widget=RegionForeignKeyWidget(Region, field="name"))

    zsm = fields.Field(column_name="zsm", attribute="zsm",
                          widget=ZsmForeignKeyWidget(Zsm, field="name"))

    rsm = fields.Field(column_name="rsm", attribute="rsm",
                          widget=RsmForeignKeyWidget(Rsm, field="name"))

    asm = fields.Field(column_name="asm", attribute="asm",
                          widget=AsmForeignKeyWidget(Asm, field="name"))

    class Meta:
        model = Se


class SeAdmin(ImportExportModelAdmin):
    list_display = ('id','zone', 'region', 'zsm','rsm' ,'asm', 'name')
    resource_class = SeResource


# -------------------------------------------------------------------------Counntry


class CountryResource(resources.ModelResource):

    class Meta:
        model = Country
        import_id_fields = ('name',)


class CountryAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = CountryResource

# -------------------------------------------------------------------------State


class StateResource(resources.ModelResource):

    country = fields.Field(column_name="country", attribute="country",
                           widget=ForeignKeyWidget(Country, field="name"))

    class Meta:
        model = State
        import_id_fields = ('name',)


class StateAdmin(ImportExportModelAdmin):
    list_display = ('id', 'country', 'name')
    resource_class = StateResource

# -------------------------------------------------------------------------City


class CityResource(resources.ModelResource):

    state = fields.Field(column_name="state", attribute="state",
                         widget=ForeignKeyWidget(State, field="name"))

    class Meta:
        model = City
        import_id_fields = ('name',)


class CityAdmin(ImportExportModelAdmin):
    list_display = ('id', 'state', 'name')
    resource_class = CityResource


# ---------------------------------------------------------------------------Accounting Master
admin.site.register(Party_master, Party_masterAdmin)
admin.site.register(Party_contact_details, Party_contact_detailsAdmin)
admin.site.register(PartyType, PartyTypeAdmin)
admin.site.register(Price_level, Price_levelAdmin)
admin.site.register(Price_list, Price_listAdmin)
admin.site.register(Region, RegionAdmin)
admin.site.register(Zone, ZoneAdmin)
admin.site.register(Zsm, ZsmAdmin)
admin.site.register(Rsm, RsmAdmin)
admin.site.register(Asm, AsmAdmin)
admin.site.register(Se, SeAdmin)
admin.site.register(Country, CountryAdmin)
admin.site.register(State, StateAdmin)
admin.site.register(City, CityAdmin)
admin.site.register(LedgersType, LedgersAdmin)


# -------------------------------------------------------------------------City


class Stock_summaryResource(resources.ModelResource):

    company = fields.Field(column_name="company", attribute="company",
                         widget=ForeignKeyWidget(Company, field="name"))

    product = fields.Field(column_name="product", attribute="product",
                         widget=ForeignKeyWidget(Product_master, field="product_code"))

    godown = fields.Field(column_name="godown", attribute="godown",
                         widget=ForeignKeyWidget(Godown, field="name"))

    class Meta:
        model = Stock_summary


class Stock_summaryAdmin(ImportExportModelAdmin):
    list_display = ('id', 'company', 'product',  'mrp', 'batch', 'rate' , 'godown','closing_balance' )
    resource_class = Stock_summaryResource

admin.site.register(Stock_summary, Stock_summaryAdmin)

admin.site.register(Group)
admin.site.register(Division)