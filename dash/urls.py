from django.urls import path
from . import views

app_name="dash"

urlpatterns = [
    path('', views.home, name="home"),
    path('sales/dsr', views.dsrReport, name="dsrReport"),
    path('sales/scorecard', views.scorecard, name="scorecard"),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/clear/', views.clear, name='clear'),
]