import datetime
from decimal import Decimal
from django.http import HttpResponse
from django.shortcuts import render, redirect
from company.models import Company
from inventory.models import Godown, Product_master
from planning.models import Bom, BomItems, JobOrder
from production.models import ConsItems, ConsumableIndent, Consumption, ConsumptionItems, JobCard, RMIndent, RMIndentItems, RMItemGodown
from warehouse.models import Stock_summary
from django.db.models import Sum
from wkhtmltopdf.views import  PDFTemplateResponse
from django.views.generic import ListView
from django.contrib.auth.models import User
from django.http import JsonResponse
from core.decorators import auth_users, allowed_users, is_company
from django.utils.decorators import method_decorator
from django.contrib import messages
from django.db.models import Q

def production(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    context                 = {}
    context['bom']          = Bom.objects.count()
    context['jo']           = JobOrder.objects.filter(company=com).count()
    context['jc']           = JobCard.objects.filter(company=com).count()
    context['indent']       = RMIndent.objects.filter(company=com, status=2).count()
    context['con']          = ConsumableIndent.objects.filter(company=com).count()
    context['consumption']  = Consumption.objects.filter(company=com).count()

    return render(request, "production/production.html", context)

def check(list,jw):

    for dict in list:
        if dict.get('inner'):
            check(dict.get('inner'), jw)
        else:
            RMIndentItems.objects.create(rmindent=jw,bom_id=dict['bom'],item_id=dict['item'],qty=dict['qty'])

def jobwork(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    series      = com.job_series
    so          = JobCard.objects.filter(company=com, no__contains=series).order_by('no').last()
    if so:
        sonum   = int(so.no[len(series):]) + 1
        job_no  = series + (str(sonum)).zfill(5)
    else:
        job_no  = series + '00001'

    if request.method == 'POST':

        job         = JobOrder.objects.get(id=request.POST.get('jobcard'))
        items       = list(BomItems.objects.filter(bom=job.bom).values('bom__product__product_code','item','bom','bom__name','item__product_code','qty'))
        qty         = Decimal(request.POST.get('pqty'))
        duration    = request.POST.get('duration')

        shortfall = False
        jw          = JobCard.objects.create(company=job.company,no=job_no,joborder=job,product=job.product,qty=qty,rqty=qty,start=duration)
        for i in items:
            i['qty'] = round(i['qty'] * qty,4)
            st=Stock_summary.objects.filter(godown__godown_type = True,product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            if st < i['qty']:
                shortfall = True
                i['sqty'] = round(i['qty'] - st,2)

                # bom=Bom.objects.filter(product = i['item']).last()
                # if bom:
                #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #     for j in newitems:

                #         j['qty'] = round(j['qty'] * i['sqty'], 4)
                #         st=Stock_summary.objects.filter(godown__godown_type = True,product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #         if st < j['qty']:
                #             shortfall = True
                #             j['sqty'] = round(j['qty'] - st,2)

                #             bom=Bom.objects.filter(product = j['item']).last()
                #             if bom:
                #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #                 for k in sitems:
                #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
                #                     st=Stock_summary.objects.filter(godown__godown_type = True,product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #                     if st < k['qty']:
                #                         shortfall = True
                #                         k['sqty']   = round(k['qty'] - st,2)
                #                     else:
                #                         k['sqty'] = 0
                #                 j['inner'] = sitems
                #         else:
                #             j['sqty'] = 0
                #     i['inner'] = newitems
            else:
                i['sqty'] = 0

        rm = RMIndent.objects.create(no=job_no,jobcard=jw, company=com, status='1')
        check(items,rm)
        job.remain_qty -= qty
        job.status = 3 if float(job.remain_qty) == 0.0 else 2
        job.save()
        if float(job.remain_qty) == 0.0:
            jobc = JobCard.objects.get(no=jw)
            jobc.status = 4
            jobc.save()
        messages.success(request, "Job Work Added Successfully")

        return redirect("production:listjobwork")

    jobcards = JobOrder.objects.filter(company=com,status__in = [1,2]).order_by('no')
    context = {'jobcards':jobcards,'job':job_no}

    return render(request, "production/jobwork.html", context)
@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Job Card View', 'Job Card Create', 'Job Card Update', 'Job Card Delete']), name='dispatch')
class listjobwork(ListView):
    model = JobCard
    template_name = 'production/listjobwork.html'
    context_object_name = 'jobs'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = JobCard.objects.filter(company=self.request.META['com']).order_by('-no')
        if query is not None:
            qs=qs.filter( Q(product__product_code__icontains=query) | Q(no__icontains=query) | Q(joborder__no__icontains=query) )
        return qs

def showjobwork(request, pk):

    job = JobCard.objects.get(id=pk)
    items = RMIndentItems.objects.filter(rmindent = job.rmindent.last())
    context = {'job':job, 'items':items}

    return render(request, "production/show_jobwork.html", context)

def jobworkpdf(request, pk):

    job = JobCard.objects.get(id=pk)
    item = RMIndentItems.objects.filter(rmindent=job.rmindent.last())
    context = {'job':job, 'items':item}

    return render(request, "production/jc_pdf.html", context)

def canceljobwork(request, pk):

    job = JobCard.objects.get(id=pk)
    job.status  = 2
    job.status()

    return redirect('production:listjobwork')

def loadjob(request):

    job = JobOrder.objects.get(id=request.GET.get('job'))
    context = {'job':job}

    return render(request, "production/partials/loadjob.html", context)

def loadrm(request):

    job = RMIndent.objects.get(id=request.GET.get('job'))
    context = {'job':job}

    return render(request, "production/partials/loadrmindent.html", context)
@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'RM Indent View', 'RM Indent Create', 'RM Indent Update', 'RM Indent Delete']), name='dispatch')
class rmindent(ListView):
    model               = RMIndent
    template_name       = 'production/rmindent.html'
    context_object_name = 'jobs'
    paginate_by = 10
    ordering = ['-no']

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = RMIndent.objects.filter(company=self.request.META['com'],status=2).order_by('-no')
        if query is not None:
            qs=qs.filter( Q(no__icontains=query) )
        return qs

def add_rmindent(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    if request.method == 'POST':
        job = RMIndent.objects.get(id=request.POST.get('jobcard'))
        items = RMIndentItems.objects.filter(rmindent=job)
        # try:
        for i in items:
            bkey            = 'b'+str(i.item)
            batch           = request.POST.getlist(bkey)
            gkey            = 'g'+str(i.item)
            godowns         = request.POST.getlist(gkey)
            qkey            = 'q'+str(i.item)
            qtys            = request.POST.getlist(qkey)

            for x, g in enumerate(godowns):
                gd=Godown.objects.get(name=g)
                qty=Decimal(qtys[x])
                st=Stock_summary.objects.filter(product=i.item, godown=gd)
                for st1 in st:
                    if qty >= st1.closing_balance:
                        qty -= st1.closing_balance
                        st1.closing_balance=0
                        prate   =   st1.rate
                        st1.delete()
                    else:
                        st1.closing_balance -= qty
                        prate   =   st1.rate
                        st1.save()
                        break
                RMItemGodown.objects.create(rmitem=i, batch=batch[x], godown=g, qty=qtys[x], rate=prate)
        job.status = 2
        job.save()
        messages.success(request, "RM Indent Added Successfully")
        # except BaseException as exp:
        #     print(exp)
        #     for item in items:
        #         RMItemGodown.objects.filter(rmitem=item).delete()
        return redirect("production:rm-indent")

    job     = RMIndent.objects.filter(company=com,status=1)
    context = {'jobs':job}

    return render(request, "production/add_rmindent.html", context)

def showrm(request, pk):

    job     = RMIndent.objects.get(id=pk)
    items   = list(RMIndentItems.objects.filter(rmindent=job).values('id','item__product_code','bom__name','rmindent__jobcard__product','qty'))
    for i in items:
        i['godown'] = RMItemGodown.objects.filter(rmitem=i['id'])

    context = {'jobs':items, 'job':job}

    return render(request, "production/showrm.html", context)

def printrm(request, pk):

    job     = RMIndent.objects.get(id=pk)
    indents = RMIndentItems.objects.filter(rmindent=job)
    items   = RMItemGodown.objects.filter(rmitem__in = indents)

    template = 'production/rmpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': True}

    ls  = items.values("rmitem__rmindent__jobcard__no","rmitem__item__article_code","rmitem__item__product_name","rmitem__item__product_code","rmitem__item__outer_qty","godown").annotate(qty=Sum('qty'))

    context = {'ls': ls.order_by("godown"),'signdate': datetime.datetime.now().strftime("%d/%m/%Y, %H:%M:%S")}
    # return PDFTemplateResponse(request=request, context=context, template=template,footer_template=footer_template,header_template=header_template, filename='loadingsheet.pdf', cmd_options=cmd_options)
    return render(request, "production/rmpdf.html", context)

def loadrmindent(request):

    job     = JobOrder.objects.get(id=request.GET.get('job'))
    items   = list(BomItems.objects.filter(bom=job.bom).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty'))

    qty     = Decimal(request.GET.get('qty'))
    shortfall = False
    # secondsf = False
    # firstsf = False
    for i in items:
        i['qty'] = round(i['qty'] * qty,4)
        st=Stock_summary.objects.filter(godown__godown_type = True,product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
        if st < i['qty']:
            i['sqty'] = round(i['qty'] - st,4)
            shortfall = True
            # bom=Bom.objects.filter(product = i['item']).last()
            # if bom:
            #     shortfall = False
            #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty')))
            #     for j in newitems:
            #         j['qty'] = round(j['qty'] * i['sqty'], 4)
            #         st=Stock_summary.objects.filter(godown__godown_type = True,product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            #         if st < j['qty']:
            #             shortfall = True
            #             j['sqty'] = round(j['qty'] - st,4)
            #             bom=Bom.objects.filter(product = j['item']).last()
            #             if bom:
            #                 shortfall = False
            #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty')))
            #                 for k in sitems:
            #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
            #                     st=Stock_summary.objects.filter(godown__godown_type = True,product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            #                     if st < k['qty']:
            #                         shortfall = True
            #                         k['sqty']   = round(k['qty'] - st,2)
            #                     else:
            #                         k['sqty'] = 0
            #                 j['inner'] = sitems
            #             else:
            #                 secondsf = shortfall
            #         else:
            #             j['sqty'] = 0
            #     i['inner'] = newitems
            # else:
            #     firstsf = shortfall
        else:
            i['sqty'] = 0
    context = {'items':items, 'shortfall':(shortfall)}
    return render(request, "production/rm-indent.html", context)

def loadrmindentwithoutjob(request):
    actialbom = Bom.objects.filter(product__product_code=request.GET.get('product'), name=request.GET.get('bomname'))
    items   = list(BomItems.objects.filter(bom=actialbom[0]).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty'))
    qty     = Decimal(request.GET.get('qty'))
    shortfall = False
    secondsf = False
    firstsf = False
    for i in items:
            i['qty'] = round(i['qty'] * qty,4)
            st=Stock_summary.objects.filter(godown__godown_type = True,product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            if st < i['qty']:
                i['sqty'] = round(i['qty'] - st,2)
                shortfall = True
                # bom=Bom.objects.filter(product = i['item']).last()
                # if bom:
                #     shortfall = False
                #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty')))
                #     for j in newitems:
                #         j['qty'] = round(j['qty'] * i['sqty'], 4)
                #         st=Stock_summary.objects.filter(godown__godown_type = True,product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #         if st < j['qty']:
                #             shortfall = True
                #             j['sqty'] = round(j['qty'] - st,2)
                #             bom=Bom.objects.filter(product = j['item']).last()
                #             if bom:
                #                 shortfall = False
                #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','item__description','qty')))
                #                 for k in sitems:
                #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
                #                     st=Stock_summary.objects.filter(godown__godown_type = True,product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #                     if st < k['qty']:
                #                         shortfall = True
                #                         k['sqty']   = round(k['qty'] - st,2)
                #                     else:
                #                         k['sqty'] = 0
                #                 j['inner'] = sitems
                #             else:
                #                 secondsf = shortfall
                #         else:
                #             j['sqty'] = 0
                #     i['inner'] = newitems
                # else:
                #     firstsf = shortfall
            else:
                i['sqty'] = 0

    context = {'items':items, 'shortfall':(shortfall)}
    return render(request, "production/rm-indent.html", context)

def loadextrarm(request):

    job     = JobOrder.objects.get(id=request.GET.get('job'))
    items   = list(BomItems.objects.filter(bom=job.bom).values('bom__product__product_code','item','bom__name','item__product_code','qty'))
    qty     = Decimal(request.GET.get('qty'))
    shortfall = False
    for i in items:
            i['qty'] = round(i['qty'] * qty,4)
            st=Stock_summary.objects.filter(godown__godown_type = True,product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            if st < i['qty']:
                i['sqty'] = round(i['qty'] - st,2)
                shortfall = True
                # bom=Bom.objects.filter(product = i['item']).last()
                # if bom:
                #     shortfall = False
                #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','qty')))
                #     for j in newitems:
                #         j['qty'] = round(j['qty'] * i['sqty'], 4)
                #         st=Stock_summary.objects.filter(godown__godown_type = True,product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #         if st < j['qty']:
                #             shortfall = True
                #             j['sqty'] = round(j['qty'] - st,2)
                #             bom=Bom.objects.filter(product = j['item']).last()
                #             if bom:
                #                 shortfall = False
                #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','item','bom__name','item__product_code','qty')))
                #                 for k in sitems:
                #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
                #                     st=Stock_summary.objects.filter(godown__godown_type = True,product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #                     if st < k['qty']:
                #                         shortfall = True
                #                         k['sqty']   = round(k['qty'] - st,2)
                #                     else:
                #                         k['sqty'] = 0
                #                 j['inner'] = sitems
                #         else:
                #             j['sqty'] = 0
                #     i['inner'] = newitems
            else:
                i['sqty'] = 0

    context = {'items':items, 'shortfall':shortfall}
    return render(request, "production/rm-indent.html", context)

def extraindent(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)


    if request.method == 'POST':

        # print(request.POST)
        job         = JobOrder.objects.get(id=request.POST.get('jobcard'))
        items       = list(BomItems.objects.filter(bom=job.bom).values('bom__product__product_code','item','bom','bom__name','item__product_code','qty'))
        qty         = Decimal(request.POST.get('pqty'))
        duration    = request.POST.get('duration')

        shortfall = False
        jw          = JobCard.objects.create(company=job.company,no=job.job_no,jobcard=job,product=job.product,qty=qty,rqty=qty,start=duration)
        for i in items:
            i['qty'] = round(i['qty'] * qty,4)
            st=Stock_summary.objects.filter(godown__godown_type = True,product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            if st < i['qty']:
                shortfall = True
                i['sqty'] = round(i['qty'] - st,2)

                # bom=Bom.objects.filter(product = i['item']).last()
                # if bom:
                #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #     for j in newitems:

                #         j['qty'] = round(j['qty'] * i['sqty'], 4)
                #         st=Stock_summary.objects.filter(godown__godown_type = True,product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #         if st < j['qty']:
                #             shortfall = True
                #             j['sqty'] = round(j['qty'] - st,2)

                #             bom=Bom.objects.filter(product = j['item']).last()
                #             if bom:
                #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #                 for k in sitems:
                #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
                #                     st=Stock_summary.objects.filter(godown__godown_type = True,product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #                     if st < k['qty']:
                #                         shortfall = True
                #                         k['sqty']   = round(k['qty'] - st,2)
                #                     else:
                #                         k['sqty'] = 0
                #                 j['inner'] = sitems
                #         else:
                #             j['sqty'] = 0
                #     i['inner'] = newitems
            else:
                i['sqty'] = 0

        check(items,jw)
        job.remain_qty -= qty
        job.save()

        return redirect("production:jobwork")

    jobcards = JobCard.objects.filter(company = com)
    context = {'jobcards':jobcards,}

    return render(request, "production/jobwork.html", context)

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Material Transfer View', 'Material Transfer Create', 'Material Transfer Update', 'Material Transfer Delete']), name='dispatch')
class mt(ListView):
    model = RMIndent
    template_name = 'production/mt.html'
    context_object_name = 'jobs'
    paginate_by = 10
    ordering = ['-no']

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = RMIndent.objects.filter(company=self.request.META['com'],status = 3).order_by('-no')
        if query is not None:
            qs=qs.filter( Q(no__icontains=query) )
        return qs

def addmt(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)
    # Stock_summary.objects.create(company=com, product=i.rmitem.item,godown=gd, rate=i.rate, batch=i.batch, mrp=i.mrp, closing_balance=i.qty)

    if request.method == 'POST':

        rmindent    = RMIndent.objects.get(id=request.POST.get('jobcard'))
        items       = RMIndentItems.objects.filter(rmindent=rmindent)
        rms         = RMItemGodown.objects.filter(rmitem__in=items)
        gd = Godown.objects.get(name="PRODUCTION")
        for i in rms:
            Stock_summary.objects.create(company=com, product=i.rmitem.item,godown=gd, rate=i.rate, batch=i.batch, mrp=i.mrp, closing_balance=i.qty)
        rmindent.status = 3
        rmindent.save()
        messages.success(request, "Material transfers Successfully")
        return redirect("production:mt")

    jobcards = RMIndent.objects.filter(company=com,status=2)
    context = {'jobcards':jobcards,}

    return render(request, "production/addmt.html", context)
@method_decorator(is_company, name='dispatch')
@method_decorator(is_company, name='dispatch')
class ConsumablesView(ListView):
    model = ConsumableIndent
    template_name = 'production/consumables.html'
    context_object_name = 'consumables'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = ConsumableIndent.objects.filter(company=self.request.META['com']).order_by('-no')
        if query is not None:
            qs=qs.filter( Q(no__icontains=query) )
        return qs

def add_consumables(request):

    skey        = (request.session.get('skey').get('company').get('id'))
    com         = Company.objects.get(id=skey)
    so          = ConsumableIndent.objects.last()
    if so:
        sonum   = int(so.no[3:]) + 1
        job_no  = 'CSM' + str(sonum).zfill(5)
    else:
        job_no  = 'CSM' + '00001'

    if request.method == 'POST':
        issuer      = User.objects.get(username = request.user)
        drawn_by    = User.objects.get(username = request.POST.get('drawn_by'))
        item        = request.POST.getlist('pcode')
        qty         = request.POST.getlist('qty')
        cqty        = request.POST.getlist('cqty')
        godowns     = request.POST.getlist('godown')

        csm         = ConsumableIndent.objects.create(company=com,no = job_no, drawn_by = drawn_by, issuer = issuer, qty = 0)
        totalqty = 0
        for i,j in enumerate(item):

            product     = Product_master.objects.get(product_code = j)
            qty           = Decimal(qty[i])
            c           = Decimal(cqty[i])
            totalqty    += qty
            ConsItems.objects.create(indent = csm, item=product, qty=qty, con_qty=c)

            target=Godown.objects.get(name="PRODUCTION")
            godown=Godown.objects.get(name=godowns[i])

            st=Stock_summary.objects.filter(godown=godown, product=product).order_by('batch')
            for st1 in st:
                if qty >= st1.closing_balance:
                    qty -= st1.closing_balance
                    st2, new =Stock_summary.objects.get_or_create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    if new:
                        st2.closing_balance = st1.closing_balance
                    else:
                        st2.closing_balance += st1.closing_balance
                    st1.delete()
                    st2.save()
                    if qty == 0:
                        break
                else:
                    st1.closing_balance -= qty
                    st1.save()
                    st2, new=Stock_summary.objects.get_or_create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    if new:
                        st2.closing_balance = qty
                    else:
                        st2.closing_balance += qty
                    st2.save()
                    break

        csm.qty = totalqty
        csm.save()
        messages.success(request, "Consumption Entry Added Successfully")
        return redirect("production:consumables")

    products = Product_master.objects.all()
    context = {'products':products,'no':job_no, 'users': User.objects.exclude(username = 'Administrator')}

    return render(request, "production/add_consumables.html", context)


def show_consumable(request,pk):

    con = ConsumableIndent.objects.get(id=pk)
    items = ConsItems.objects.filter(indent = con)

    return render(request, "production/show_consumable.html", context = {'con':con, 'items':items})

def consumable_item(request):

    no = int(request.GET['no'])
    context = {'no': no+1}

    return render(request, 'production/partials/consumable-item.html', context)


def consumption_item(request):

    no = int(request.GET['no'])
    context = {'no': no+1}

    return render(request, 'production/partials/consumption-item.html', context)

def loadgodowns(request):
    item = Product_master.objects.get(product_code=request.GET.get('item'))
    gds = set()
    stock = Stock_summary.objects.filter(product=item, godown__godown_type=True).order_by('batch').values('godown__name')
    for i in stock:
        gds.add(i['godown__name'])
    return render(request, 'production/partials/godown.html', {'product':item.product_name,'stock': gds})

def loaditem(request):
    item = Product_master.objects.get(product_code=request.GET.get('item'))

    stock = Stock_summary.objects.filter(product__product_code=item, godown__name='PRODUCTION').aggregate(Sum('closing_balance'))
    return JsonResponse({'product':item.product_name,'stock': stock['closing_balance__sum']})

def loadqty(request):
    item = request.GET.get('item')
    gd = request.GET.get('gd')
    stock = Stock_summary.objects.filter(product__product_code=item, godown__name=gd).aggregate(Sum('closing_balance'))
    return HttpResponse(stock['closing_balance__sum'])
@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Production View', 'Production Create', 'Production Update', 'Production Delete']), name='dispatch')
class consumption(ListView):
    model = Consumption
    template_name = 'production/consumption.html'
    context_object_name = 'jobs'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Consumption.objects.filter(company=self.request.META['com']).order_by('-no')
        if query is not None:
            qs=qs.filter( Q(no__icontains=query) | Q(jobcard__no__icontains=query) )
        return qs

def showconsumption(request,pk):

    con = Consumption.objects.get(id=pk)
    items = ConsumptionItems.objects.filter(consumption = con)

    return render(request, "production/show_consumption.html", context = {'con':con, 'items':items})

def addconsumption(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    so          = Consumption.objects.all().order_by('no').last()
    if so:
        sonum   = int(so.no[3:]) + 1
        job_no  = 'PRD' + str(sonum).zfill(5)
    else:
        job_no  = 'PRD' + '00001'

    if request.method == 'POST':

        job         = JobCard.objects.get(id= request.POST.get('jobcard'))
        qty         = Decimal(request.POST.get('qty'))
        job.rqty   -= qty
        job.save()

        pd      = Consumption.objects.create(company=com,no=job_no,qty=qty,jobcard=job)
        if request.POST.get('pcode'):
            pcodes  = request.POST.getlist('pcode')
            rmqtys  = request.POST.getlist('rmqty')

            for i,j in enumerate(pcodes):
                item = Product_master.objects.get(product_code = j)
                st   = Stock_summary.objects.filter(company=com,product=item,godown__name="PRODUCTION").order_by('batch')

                cqty  = Decimal(rmqtys[i])
                for st1 in st:
                    if cqty >= st1.closing_balance:
                        cqty -= st1.closing_balance
                        st1.delete()
                    else:
                        st1.closing_balance -= cqty
                        st1.save()
                        break

            ConsumptionItems.objects.create(consumption=pd,rate=st[0].rate,mrp=st[0].mrp,batch=st[0].batch, item=item, qty = cqty)

        items   = list(BomItems.objects.filter(bom=job.joborder.bom).values('bom__product__product_code','item','bom','bom__name','item__product_code','qty'))

        for i in items:
            i['qty'] = round(i['qty'] * qty,4)
            t=Stock_summary.objects.filter(company=com,godown__name = 'PRODUCTION',product=i['item'])
            st=t.aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            if st < i['qty']:
                i['sqty'] = round(i['qty'] - st,4)
                # bom=Bom.objects.filter(product = i['item']).last()
                # if bom:
                #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #     for j in newitems:
                #         j['qty'] = round(j['qty'] * i['sqty'], 4)
                #         t=Stock_summary.objects.filter(company=com,godown__name = 'PRODUCTION',product=j['item'])
                #         st=t.aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #         if st < j['qty']:
                #             j['sqty'] = round(j['qty'] - st,4)
                #             bom=Bom.objects.filter(product = j['item']).last()
                #             if bom:
                #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','qty')))
                #                 for k in sitems:
                #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
                #                     t=Stock_summary.objects.filter(company=com,godown__name = 'PRODUCTION',product=k['item'])
                #                     st=t.aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
                #                     if st < k['qty']:
                #                         k['sqty']   = round(k['qty'] - st,4)
                #                     else:
                #                         ConsumptionItems.objects.create(consumption=pd, rate=t[0].rate, mrp=t[0].mrp, batch=t[0].batch, item=Product_master.objects.get(id=k['item']), qty = k['qty'])
                #                         for st1 in t:
                #                             if k['qty'] >= st1.closing_balance:
                #                                 k['qty'] -= st1.closing_balance
                #                                 st1.delete()
                #                             else:
                #                                 st1.closing_balance -= qty
                #                                 st1.save()
                #                                 break
                #                 j['inner'] = sitems
                #         else:
                #             ConsumptionItems.objects.create(consumption=pd,rate=t[0].rate,mrp=t[0].mrp,batch=t[0].batch,item=Product_master.objects.get(id=j['item']), qty = j['qty'])
                #             for st1 in t:
                #                 if j['qty'] >= st1.closing_balance:
                #                     j['qty'] -= st1.closing_balance
                #                     st1.delete()
                #                 else:
                #                     st1.closing_balance -= qty
                #                     st1.save()
                #                     break
                #     i['inner'] = newitems
            else:
                ConsumptionItems.objects.create(consumption=pd,rate=t[0].rate,mrp=t[0].mrp,batch=t[0].batch, item=Product_master.objects.get(id=i['item']), qty = i['qty'])

                for st1 in t:
                    if i['qty'] >= st1.closing_balance:
                        i['qty'] -= st1.closing_balance
                        st1.delete()
                    else:
                        st1.closing_balance -= i['qty']
                        st1.save()
                        break

        today               = datetime.date.today()
        grncount            = Consumption.objects.filter(created__date=today).count()
        batch               = today.strftime("%Y%m%d") + str(999-grncount).zfill(6)
        gd                  = Godown.objects.get(name="PRODUCTION")
        Stock_summary.objects.create(company=com, product=job.product,godown=gd, rate=0, batch=batch, mrp=job.product.mrp, closing_balance=qty)
        messages.success(request, "Consumption Added Successfully")
        return redirect('production:consumption')
    job = JobCard.objects.filter(rqty__gt = 0, rmindent__status=3).order_by('no')

    products = Stock_summary.objects.filter(godown__name='PRODUCTION')
    context = {'jobs':job,'no':job_no ,'products':products}

    return render(request, "production/add-consumption.html", context)

def loadconsumption(request):

    job         = JobCard.objects.get(id=request.GET.get('job'))
    qty         = Decimal(request.GET.get('qty'))
    items       = list(BomItems.objects.filter(bom=job.joborder.bom).values('bom__product__product_code','item','bom','bom__name','item__product_code','item__description','qty'))
    shortfall   = False
    # secondsf    = False
    # firstsf     = False
    for i in items:
        i['qty'] = round(i['qty'] * qty,4)
        st=Stock_summary.objects.filter(godown__name = 'PRODUCTION',product=i['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
        if st < i['qty']:
            i['sqty'] = round(i['qty'] - st,4)
            shortfall = True
            # bom=Bom.objects.filter(product = i['item']).last()
            # if bom:
            #     shortfall = False
            #     newitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','item__description','qty')))
            #     for j in newitems:
            #         j['qty'] = round(j['qty'] * i['sqty'], 4)
            #         st=Stock_summary.objects.filter(godown__name = 'PRODUCTION',product=j['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            #         if st < j['qty']:
            #             shortfall = True
            #             j['sqty'] = round(j['qty'] - st,4)
            #             bom=Bom.objects.filter(product = j['item']).last()
            #             if bom:
            #                 shortfall = False
            #                 sitems = (list(BomItems.objects.filter(bom=bom).values('bom__product__product_code','bom','item','bom__name','item__product_code','item__description','qty')))
            #                 for k in sitems:
            #                     k['qty'] = round(k['qty'] * j['sqty'], 4)
            #                     st=Stock_summary.objects.filter(godown__name = 'PRODUCTION',product=k['item']).aggregate(Sum('closing_balance'))['closing_balance__sum'] or 0
            #                     if st < k['qty']:
            #                         shortfall = True
            #                         k['sqty']   = round(k['qty'] - st,4)
            #                     else:
            #                         k['sqty'] = 0
            #                 j['inner'] = sitems
            #             else:
            #                 secondsf = shortfall
            #         else:
            #             j['sqty'] = 0
            #     i['inner'] = newitems
            # else:
            #     firstsf = shortfall
        else:
            i['sqty'] = 0

    context = {'items':items,'job':job, 'shortfall':(shortfall)}
    return render(request, "production/partials/loadconsumption.html", context)

def loadjobqty(request):

    job         = JobCard.objects.get(id=request.GET.get('job'))

    return HttpResponse(job.rqty)

def loadrmgodown(request):

    rm      = RMIndent.objects.get(id=request.GET.get('job'))
    items   = list(RMIndentItems.objects.filter(rmindent=rm))
    it = {}
    for item in items:
        qty = item.qty
        batch = Stock_summary.objects.filter(product=item.item, godown__godown_type=True).order_by('batch')
        stk = []
        for i in batch:
            qty -= i.closing_balance
            if qty <= 0:
                i.closing_balance += qty
                stk.append(i)
                break
            stk.append(i)
        it[item.item.product_code] = stk
    context = {'items':items, 'results':it}
    return render(request, "production/rmindentgodown.html", context)