from django.urls import path
from . import views

app_name="reports"

urlpatterns = [

    path('sls-reports', views.sls_reports, name="sales-reports"),
    path('wrh-reports', views.wrh_reports, name="warehouse-reports"),
    path('prd-reports', views.prd_reports, name="production-reports"),
    path('prs-reports', views.prs_reports, name="purchase-reports"),
    path('ivt-reports', views.ivt_reports, name="inventory-reports"),

    # path('ajax_datatable/permissions', views.PermissionAjaxDatatableView.as_view(), name="ajax_datatable_permissions"),
    # path('ajax_datatable/products', views.ProductAjaxDatatableView.as_view(), name="ajax_datatable_pm"),
    # path('permissions', views.permissions, name="permissions"),

    path('pm', views.pm, name="pm"),
    path('pmdata', views.pmdata, name="pmdata"),

    path('cm', views.cm, name="cm"),
    path('cmdata', views.cmdata, name="cmdata"),

    path('vm', views.vm, name="vm"),
    path('vmdata', views.vmdata, name="vmdata"),
    
    path('dn', views.dn, name="dn"),
    path('dndata', views.dndata, name="dndata"),
    
    path('ddn', views.ddn, name="ddn"),
    path('ddndata', views.ddndata, name="ddndata"),

    path('grn', views.grn, name="grn"),
    path('grndata', views.grndata, name="grndata"),
    
    path('po', views.po, name="po"),
    path('podata', views.podata, name="podata"),
    
    path('pogrn', views.pogrn, name="pogrn"),
    path('pogrndata', views.pogrndata, name="pogrndata"),
    
    path('purchase', views.purchase, name="purchase"),
    path('purchasedata', views.purchasedata, name="purchasedata"),

    path('standardcost', views.standardcost, name="standardcost"),
    path('standardcostdata', views.standardcostdata, name="standardcostdata"),
    
    path('so', views.so, name="so"),
    path('sodata', views.sodata, name="sodata"),
    
    path('inv', views.inv, name="inv"),
    path('invdata', views.invdata, name="invdata"),

    path('stock', views.stock, name="stock"),
    path('stockdata', views.stockdata, name="stockdata"),

    path('inventory', views.inventory, name="inventory"),
    path('inventorydata', views.inventorydata, name="inventorydata"),

    path('itemsoldcount', views.itemsoldcount, name='itemsoldcount'),

    path('sm', views.sm, name="sm"),
    path('smdata', views.smdata, name="smdata"),

    path('sodninv', views.sodninv, name="sodninv"),
    path('sodninvdata', views.sodninvdata, name="sodninvdata"),

    # path('prd', views.production, name="production"),
    # path('prddata', views.productiondata, name="productiondata"),

    path('bom', views.bom, name="bom"),
    path('bomdata', views.bomdata, name="bomdata"),

    # path('consumption', views.consumption, name="consumption"),
    # path('consumptiondata', views.consumptiondata, name="consumptiondata"),

    path('weeksales', views.weeksales, name="weeksales"),
    path('filterdivision', views.filterdivision, name="filterdivision"),

    path('citysales', views.citysales, name="citysales"),
    path('customersales', views.customersales, name="customersales"),
    path('zonesales', views.zonesales, name="zonesales"),
    path('brandsales', views.brandsales, name="brandsales"),
    path('classsales', views.classsales, name="classsales"),
    path('subclasssales', views.subclasssales, name="subclasssales"),
    path('productsales', views.productsales, name="productsales"),
    path('productvspartysales', views.productvspartysales, name="productvspartysales"),
    path('statesales', views.statesales, name="statesales"),
    path('zonewisebrandreport', views.zonewisebrandreport, name="zonewisebrandreport"),
    path('quarterwisebrandreport', views.quarterwisebrandreport, name="quarterwisebrandreport"),
    path('scorecard', views.scorecard, name="scorecard"),

    path('paymentreceivable', views.paymentreceivable, name="paymentreceivable"),
    path('paymentreceivabledata', views.paymentreceivabledata, name="paymentreceivabledata"),
    path('multiaddress', views.multiaddress, name="multiaddress"),
    path('multiaddressdata', views.multiaddressdata, name="multiaddressdata"),
    path('paymentPayable', views.paymentPayable, name="paymentPayable"),
    path('paymentPayabledata', views.paymentPayabledata, name="paymentPayabledata"),

    path('hsn', views.hsn, name="hsn"),
    path('hsndata', views.hsndata, name="hsndata"),

    path('pallet', views.pallet, name="pallet"),
    path('palletdata', views.palletdata, name="palletdata"),

    path('shortage', views.shortage, name="shortage"),
    path('shortagedata', views.shortagedata, name="shortagedata"),

    path('prdtrack', views.prdtrack, name="prdtrack"),
    path('prdtrackdata', views.prdtrackdata, name="prdtrackdata"),

    path('rmindent', views.rmindent, name="rmindent"),
    path('rmindentdata', views.rmindentdata, name="rmindentdata"),

    path('prd', views.prd, name="prd"),
    path('prddata', views.prddata, name="prddata"),
]