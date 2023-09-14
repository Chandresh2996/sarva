from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.contrib.auth import views as auth_views
from django.conf.urls.static import static
from django.views.generic.base import TemplateView

from accounts.views import Register

admin.site.site_header = "Neti Admin"
admin.site.site_title = "Neti Admin Portal"
admin.site.index_title = "Welcome to Neti Admin Portal"


urlpatterns = [

    # path('__debug__/', include('debug_toolbar.urls')),
    # path('jet/', include('jet.urls', 'jet')),
    # path('jet/dashboard/', include('jet.dashboard.urls', 'jet-dashboard')),
    path('admin/', admin.site.urls),
    path('acc/', include("accounts.urls", namespace="accounts")),
    path('', include("dash.urls", namespace="dash")),
    path('cht/', include("chatroom.urls", namespace="chat")),
    path('cmp/', include("company.urls", namespace="company")),
    path('ivt/', include("inventory.urls", namespace="inventory")),
    path('led/', include("ledgers.urls", namespace="ledgers")),
    path('pln/', include("planning.urls", namespace="planning")),
    path('prd/', include("production.urls", namespace="production")),
    path('prc/', include("purchase.urls", namespace="purchase")),
    path('sls/', include("sales.urls", namespace="sales")),
    path('wrh/', include("warehouse.urls", namespace="warehouse")),
    path('rpt/', include("reports.urls", namespace="reports")),
    path('accounts/', include('django.contrib.auth.urls')),

    path(
    'password_reset/done/',
    auth_views.PasswordResetDoneView.as_view(),
    name='admin_password_reset',
    ),
    path(
        'admin/password_reset/done/',
        auth_views.PasswordResetDoneView.as_view(),
        name='password_reset_done',
    ),
    path(
        'reset/<uidb64>/<token>/',
        auth_views.PasswordResetConfirmView.as_view(),
        name='password_reset_confirm',
    ),
    path(
        'reset/done/',
        auth_views.PasswordResetCompleteView.as_view(),
        name='password_reset_complete',
    ),
    path(
        'register/success/',
        TemplateView.as_view(template_name="registration/success.html"),
        name ='register-success',
    ),
    path('login/', auth_views.LoginView.as_view(redirect_authenticated_user=True), name='login'),
    path('register/', Register.as_view(), name='register'),
    path('', include('django.contrib.auth.urls')),

] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
