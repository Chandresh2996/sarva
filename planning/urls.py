from django.urls import path
from . import views

app_name="planning"

urlpatterns = [
    path('bom', views.BomView.as_view(), name="bom"),
    path('bom/add', views.add_bom, name="add_bom"),
    path('bom/edit/<pk>', views.edit_bom, name="edit_bom"),
    path('bom/show/<pk>', views.show_bom, name="show_bom"),

    path('joborder', views.JobOrderView.as_view(), name="joborder"),
    path('joborder/add', views.add_joborder, name="add_joborder"),
    path('joborder/edit/<pk>', views.edit_joborder, name="edit_joborder"),
    path('joborder/show/<pk>', views.show_joborder, name="show_joborder"),

    path('load-boms', views.loadbom, name="ajax_load_boms"),
    path('load-product-boms', views.load_productbom, name="ajax_load_product_boms"),
    path('load-rmindent', views.load_rmindent, name="ajax_load_rmindent"),
]