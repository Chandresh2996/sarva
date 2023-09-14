from django.urls import path
from . import views

app_name="production"

urlpatterns = [
    path('', views.production, name="production"),

    path('jobwork', views.jobwork, name="jobwork"),
    path('jobwork/show/<pk>', views.showjobwork, name="showjobwork"),
    path('jobwork/pdf/<pk>', views.jobworkpdf, name="jobwork_pdf"),
    path('jobwork/cancel/<pk>', views.canceljobwork, name="canceljobwork"),
    path('list/jobwork', views.listjobwork.as_view(), name="listjobwork"),

    path('mt/', views.mt.as_view(), name="mt"),
    path('mt/add', views.addmt, name="addmt"),
    path('consumption/', views.consumption.as_view(), name="consumption"),
    path('consumption/add', views.addconsumption, name="addconsumption"),
    path('consumption/show/<pk>', views.showconsumption, name="showconsumption"),

    path('rmindent', views.rmindent.as_view(), name="rm-indent"),
    path('rmindent/create', views.add_rmindent, name="add_rmindent"),
    path('extraindent', views.extraindent, name="extraindent"),
    path('showrm/<pk>', views.showrm, name="showrm"),
    path('printrm/<pk>', views.printrm, name="printrm"),

    path('consumables', views.ConsumablesView.as_view(), name="consumables"),
    path('consumables/add/', views.add_consumables, name="add_consumables"),
    path('consumables/show/<pk>', views.show_consumable, name="show_consumable"),
    path('htmx/consumable-item/', views.consumable_item, name='consumable-item'),

    path('load/jobqty', views.loadjobqty, name="ajax_load_jobqty"),
    path('load/consumption', views.loadconsumption, name="ajax_load_consumption"),
    path('load/rm-indent', views.loadrmindent, name="ajax_load_rmindent"),
    path('load/rm-indent-withoutjob', views.loadrmindentwithoutjob, name="ajax_load_rmindent_withoutjob"),
    path('load/extra-rm', views.loadextrarm, name="ajax_load_extrarm"),
    path('loadjob', views.loadjob, name="loadjob"),
    path('loadrm', views.loadrm, name="loadrm"),
    path('load/rmgodown', views.loadrmgodown, name="ajax_load_rmgodown"),
    path('load_godown/', views.loadgodowns, name='load_godown'),
    path('load_item/', views.loaditem, name='load_item'),
    path('load_qty/', views.loadqty, name='load_qty'),
    path('htmx/consumption-item/', views.consumption_item, name='consumption-item'),

]