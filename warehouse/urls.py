from django.urls import path
from . import views

app_name="warehouse"

urlpatterns = [
    path('', views.warehouse, name="warehouse"),
    path('transfers/', views.transfers, name="transfers"),
    path('pt/', views.pt, name="pt"),
    path('pt-upload/', views.pt_upload, name="pt_upload"),
    path('shortage/', views.shortage, name="shortage"),

    path('ajax/products', views.load_products, name="ajax_load_products"),
    path('ajax/godowns', views.load_godowns, name="ajax_load_godowns"),
    path('ajax/qty', views.load_qty, name="ajax_load_qty"),
    path('ajax/ptqty', views.load_pt_qty, name="load_pt_qty"),

    path('htmx/tgt', views.tgt, name="targetgodown"),

]