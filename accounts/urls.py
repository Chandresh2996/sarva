from django.urls import path
from . import views

app_name="account"

urlpatterns = [
    path('', views.Company_data, name="company_id"),
    path('', views.Company_data, name="profile"),
    path('changepass/', views.user_change_pass, name="changepass"),
]