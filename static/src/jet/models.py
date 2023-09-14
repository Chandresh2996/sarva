from django.db import models
from django.utils import timezone

try:
    from django.utils.encoding import python_2_unicode_compatible
except ImportError:
    from six import python_2_unicode_compatible

@python_2_unicode_compatible
class Bookmark(models.Model):
    url = models.URLField(verbose_name=('URL'))
    title = models.CharField(verbose_name=('title'), max_length=255)
    user = models.PositiveIntegerField(verbose_name=('user'))
    date_add = models.DateTimeField(verbose_name=('date created'), default=timezone.now)

    class Meta:
        verbose_name =('bookmark')
        verbose_name_plural =('bookmarks')
        ordering = ('date_add',)

    def __str__(self):
        return self.title


@python_2_unicode_compatible
class PinnedApplication(models.Model):
    app_label = models.CharField(verbose_name=('application name'), max_length=255)
    user = models.PositiveIntegerField(verbose_name=('user'))
    date_add = models.DateTimeField(verbose_name=('date created'), default=timezone.now)

    class Meta:
        verbose_name =('pinned application')
        verbose_name_plural =('pinned applications')
        ordering = ('date_add',)

    def __str__(self):
        return self.app_label

