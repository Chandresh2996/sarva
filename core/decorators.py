
from django.http import HttpResponse
from django.shortcuts import redirect, render

from company.models import Company


def auth_users(view_func):
    def wrapper(request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect('dash:home')
        else:
            return view_func(request, *args, **kwargs)
    return wrapper


def allowed_users(allowed_roles=[]):
    def decorators(view_func):
        def wrapper(request, *args, **kwargs):
            group = None
            if request.user.groups.exists():
                groups = request.user.groups.all()
                for group in groups:
                    if group.name in allowed_roles:
                        return view_func(request, *args, **kwargs)
            return HttpResponse('You are not authorized to view this page')
        return wrapper
    return decorators


def is_company(view_func):
        def wrapper(request, *args, **kwargs):
            try:
                skey = (request.session.get('skey').get('company').get('id'))
            except:
                return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
            request.META['com'] = Company.objects.get(pk=skey)

            return view_func(request, *args, **kwargs)
        return wrapper
