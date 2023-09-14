from django.urls import path
from . import views

app_name="ledgers"

urlpatterns = [
    path('', views.ledgers, name="ledgers"),

    path('cm', views.Cm.as_view(), name="cm"),
    path('addcm', views.addcm, name="addcm"),
    path('edit/cm/<pk>', views.editcm, name="editcm"),
    path('show/cm/<pk>', views.showcm, name="showcm"),
    path('delete/cm/<pk>', views.deletecm, name="deletecm"),

    path('vm', views.Vm.as_view(), name="vm"),
    path('addvm', views.addvm, name="addvm"),
    path('edit/vm/<pk>', views.editvm, name="editvm"),
    path('show/vm/<pk>', views.showvm, name="showvm"),
    path('delete/vm/<pk>', views.deletevm, name="deletevm"),


    path('ledger', views.LedgersView.as_view(), name="ledger"),
    path('asm', views.AsmView.as_view(), name="asm"),
    path('zsm', views.ZsmView.as_view(), name="zsm"),
    path('rsm', views.RsmView.as_view(), name="rsm"),
    path('city', views.CityView.as_view(), name="city"),
    path('state', views.StateView.as_view(), name="state"),
    path('country', views.CountryView.as_view(), name="country"),
    path('party_type', views.PartyTypeView.as_view(), name="party_type"),
    path('region', views.RegionView.as_view(), name="region"),
    path('se', views.SeView.as_view(), name="se"),
    path('zone', views.ZoneView.as_view(), name="zone"),
    path('division', views.DivisionView.as_view(), name="division"),

    path('ledger/add', views.add_ledger, name="add_ledger"),
    path('asm/add', views.add_asm.as_view(), name="add_asm"),
    path('zsm/add', views.add_zsm.as_view(), name="add_zsm"),
    path('rsm/add', views.add_rsm.as_view(), name="add_rsm"),
    path('city/add', views.add_city.as_view(), name="add_city"),
    path('state/add', views.add_state.as_view(), name="add_state"),
    path('country/add', views.add_country.as_view(), name="add_country"),
    path('party_type/add', views.add_party_type.as_view(), name="add_party_type"),
    path('region/add', views.add_region.as_view(), name="add_region"),
    path('se/add', views.add_se.as_view(), name="add_se"),
    path('zone/add', views.add_zone.as_view(), name="add_zone"),
    path('division/add', views.add_division.as_view(), name="add_division"),

    path('state/edit/<pk>', views.edit_state.as_view(), name="edit_state"),
    path('zsm/edit/<pk>', views.edit_zsm.as_view(), name="edit_zsm"),
    path('rsm/edit/<pk>', views.edit_rsm.as_view(), name="edit_rsm"),
    path('city/edit/<pk>', views.edit_city.as_view(), name="edit_city"),
    path('party_type/edit/<pk>', views.edit_party_type.as_view(), name="edit_party_type"),
    path('region/edit/<pk>', views.edit_region.as_view(), name="edit_region"),
    path('se/edit/<pk>', views.edit_se.as_view(), name="edit_se"),
    path('zone/edit/<pk>', views.edit_zone.as_view(), name="edit_zone"),
    path('division/edit/<pk>', views.edit_division.as_view(), name="edit_division"),
    path('asm/edit/<pk>', views.edit_asm.as_view(), name="edit_asm"),
    path('country/edit/<pk>', views.edit_country.as_view(), name="edit_country"),
    path('ledger/edit/<pk>', views.edit_ledger, name="edit_ledger"),
    #  ----------------------------------------------------------------------------------Ajax-Requests-----------

    path('ajax/load-states/', views.load_states, name='ajax_load_states'),
    path('ajax/load-cities/', views.load_cities, name='ajax_load_cities'),
    path('ajax_load_zones/', views.load_zones, name='ajax_load_zones'),
    path('load_zones/', views.zones, name='load_zones'),
    path('load_zsms/', views.zsms, name='load_zsms'),
    path('load_rsms/', views.rsms, name='load_rsms'),
    path('load_asms/', views.asms, name='load_asms'),
    path('ajax/load-zsms/', views.load_zsms, name='ajax_load_zsms'),
    path('ajax/load-rsms/', views.load_rsms, name='ajax_load_rsms'),
    path('ajax/load-asms/', views.load_asms, name='ajax_load_asms'),
    path('ajax/load-ses/', views.load_ses, name='ajax_load_ses'),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/cmmultiadd/', views.cmmultiadd, name='cmmultiadd'),

]