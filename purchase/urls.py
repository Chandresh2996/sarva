from django.urls import path
from . import views

app_name="purchase"

urlpatterns = [

    path('', views.purchases, name="purchase"),

    path('purchase-order', views.PurchaseOrder.as_view(), name="po"),
    path('StandardRate', views.StandardRate.as_view(), name="stdrate"),
    path('list/grn', views.GrnView.as_view(), name="grn"),
    path('list/pi', views.PurchaseView.as_view(), name="pi"),
    path('list/db', views.debitnote.as_view(), name="db"),
    path('list/qdn', views.quantity_dn.as_view(), name="qdn"),
    path('list/pr', views.purchase_return.as_view(), name="pr"),

    path('add/po', views.addpo, name="addpo"),
    path('add/sr', views.addsr, name="addsr"),
    path('edit/sr', views.editsr, name="editsr"),
    path('add/grn', views.addgrn, name="addgrn"),
    path('add/pi', views.addpi, name="addpi"),
    path('add/db', views.adddb, name="adddb"),
    path('add/qdn', views.addqdn, name="addqdn"),
    path('add/pr', views.addpr, name="addpr"),

    path('show/po/<pk>', views.poshow, name="showpo"),
    path('show/grn/<pk>', views.grnshow, name="showgrn"),
    path('show/pi/<pk>', views.pishow, name="showpi"),
    path('show/db/<pk>', views.dbshow, name="showdb"),
    path('show/qdn/<pk>', views.qdnshow, name="showqdn"),
    path('show/pr/<pk>', views.prshow, name="showpr"),

    path('amend/po/<pk>', views.poamend, name="amendpo"),

    path('edit/po/<pk>', views.poedit, name="editpo"),
    path('edit/grn/<pk>', views.grnedit, name="editgrn"),

    path('cancel/po/<pk>', views.pocancel, name="cancelpo"),
    path('cancel/grn/<pk>', views.grncancel, name="cancelgrn"),
    path('cancel/pi/<pk>', views.picancel, name="cancelpi"),
    path('cancel/db/<pk>', views.dbcancel, name="canceldb"),
    path('cancel/qdn/<pk>', views.qdncancel, name="cancelqdn"),
    path('cancel/pr/<pk>', views.prcancel, name="cancelpr"),


    # path('ls', views.ls, name="ls"),
    path('pdf/po/<pk>', views.popdf, name="popdf"),
    path('pdf/dnpdf/<pk>', views.dnpdf, name="dnpdf"),
    path('pdf/prpdf/<pk>', views.prpdf, name="prpdf"),
    path('pdf/qdnpdf/<pk>', views.qdnpdf, name="qdnpdf"),
    # path('ps', views.ps, name="ps"),
    # path('pdf/ps', views.pspdf, name="pspdf"),

    #-----------------------------------------------------------------------------------Send Mail------------

    path('mail/po/<pk>', views.mailpo, name="mailpo"),
    path('mail/dn/<pk>', views.maildn, name="maildn"),
    path('mail/pr/<pk>', views.mailpr, name="mailpr"),
    path('mail/qdn/<pk>', views.mailqdn, name="mailqdn"),

    #-----------------------------------------------------------------------------------Send TO Tally------------

    path('send/pi/<pk>', views.sendpi, name="sendpi"),
    path('send/db/<pk>', views.senddb, name="senddb"),
    path('send/qdn/<pk>', views.sendqdn, name="sendqdn"),
    path('send/pr/<pk>', views.sendpr, name="sendpr"),

    #  ----------------------------------------------------------------------------------Ajax-Requests-----------

    path('ajax/party_address/', views.party_address, name='ajax_load_party_address'),
    path('ajax/address/', views.address, name='ajax_load_address'),
    path('ajax/product_code/', views.product_code, name='ajax_load_product_code'),
    path('ajax/product_pack/', views.product_pack, name='ajax_load_product_pack'),
    path('ajax/product_std_rate/', views.product_std_rate, name='ajax_load_product_std_rate'),

    path('ajax/product_mrp/', views.product_mrp, name='ajax_load_product_mrp'),
    path('ajax/product_stock/', views.product_stock, name='ajax_load_product_stock'),
    path('ajax/product_rate/', views.product_rate, name='ajax_load_product_rate'),
    path('ajax/load-po/', views.load_po, name='ajax_load_po_details'),
    path('ajax/load-po-upload/', views.load_po_upload, name='ajax_load_po_upload'),
    path('ajax/load-grnlist/', views.load_grnlist, name='ajax_load_grn_list'),
    path('ajax/load-grn/', views.load_grn, name='ajax_load_grn_details'),

    path('ajax/load-db/', views.load_db, name='ajax_load_db'),
    path('ajax/load-qdn/', views.load_qdn, name='ajax_load_qdn'),
    path('ajax/load-pr/',views.load_pr,name='ajax_load_pr'),
    path('ajax/load-skuname/',views.load_skuname,name='ajax_load_skuname'),
    path('ajax/load-sr-upload/', views.load_sr_upload, name='load_sr_upload'),
    path('standard-cost-import-data/', views.standard_cost_import_data, name='standard_cost_import_data'),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/po-item/', views.item, name='po-item'),
    path('htmx/ivt-item/', views.ivtitem, name='ivt-item'),

]