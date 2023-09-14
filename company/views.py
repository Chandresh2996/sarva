import re
from django.shortcuts import render, redirect
from django.contrib.auth.models import Group, User
from django.utils.decorators import method_decorator
from core.decorators import auth_users, allowed_users, is_company
from django.views.generic import ListView
from django.db.models import Q

from warehouse.models import Stock_summary
from .models import Company
from django.contrib import messages

def home(request):

    if request.method == 'POST':

        print(request.POST)

    groups = Group.objects.all()

    return render(request,'company/company.html',{'groups':groups})

def company(request):

    if request.method == 'POST':

        print(request.POST)

    groups = Group.objects.all()

    return render(request,'company/view_company.html',{'groups':groups})

@method_decorator(allowed_users(allowed_roles=['Admin']),name='dispatch')
class company(ListView):
    model = Company
    template_name = 'company/view_company.html'
    context_object_name = 'company'
    paginate_by = 10

@allowed_users(allowed_roles=['Admin'])
def edit_company(request, pk):
    com = Company.objects.get(id=pk)
    if request.method == 'POST':
        com.name = request.POST.get("name")
        com.tally_name = request.POST.get("tally_name")
        com.ledger_name = request.POST.get("ledger_name")
        com.ipaddress = request.POST.get("ipaddress")
        com.dis_addtype = request.POST.get("dis_addtype")
        com.dis_name = request.POST.get("dis_name")
        com.dis_add = request.POST.get("dis_add")
        com.dis_add2 = request.POST.get("dis_add2")
        com.dis_add3 = request.POST.get("dis_add3")
        com.dis_country = request.POST.get("dis_country")
        com.dis_state = request.POST.get("dis_state")
        com.dis_city = request.POST.get("dis_city")
        com.dis_pincode = request.POST.get("dis_pincode")
        com.dis_gstin = request.POST.get("dis_gstin")
        com.pan_no = request.POST.get("pan_no")
        com.so_series = request.POST.get("so_series")
        com.dn_series = request.POST.get("dn_series")
        com.inv_series = request.POST.get("inv_series")
        com.pinv_series = request.POST.get("pinv_series")
        com.debitnote_series = request.POST.get("debitnote_series")
        com.sales_qdn_series = request.POST.get("sales_qdn_series")
        com.rso_series = request.POST.get("rso_series")
        com.po_series = request.POST.get("po_series")
        com.ict_series = request.POST.get("ict_series")
        com.grn_series = request.POST.get("grn_series")
        com.pi_series = request.POST.get("pi_series")
        com.creditnote_series = request.POST.get("creditnote_series")
        com.purchase_qdn_series = request.POST.get("purchase_qdn_series")
        com.purchase_return_series = request.POST.get("purchase_return_series")
        com.joborder_series = request.POST.get("joborder_series")
        com.job_series = request.POST.get("job_series")
        com.rm_series = request.POST.get("rm_series")
        com.cms_series = request.POST.get("cms_series")
        com.pds_series = request.POST.get("pds_series")
        com.save()
        messages.success(request, "Comapny Details Updated Successfully")
        return redirect('company:company')
    return render(request,'company/edit_company.html',{'com': com})

@allowed_users(allowed_roles=['Admin'])
def show_company(request, pk):
    com = Company.objects.get(id=pk)
    # data = Stock_summary.objects.filter(closing_balance=0).delete()

    return render(request,'company/show_company.html',{'com': com})

@allowed_users(allowed_roles=['Admin'])
def add_perms(request, pk):

    user    = User.objects.get(id=pk)
    if request.method == 'POST':
        usergroups = request.POST.getlist('selectedlist')
        user.groups.clear()
        for i in usergroups:
            user.groups.add(i)
        messages.success(request, "Permissions are Updated Successfully")
        return redirect('company:perms')
    groups  = Group.objects.all().order_by('name')
    return render(request,'company/add_perms.html',{'groups':groups, 'user':user})


@method_decorator(allowed_users(allowed_roles=['Admin']),name='dispatch')
class UserPermsView(ListView):
    model = User
    template_name = 'company/perms.html'
    context_object_name = 'users'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = User.objects.exclude(username__in = ['administrator', 'superuser']).order_by("first_name")
        if query is not None:
            qs=qs.filter(Q(username__icontains=query) | Q(first_name__icontains=query))
        return qs