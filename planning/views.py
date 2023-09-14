from datetime import datetime
from decimal import Decimal
from django.shortcuts import render, redirect
from company.models import Company
from django.views.generic import ListView
from django.db.models import Q
from django.utils.decorators import method_decorator
from core.decorators import auth_users, allowed_users, is_company
from inventory.models import  Product_master
from .models import Bom, BomItems, JobOrder
from django.contrib import messages

@method_decorator(allowed_users(allowed_roles=['Admin', 'BOM View', 'BOM Create', 'BOM Update', 'BOM Delete']), name='dispatch')
class BomView(ListView):
    model = Bom
    template_name = 'planning/bom.html'
    context_object_name = 'boms'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Bom.objects.all().order_by("name")
        if query is not None:
            qs=qs.filter( Q(product__product_code__icontains=query) | Q(name__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'BOM Create', 'BOM Update', 'BOM Delete'])
def add_bom(request):

    if request.method == 'POST':

        pm      = Product_master.objects.get(product_code=request.POST.get("product"))
        boms    = request.POST.get("bom_name")
        description    = request.POST.get("description")
        bom     = Bom.objects.update_or_create(product=pm, name=boms, description=description)
        qtys    = request.POST.getlist('bom_item_qty')
        items   = request.POST.getlist("bom_item")

        for j,k in enumerate(items) :
            item = Product_master.objects.get(product_code=k)
            BomItems.objects.update_or_create( bom=bom[0], item=item, qty=qtys[j])
        return redirect("planning:bom")

    products    = Product_master.objects.all()
    # boms        = Bom.objects.all()
    context     = {'products':products}
    return render(request,'planning/add_bom.html',context)

@allowed_users(allowed_roles=['Admin', 'BOM Update', 'BOM Delete'])
def edit_bom(request, pk):
    products    = Product_master.objects.all()
    boms        = Bom.objects.get(pk=pk)
    
    if request.method == 'POST':

        name        = request.POST.get("bom_name")

        items               = BomItems.objects.filter(bom=boms)
        description         = request.POST.get("description")
        boms.description    = description
        boms.name           = name
        boms.save()

        qtys    = request.POST.getlist('bom_item_qty')
        items   = request.POST.getlist("bom_item")

        BomItems.objects.filter(bom=boms).delete()
        for j,k in enumerate(items) :
            item = Product_master.objects.get(product_code=k)
            BomItems.objects.update_or_create(bom=boms, item=item, qty=qtys[j])
        return redirect("planning:bom")
    items=BomItems.objects.filter(bom=boms)
    context             = {'products':products,'boms':boms,'items':items}
    return render(request,'planning/edit_bom.html',context)

@allowed_users(allowed_roles=['Admin', 'BOM View', 'BOM Create', 'BOM Update', 'BOM Delete'])
def show_bom(request, pk):
    products    = Product_master.objects.all()
    boms        = Bom.objects.get(pk=pk)

    context     = {'products':products,'boms':boms}
    return render(request,'planning/show_bom.html',context)

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'JobOrder View', 'JobOrder Create', 'JobOrder Update', 'JobOrder Delete']), name='dispatch')
class JobOrderView(ListView):
    model = JobOrder
    template_name = 'planning/jobcard.html'
    context_object_name = 'jobs'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs  = JobOrder.objects.filter(company=self.request.META['com']).order_by("-no")
        if query is not None:
            qs=qs.filter( Q(product__product_code__icontains=query) | Q(no__icontains=query) | Q(name__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'JobOrder Update', 'JobOrder Delete'])
def edit_joborder(request, pk):

    jobcards    = JobOrder.objects.get(pk=pk)

    if request.method == 'POST':
        name        = request.POST.get("name")
        category    = request.POST.get("category")
        details     = request.POST.get("details")
        product     = request.POST.get("product")
        bom         = request.POST.get("bom")
        qty         = Decimal(request.POST.get("qty"))
        due_date    = request.POST.get("due_date")
        remarks     = request.POST.get("remarks")

        product     = Product_master.objects.get(product_code=product)
        bom         = Bom.objects.get(product=product, name=bom)

        jobcards.name = name
        jobcards.product = product
        jobcards.issuedby = request.user.username
        jobcards.bom = bom
        jobcards.qty = qty
        jobcards.remain_qty = qty
        jobcards.category = category
        jobcards.details = details
        jobcards.date = datetime.today()
        jobcards.due_date = due_date
        jobcards.remarks = remarks
        jobcards.save()
        return redirect('planning:joborder')
        
    products    = Product_master.objects.all()
    context = {'jo':jobcards,'products':products}

    return render(request,'planning/edit_joborder.html',context)

@allowed_users(allowed_roles=['Admin', 'JobOrder Create', 'JobOrder Update', 'JobOrder Delete'])
def add_joborder(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)
    series      = com.joborder_series
    so          = JobOrder.objects.filter(company=com, no__contains=series).order_by('no').last()
    if so:
        sonum   = int(so.no[len(series):]) + 1
        job_no  = series + (str(sonum)).zfill(5)
    else:
        job_no  = series + '00001'

    if request.method == 'POST':
        name        = request.POST.get("name")
        category    = request.POST.get("category")
        details     = request.POST.get("details")
        product     = request.POST.get("product")
        bom         = request.POST.get("bom")
        qty         = Decimal(request.POST.get("qty"))
        due_date    = request.POST.get("due_date")
        remarks     = request.POST.get("remarks")

        product     = Product_master.objects.get(product_code=product)
        bom         = Bom.objects.get(product=product, name=bom)

        JobOrder.objects.create(company = com, no=job_no,name=name, product=product,issuedby=request.user,
                                bom=bom, qty=qty, remain_qty= qty, category=category,status = 1,
                                details=details,date=datetime.today() ,due_date=due_date, remarks=remarks)
        return redirect("planning:joborder")

    products    = Product_master.objects.all()
    jobcards = JobOrder.objects.all()
    context = {'jobcards':jobcards,'products':products,'job':job_no}

    return render(request,'planning/add_jobcard.html',context)

@allowed_users(allowed_roles=['Admin', 'JobOrder View', 'JobOrder Create', 'JobOrder Update', 'JobOrder Delete'])
def show_joborder(request, pk):

    jo = JobOrder.objects.get(pk=pk)

    return render(request,'planning/show_joborder.html',{'jo' : jo})


def loadbom(request):
    boms = Bom.objects.filter(product__product_code = request.GET.get('product'))
    return render(request,'planning/partials/load-bom.html', {'boms':boms})


def load_productbom(request):
    boms = Bom.objects.filter(product__product_code = request.GET.get('product'))
    return render(request,'planning/partials/load-product-bom.html', {'boms':boms})


def load_rmindent(request):
    boms = Product_master.objects.get(product_code = request.GET.get('product'))
    return render(request,'planning/partials/load-rmindent.html', {'boms':boms})
