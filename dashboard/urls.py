from django.urls import path
from . import views

app_name="dashboard"

urlpatterns = [
    path('', views.home, name="home"),
    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

    path('htmx/clear/', views.clear, name='clear'),
]