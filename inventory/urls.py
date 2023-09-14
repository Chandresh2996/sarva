from django.urls import path
from . import views

app_name="inventory"

urlpatterns = [
    path('', views.inventory, name="inventory"),
    path('stock-query', views.search, name="search"),

    path('product', views.product.as_view(), name="product"),
    path('product/create', views.add_product, name="add_product"),
    path('product/edit/<pk>', views.edit_product, name="edit_product"),
    path('product/show/<pk>', views.show_product, name="show_product"),
    path('product/delete/<pk>', views.delete_product, name="delete_product"),

    path('brand', views.ProductBrandView.as_view(), name="brand"),
    path('brand/create', views.add_brand.as_view(), name="add_brand"),
    path('brand/edit/<pk>', views.edit_brand.as_view(), name="edit_brand"),

    path('category', views.ProductCategoryView.as_view(), name="category"),
    path('category/create', views.add_category.as_view(), name="add_category"),
    path('category/edit/<pk>', views.edit_category.as_view(), name="edit_category"),

    path('class', views.ProductClassView.as_view(), name="class"),
    path('class/create', views.add_class.as_view(), name="add_class"),
    path('class/edit/<pk>', views.edit_class.as_view(), name="edit_class"),

    path('currency', views.currencyView.as_view(), name="currency"),
    path('currency/create', views.add_currency.as_view(), name="add_currency"),
    path('currency/edit/<pk>', views.edit_currency.as_view(), name="edit_currency"),
    path('currency/show/<pk>', views.show_currency, name="show_currency"),

    path('subclass', views.ProductSubClassView.as_view(), name="subclass"),
    path('subclass/create', views.add_subclass.as_view(), name="add_subclass"),
    path('subclass/edit/<pk>', views.edit_subclass.as_view(), name="edit_subclass"),

    path('subbrand', views.ProductSubBrandView.as_view(), name="subbrand"),
    path('subbrand/create', views.add_subbrand.as_view(), name="add_subbrand"),
    path('subbrand/edit/<pk>', views.edit_subbrand.as_view(), name="edit_subbrand"),

    path('godown', views.GodownView.as_view(), name="godown"),
    path('godown/create', views.add_godown.as_view(), name="add_godown"),
    path('godown/edit/<pk>', views.edit_godown.as_view(), name="edit_godown"),

    path('pricelist', views.pricelist, name="pricelist"),
    path('pricelist/create', views.add_pricelist, name="add_pricelist"),
    path('pricelist/edit/<pk>', views.edit_pricelist, name="edit_pricelist"),
    path('pricelistdata', views.pricelistdata, name="pricelistdata"),

    path('uom', views.UomView.as_view(), name="uom"),
    path('uom/create/', views.add_uom.as_view(), name="add_uom"),
    path('uom/edit/<pk>', views.edit_uom.as_view(), name="edit_uom"),

    path('product_type', views.ProductTypeView.as_view(), name="product_type"),
    path('product_type/create', views.add_product_type.as_view(), name="add_product_type"),
    path('product_type/edit/<pk>', views.edit_product_type.as_view(), name="edit_product_type"),

    path('pricelevel', views.PricelevelView.as_view(), name="pricelevel"),
    path('pricelevel/add', views.add_pricelevel.as_view(), name="add_pricelevel"),
    path('pricelevel/edit/<pk>', views.edit_pricelevel.as_view(), name="edit_pricelevel"),
    path('pricelistheader', views.pricelistheader, name="pricelistheader"),

    path('ict', views.ict, name="ict"),
    path('ict/add', views.add_ict, name="add_ict"),
    path('ict/edit/<pk>', views.edit_ict, name="edit_ict"),
    path('ict/show/<pk>', views.show_ict, name="show_ict"),

    path('ivt', views.ivt, name="ivt"),
    path('ivt/add', views.add_ivt, name="add_ivt"),
    path('ivt/edit/<pk>', views.edit_ivt, name="edit_ivt"),
    path('ivt/show/<pk>', views.show_ivt, name="show_ivt"),

    path('ivt/add_sale', views.add_ivt_sale, name="add_ivt_sale"),
    path('ivt/edit_sale/<pk>', views.edit_ivt_sale, name="edit_ivt_sale"),
    path('ivt/show_sale/<pk>', views.show_ivt_sale, name="show_ivt_sale"),

    # ------------------------------------------------------------------------------------Upload-----------------
    path('upload/pm', views.pm_import_data, name="product_import_data"),
    path('upload/pl', views.pl_import_data, name="pl_import_data"),
    path('upload/sc', views.sc_import_data, name="sc_import_data"),

    #  ----------------------------------------------------------------------------------Ajax-Requests-----------

    path('ajax/load-article/', views.article, name='ajax_load_articlecode'),
    path('ajax/load-pm-upload/', views.load_pm_upload, name='load_pm_upload'),
    path('ajax/load-pl-upload/', views.load_pl_upload, name='load_pl_upload'),
    path('ajax/load_ict_upload/', views.load_ict_upload, name='load_ict_upload'),
    path('ajax/ajax_load_ledgers/', views.ajax_load_ledgers, name='ajax_load_ledgers'),

    path('ajax/load-pl-download/', views.load_pl_download, name='pl_download'),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/bom/', views.bom, name='bom'),
    path('htmx/bom-item/', views.bom_item, name='bom-item'),
    path('htmx/std/', views.std, name='std'),
    path('htmx/mrp/', views.mrp, name='mrp'),
    path('htmx/ict-item/', views.ict_item, name='ict-item'),

]