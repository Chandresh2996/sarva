from django.urls import path
from . import views

app_name="company"

urlpatterns = [
    path('', views.home, name="home"),
    path('company', views.company.as_view(), name="company"),
    path('perms', views.UserPermsView.as_view(), name="perms"),
    path('perms/add/<pk>', views.add_perms, name="add_perms"),
    path('company/edit/<pk>', views.edit_company, name="edit_company"),
    path('company/show/<pk>', views.show_company, name="show_company"),
]