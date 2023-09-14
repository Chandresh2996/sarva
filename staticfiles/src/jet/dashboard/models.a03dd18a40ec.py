from importlib import import_module
import json
from django.db import models
from jet.utils import LazyDateTimeEncoder

try:
    from django.utils.encoding import python_2_unicode_compatible
except ImportError:
    from six import python_2_unicode_compatible

@python_2_unicode_compatible
class UserDashboardModule(models.Model):
    title = models.CharField(verbose_name=('Title'), max_length=255)
    module = models.CharField(verbose_name=('module'), max_length=255)
    app_label = models.CharField(verbose_name=('application name'), max_length=255, null=True, blank=True)
    user = models.PositiveIntegerField(verbose_name=('user'))
    column = models.PositiveIntegerField(verbose_name=('column'))
    order = models.IntegerField(verbose_name=('order'))
    settings = models.TextField(verbose_name=('settings'), default='', blank=True)
    children = models.TextField(verbose_name=('children'), default='', blank=True)
    collapsed = models.BooleanField(verbose_name=('collapsed'), default=False)

    class Meta:
        verbose_name =('user dashboard module')
        verbose_name_plural =('user dashboard modules')
        ordering = ('column', 'order')

    def __str__(self):
        return self.module

    def load_module(self):
        try:
            package, module_name = self.module.rsplit('.', 1)
            package = import_module(package)
            module = getattr(package, module_name)

            return module
        except AttributeError:
            return None
        except ImportError:
            return None

    def pop_settings(self, pop_settings):
        settings = json.loads(self.settings)

        for setting in pop_settings:
            if setting in settings:
                settings.pop(setting)

        self.settings = json.dumps(settings, cls=LazyDateTimeEncoder)
        self.save()

    def update_settings(self, update_settings):
        settings = json.loads(self.settings)

        settings.update(update_settings)

        self.settings = json.dumps(settings, cls=LazyDateTimeEncoder)
        self.save()


