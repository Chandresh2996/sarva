import os
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

import mimetypes

mimetypes.add_type("application/javascript", ".js", True)

DEBUG_TOOLBAR_CONFIG = {
    "INTERCEPT_REDIRECTS": False,
}

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-(g3@e6#v+y1)+x)9v&7cg$30*^57g@-nb@x=#7u$^6de%1r(fy'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
TEMPLATE_DEBUG = False
ALLOWED_HOSTS = ['54.81.57.172','ssipl.dhsclouding.com','127.0.0.1','192.168.0.174', '*','now.sh','0.0.0.0','localhost']

IMPORT_EXPORT_USE_TRANSACTIONS = True
IMPORT_EXPORT_SKIP_ADMIN_LOG = True
PROCESS_WITHOUT_SHOW_CONFIRM_FORM = True
# Application definition

INSTALLED_APPS = [
    # 'jet.dashboard',
    # 'jet',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.humanize',

    #Django Packages
    'import_export',
    'wkhtmltopdf',
    'qr_code',
    'auditlog',
    # 'ajax_datatable',
    # 'debug_toolbar',

    #My Apps
    'chatroom.apps.ChatroomConfig',
    'company.apps.CompanyConfig',
    'accounts.apps.AccountsConfig',
    'dash.apps.DashConfig',
    'inventory.apps.InventoryConfig',
    'ledgers.apps.LedgersConfig',
    'planning.apps.PlanningConfig',
    'production.apps.ProductionConfig',
    'purchase.apps.PurchaseConfig',
    'reports.apps.ReportsConfig',
    'sales.apps.SalesConfig',
    'warehouse.apps.WarehouseConfig',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    "whitenoise.middleware.WhiteNoiseMiddleware",
    # "debug_toolbar.middleware.DebugToolbarMiddleware",
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'core.middleware.OneSessionPerUserMiddleware',
    'core.middleware.LoginRequiredMiddleware',

    # 'django_session_timeout.middleware.SessionTimeoutMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'auditlog.middleware.AuditlogMiddleware',
]

ROOT_URLCONF = 'core.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': ['templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
#   my context processors
                'accounts.context_processors.company_id',
                'accounts.context_processors.date',
                'accounts.context_processors.enddate',
            ],
        },
    },
]

TEMPLATE_CONTEXT_PROCESSORS =  'django.core.context_processors.request',

WSGI_APPLICATION = 'core.wsgi.application'

# INTERNAL_IPS = [
#     "127.0.0.1",
# ]

# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases
if False:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': BASE_DIR / 'db.sqlite3',
        }
    }
else:
    #AWS Testing database
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': 'databaseNeti',
            'USER': 'Netisuperuser',
            'PASSWORD': 'Neti1234',
            'HOST': 'database-1.cwkh99l3smwi.us-east-1.rds.amazonaws.com',
            'PORT': '5432',
        }
    }
    #Main Database.
    # DATABASES = {
    #     'default': {
    #         'ENGINE': 'django.db.backends.postgresql_psycopg2',
    #         'NAME': 'netidb',
    #         'USER': 'netitest',
    #         'PASSWORD': 'netidb@123',
    #         'HOST': 'localhost',
    #         'PORT': '5432',
    #     }
    # }

# Password validation
# https://docs.djangoproject.com/en/4.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.0/howto/static-files/

STATIC_URL = 'static/'
# STATICFILES_DIRS = [BASE_DIR/'static',]
# STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_DIRS = os.path.join(BASE_DIR, 'static'),
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles_build', 'static')

# STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"
# Default primary key field type
# https://docs.djangoproject.com/en/4.0/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
DATA_UPLOAD_MAX_NUMBER_FIELDS = None

LOGIN_REDIRECT_URL = '/'
LOGOUT_REDIRECT_URL = 'login'

AUTH_EXEMPT_ROUTES = ('register', 'login', 'forgot-password')
AUTH_LOGIN_ROUTE = 'login'

SESSION_EXPIRE_SECONDS = 900
SESSION_EXPIRE_AFTER_LAST_ACTIVITY = True
SESSION_TIMEOUT_REDIRECT = 'login'
SESSION_EXPIRE_AT_BROWSER_CLOSE=True
#-----------------------------------------------------------------------Plugins settings
#This is for AWS Deployment
WKHTMLTOPDF_CMD = '/usr/bin/wkhtmltopdf'


#This is for local, use this when doing anything at local
# WKHTMLTOPDF_CMD = 'C:/wkhtmltopdf/bin/wkhtmltopdf'


JET_CHANGE_FORM_SIBLING_LINKS = False
X_FRAME_OPTIONS = 'SAMEORIGIN'
JET_SIDE_MENU_COMPACT = True

JET_THEMES = [
    {
        'theme': 'default', # theme folder name
        'color': '#47bac1', # color of the theme's button in user menu
        'title': 'Default' # theme title
    },
    {
        'theme': 'green',
        'color': '#44b78b',
        'title': 'Green'
    },
    {
        'theme': 'light-green',
        'color': '#2faa60',
        'title': 'Light Green'
    },
    {
        'theme': 'light-violet',
        'color': '#a464c4',
        'title': 'Light Violet'
    },
    {
        'theme': 'light-blue',
        'color': '#5EADDE',
        'title': 'Light Blue'
    },
    {
        'theme': 'light-gray',
        'color': '#222',
        'title': 'Light Gray'
    }
]

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = "smtp.office365.com"
EMAIL_PORT = 587
EMAIL_HOST_USER = "neti@stonesapphire.com"
SERVER_EMAIL = EMAIL_HOST_USER
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
EMAIL_HOST_PASSWORD = "password@2022"
EMAIL_USE_TLS = True
EMAIL_TIMEOUT = 60
