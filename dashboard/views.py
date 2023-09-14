from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy

from company.models import Company
# Create your views here.


@login_required(login_url=reverse_lazy('login'))
def home(request):
    comp = Company.objects.all()

    return render (request, 'dashboard/index.html',{'companies':comp})

@login_required(login_url=reverse_lazy('login'))
def myhome(request):
    comp = Company.objects.all()

    return render (request, 'dashboard/myhome.html',{'companies':comp})

    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

def clear(request):
    return HttpResponse("")