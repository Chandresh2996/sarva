from django.contrib import admin
from import_export.widgets import ForeignKeyWidget
from import_export import resources, fields
from import_export.admin import ImportExportModelAdmin
from inventory.models import Brand, Category, Class, Godown, Gst_list, Product_master, ProductType, Scheme, Std_rate, SubBrand, SubClass, UnitOfMeasure, Uqc, Currency
from ledgers.models import LedgersType
from planning.models import Bom, BomItems

# Register your models here.


class ProductResource(resources.ModelResource):

    dl_sales = fields.Field(column_name="dl_sales", attribute="dl_sales",
                            widget=ForeignKeyWidget(LedgersType, field="name"))
    dl_purchase = fields.Field(column_name="dl_purchase", attribute="dl_purchase",
                               widget=ForeignKeyWidget(LedgersType, field="name"))
    brand = fields.Field(column_name="brand", attribute="brand",
                         widget=ForeignKeyWidget(Brand, field="name"))
    category = fields.Field(column_name="category", attribute="category",
                            widget=ForeignKeyWidget(Category, field="name"))
    product_class = fields.Field(
        column_name="product_class", attribute="product_class", widget=ForeignKeyWidget(Class, field="name"))
    sub_brand = fields.Field(column_name="sub_brand", attribute="sub_brand",
                             widget=ForeignKeyWidget(SubBrand, field="name"))
    sub_class = fields.Field(column_name="sub_class", attribute="sub_class",
                             widget=ForeignKeyWidget(SubClass, field="name"))
    product_type = fields.Field(column_name="product_type", attribute="product_type",
                                widget=ForeignKeyWidget(ProductType, field="name"))
    units_of_measure = fields.Field(column_name="units_of_measure", attribute="units_of_measure",
                                    widget=ForeignKeyWidget(UnitOfMeasure, field="symbol"))
    additional_units = fields.Field(column_name="additional_units", attribute="additional_units",
                                    widget=ForeignKeyWidget(UnitOfMeasure, field="name"))

    class Meta:
        model = Product_master
        import_id_fields = ('id',)
        fields = ('id','product_code', 'product_name', 'dl_sales', 'dl_purchase', 'description',
                  'notes', 'brand', 'category', 'product_class', 'sub_class',
                  'sub_brand', 'product_type', 'units_of_measure', 'additional_units',
                  'is_batch', 'track_dom', 'exp_date', 'bill_of_material', 'set_std_rate',
                  'costing_method', 'valuation_method', 'article_code', 'ean_code', 'old_product_code',
                  'behaviour', 'ipd', 'ins', 'tsm', 'tpc', 'trs',
                  'shape_code', 'size', 'style_shape', 'series', 'pattern', 'country_of_origin',
                  'color_shade_theme', 'inner_qty', 'outer_qty', 'imported_by', 'mfd_by', 'mkt_by',
                  'mrp', 'gst')


class ProductAdmin(ImportExportModelAdmin):
    resource_class = ProductResource
    list_display =  ['id','product_code','style_shape', 'mrp']
# -------------------------------------------------------------------------Brand


class BrandResource(resources.ModelResource):

    class Meta:
        model = Brand
        import_id_fields = ('name',)


class BrandAdmin(ImportExportModelAdmin):
    list_display = ('id', 'under', 'name', 'code')
    resource_class = BrandResource

# -------------------------------------------------------------------------SubBrand


class SubBrandResource(resources.ModelResource):

    class Meta:
        model = SubBrand
        import_id_fields = ('name',)


class SubBrandAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = SubBrandResource

# -------------------------------------------------------------------------Class


class ClassResource(resources.ModelResource):

    class Meta:
        model = Class
        import_id_fields = ('name',)


class ClassAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = ClassResource

# -------------------------------------------------------------------------SubClass


class SubClassResource(resources.ModelResource):

    class Meta:
        model = SubClass
        import_id_fields = ('name',)


class SubClassAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = SubClassResource

# -------------------------------------------------------------------------Category


class CategoryResource(resources.ModelResource):

    class Meta:
        model = Category
        import_id_fields = ('name',)


class CategoryAdmin(ImportExportModelAdmin):
    list_display = ('id', 'under', 'name')
    resource_class = CategoryResource

# -------------------------------------------------------------------------Uqc


class UqcResource(resources.ModelResource):

    class Meta:
        model = Uqc
        import_id_fields = ('name',)


class UqcAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = UqcResource

# --------------------------------------------------------------------------UOM


class UnitOfMeasureResource(resources.ModelResource):

    uqc = fields.Field(column_name="uqc", attribute="uqc",
                       widget=ForeignKeyWidget(Uqc, field="name"))

    class Meta:
        model = UnitOfMeasure
        import_id_fields = ('name',)


class UnitOfMeasureAdmin(ImportExportModelAdmin):
    list_display = ('id', 'symbol', 'name', 'uqc', 'decimal_places')
    resource_class = UnitOfMeasureResource

# ---------------------------------------------------------------------------Product Type

class ProductTypeResource(resources.ModelResource):

    class Meta:
        model = ProductType
        import_id_fields = ('name',)


class ProductTypeAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    resource_class = ProductTypeResource

# -------------------------------------------------------------------------Gst_list


class Gst_listResource(resources.ModelResource):

    product = fields.Field(column_name="product", attribute="product",
                           widget=ForeignKeyWidget(Product_master, field="product_code"))

    class Meta:
        model = Gst_list
        import_id_fields = ('id',)
        use_bulk = True
        # force_init_instance = True
        batch_size = 1000

class Gst_listAdmin(ImportExportModelAdmin):
    list_display = ('id', 'product', 'applicable_from','taxability')
    resource_class = Gst_listResource


# -------------------------------------------------------------------------Godown
class GodownResource(resources.ModelResource):

    parent = fields.Field(column_name="parent", attribute="parent",
                          widget=ForeignKeyWidget(Godown, field="name"))

    class Meta:
        model = Godown
        import_id_fields = ('name',)


class GodownAdmin(ImportExportModelAdmin):
    list_display = ('id', 'parent', 'name', 'godown_type')
    resource_class = GodownResource

# -------------------------------------------------------------------------Std_rate


class Std_rateResource(resources.ModelResource):

    product = fields.Field(column_name="product", attribute="product",
                           widget=ForeignKeyWidget(Product_master, field="product_code"))

    class Meta:
        model = Std_rate
        import_id_fields = ('name',)


class Std_rateAdmin(ImportExportModelAdmin):
    list_display = ('id', 'product',
                    'rate_type', 'rate', 'applicable_from')
    resource_class = Std_rateResource


# -------------------------------------------------------------------------BomItems


class BomItemsResource(resources.ModelResource):

    bom = fields.Field(column_name="bom", attribute="bom", widget=ForeignKeyWidget(Bom, field="name"))
    item = fields.Field(column_name="item", attribute="item", widget=ForeignKeyWidget(Product_master, field="product_code"))
    class Meta:
        model = BomItems
        import_id_fields = ('id',)


class BomItemsAdmin(ImportExportModelAdmin):
    list_display = ('id', 'bom', 'item', 'qty')
    resource_class = BomItemsResource

# -------------------------------------------------------------------------Bom


class BomResource(resources.ModelResource):

    product = fields.Field(column_name="product", attribute="product",
                           widget=ForeignKeyWidget(Product_master, field="product_code"))

    class Meta:
        model = Bom
        import_id_fields = ('id',)


class BomAdmin(ImportExportModelAdmin):
    list_display = ('id', 'product', 'name')
    resource_class = BomResource


admin.site.register(Product_master, ProductAdmin)
admin.site.register(Brand, BrandAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(UnitOfMeasure, UnitOfMeasureAdmin)
admin.site.register(ProductType, ProductTypeAdmin)
admin.site.register(SubBrand, SubBrandAdmin)
admin.site.register(Class, ClassAdmin)
admin.site.register(SubClass, SubClassAdmin)
admin.site.register(Godown, GodownAdmin)
admin.site.register(Gst_list, Gst_listAdmin)
admin.site.register(Std_rate, Std_rateAdmin)
admin.site.register(BomItems, BomItemsAdmin)
admin.site.register(Bom, BomAdmin)
admin.site.register(Uqc, UqcAdmin)
admin.site.register(Scheme)
admin.site.register(Currency)