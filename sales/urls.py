from django.urls import path
from . import views

app_name="sales"

urlpatterns = [

    path('sales', views.sales, name="sales"),

    path('list/so', views.solist.as_view(), name="so"),
    path('list/ecom/so', views.ecomsolist.as_view(), name="ecomso"),
    path('list/dn', views.dnlist.as_view(), name="dn"),
    path('list/inv', views.invlist.as_view(), name="inv"),
    path('list/proformainv', views.proformainvlist.as_view(), name="proformainv"),
    path('list/cn', views.creditnote.as_view(), name="cn"),
    path('list/qdn', views.qdn.as_view(), name="qdn"),
    path('list/rso', views.rso.as_view(), name="rso"),
    path('list/creditmemo', views.creditmemo.as_view(), name="creditmemo"),
    path('list/targetsat', views.targetsat.as_view(), name="targetsat"),

    path('so', views.so, name="addso"),
    path('ecomso', views.ecomso, name="addecomso"),
    path('dn', views.dn, name="adddn"),
    path('inv', views.inv, name="addinv"),
    path('proformainv', views.proformainv, name="addproformainv"),
    path('add/cn', views.addcn, name="addcn"),
    path('add/qdn', views.addqdn, name="addqdn"),
    path('add/rso', views.addrso, name="addrso"),
    path('add/creditmemo', views.addcreditmemo, name="addcreditmemo"),
    path('add/targetsat', views.addtargetsat, name="addtargetsat"),

    path('add/lr', views.addlr.as_view(), name="addlr"),
    path('update/lr/<pk>', views.updatelr, name="updatelr"),
    path('cancel/lr/<pk>', views.cancellr, name="cancellr"),

    path('add/tp', views.addtp.as_view(), name="addtp"),
    path('update/tp/<pk>', views.updatetp, name="updatetp"),
    path('cancel/tp/<pk>', views.canceltp, name="canceltp"),

    path('show/so/<pk>', views.soshow, name="showso"),
    path('show/ecomso/<pk>', views.ecomsoshow, name="showecomso"),
    path('show/dn/<pk>', views.dnshow, name="showdn"),
    path('show/inv/<pk>', views.invshow, name="showinv"),
    path('show/proformainv/<pk>', views.proformainvshow, name="showproformainv"),
    path('show/cn/<pk>', views.cnshow, name="showcn"),
    path('show/qdn/<pk>', views.qdnshow, name="showqdn"),
    path('show/rso/<pk>', views.rsoshow, name="showrso"),
    # path('show/targetsat/<pk>', views.showtargetsat, name="showtargetsat"),

    path('edit/so/<pk>', views.soedit, name="editso"),
    path('edit/ecomso/<pk>', views.ecomsoedit, name="editecomso"),
    path('edit/dn/<pk>', views.dnedit, name="editdn"),
    path('edit/proforma/<pk>', views.proformaedit, name="editproformainv"),

    path('cancel/so/<pk>', views.socancel, name="cancelso"),
    path('cancel/ecomso/<pk>', views.ecomsocancel, name="cancelecomso"),
    path('cancel/dn/<pk>', views.dncancel, name="canceldn"),
    path('cancel/inv/<pk>', views.invcancel, name="cancelinv"),
    path('cancel/proformainv/<pk>', views.proformainvcancel, name="cancelproformainv"),
    path('cancel/cn/<pk>', views.cncancel, name="cancelcn"),
    path('cancel/qdn/<pk>', views.qdncancel, name="cancelqdn"),
    path('cancel/rso/<pk>', views.rsocancel, name="cancelrso"),

    path('ls', views.ls, name="ls"),
    path('ps', views.pslist.as_view(), name="ps"),
    path('add/ps', views.addps, name="addps"),
    path('edit/ps/<pk>', views.editps, name="editps"),

    path('pdf/ls', views.lspdf, name="lspdf"),
    path('pdf/ps/<pk>', views.pspdf, name="pspdf"),
    path('pdf/inv/<pk>', views.invpdf, name="invpdf"),
    path('pdf/proformainv/<pk>', views.proformainvpdf, name="proformainvpdf"),
    path('pdf/so/<pk>', views.sopdf, name="sopdf"),
    path('pdf/cn/<pk>', views.cnpdf, name="cnpdf"),
    path('pdf/qdn/<pk>', views.qdnpdf, name="qdnpdf"),
    path('pdf/rso/<pk>', views.rsopdf, name="rsopdf"),
    path('pdf/dn/<pk>', views.dnpdf, name="dnpdf"),

    #-----------------------------------------------------------------------------------Send TO Tally------------

    path('send/inv/<pk>', views.sendinv, name="sendinv"),
    path('send/cn/<pk>', views.sendcn, name="sendcn"),
    path('send/qdn/<pk>', views.sendqdn, name="sendqdn"),
    path('send/rso/<pk>', views.sendrso, name="sendrso"),
    path('send/sendcreditmemo/<pk>', views.sendcreditmemo, name="sendcreditmemo"),

    #-----------------------------------------------------------------------------------Send Mail------------

    path('mail/inv/<pk>', views.mailinv, name="mailinv"),
    path('mail/so/<pk>', views.mailso, name="mailso"),
    path('mail/proformainv/<pk>', views.mailproformainv, name="mailproformainv"),
    path('mail/cn/<pk>', views.mailcn, name="mailcn"),
    path('mail/qdn/<pk>', views.mailqdn, name="mailqdn"),
    path('mail/rso/<pk>', views.mailrso, name="mailrso"),

    #  ----------------------------------------------------------------------------------Ajax-Requests-----------

    path('ajax/party_address/', views.party_address, name='ajax_load_party_address'),
    path('ajax/address/', views.address, name='ajax_load_address'),
    path('ajax/product_code/', views.product_code, name='ajax_load_product_code'),
    path('ajax/ict_product_code/', views.ict_product_code, name='ajax_load_ict_product_code'),
    path('ajax/product_pack/', views.product_pack, name='ajax_load_product_pack'),
    path('ajax/product_mrp/', views.product_mrp, name='ajax_load_product_mrp'),
    path('ajax/product_stock/', views.product_stock, name='ajax_load_product_stock'),
    path('ajax/product_rate/', views.product_rate, name='ajax_load_product_rate'),
    path('ajax/product_gst/', views.product_gst, name='ajax_load_product_gst'),
    path('ajax/load-so/', views.load_so, name='ajax_load_so_details'),
    path('ajax/load-so-upload/', views.load_so_upload, name='ajax_load_so_upload'),
    path('ajax/load-creditmemo-upload/', views.load_creditmemo_upload, name='ajax_load_creditmemo_upload'),
    path('ajax/load-target-upload/', views.load_target_upload, name='ajax_load_target_upload'),
    path('ajax/load-dn/', views.load_dn, name='ajax_load_dn_details'),
    path('ajax/load-dn-items/', views.load_dn_items, name='ajax_load_dn_items'),

    path('ajax/load-month-inv/', views.load_month_inv, name='ajax_load_month_inv'),
    path('ajax/load-cn/', views.load_cn, name='ajax_load_cn'),
    path('ajax/load-qdn/', views.load_qdn, name='ajax_load_qdn'),
    path('ajax/load-rso/',views.load_rso,name='ajax_load_rso'),
    path('ajax/load-ivt/',views.load_ivt,name='ajax_load_ivt'),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/so-item/', views.item, name='so-item'),
    path('htmx/target-item/', views.targetitem, name='target-item'),
    path('htmx/godown-item/', views.godownitem, name='godown-item'),

]