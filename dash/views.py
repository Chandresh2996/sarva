from datetime import date, datetime, timedelta
from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from itertools import groupby
from operator import itemgetter
from dateutil import rrule
from core.decorators import allowed_users
from django.urls import reverse_lazy
from ledgers.models import Division, PartyType
from sales.models import CreditNote, InvItems, Invoice, Qdn, Rso, SalesTarget
from company.models import Company
from django.db.models import Sum
import pandas as pd
from django.db.models import Count, F, Value, IntegerField, Q, DecimalField
from django.db.models.functions import TruncMonth, ExtractDay, Cast, ExtractQuarter, ExtractYear,Floor
from django.db.models import Sum, Max
from decimal import Decimal

from itertools import groupby
from operator import itemgetter

@login_required(login_url=reverse_lazy('login'))
@allowed_users(allowed_roles=['Admin', 'DSR Report'])
def dsrReport(request):
    comp = Company.objects.all()

    start       = request.GET.get('startdate','a')
    end         = request.GET.get('enddate','a')

    if len(start) < 10:
        start   = datetime(2022, 4, 1)
    else:
        start   = datetime.strptime(start,'%Y-%m-%d')
    if len(end) < 10:
        end     = datetime.today()
    else:
        end     = datetime.strptime(end,'%Y-%m-%d')

    daterange   = [start, end]

    invoice     = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False ,inv_date__range = daterange).values('channel','division').order_by('channel').annotate(ammount=Sum('ammount'), mrpvalue=Sum('mrpvalue'), total=Sum('total')))
    cn          = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__range = daterange).values('channel','division').order_by('channel').annotate(ammount=-Sum('ammount'), total=-Sum('total')))
    qdn         = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__range = daterange).values('channel','division').order_by('channel').annotate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue')))
    rso         = list(Rso.objects.filter(status__in=['1','3'], rso_date__range = daterange).values('channel','division').order_by('channel').annotate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue')))

    divisions   = list(Division.objects.values_list('name', flat=True))
    channels    = list(PartyType.objects.values_list('name', flat=True))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    dff = df
    df = df.groupby(["channel",'division']).sum().reset_index().to_dict('records')


    rows        = groupby(df, itemgetter("channel"))
    data        = {c_title: list(items) for c_title, items in rows}

    dff = dff.groupby(["channel"]).sum().reset_index().to_dict('records')

    totals          = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False , inv_date__range = daterange).values('division').order_by('division').annotate(ammount=Sum('ammount'), mrpvalue=Sum('mrpvalue'), total=Sum('total')))
    cntotals        = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__range = daterange).values('division').order_by('division').annotate(ammount=-Sum('ammount'), total=-Sum('total')))
    qdntotals       = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__range=daterange).values('division').order_by('division').annotate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue')))
    rsototals       = list(Rso.objects.filter(status__in=['1','3'], rso_date__range=daterange).values('division').order_by('division').annotate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue')))

    finals = totals + cntotals + qdntotals + rsototals
    df = pd.DataFrame(finals)
    totals = df.groupby(['division']).sum().reset_index().to_dict('records')

    grandtotals     = Invoice.objects.filter(status__in=['1','3','4'],is_ict = False , inv_date__range = daterange).aggregate(ammount=Sum('ammount'), mrpvalue=Sum('mrpvalue'), total=Sum('total'))
    cnts            = CreditNote.objects.filter(status__in=['1','3'], cn_date__range = daterange).aggregate(ammount=-Sum('ammount'), total=-Sum('total'))
    qdnts           = Qdn.objects.filter(status__in=['1','3'], qdn_date__range=daterange).aggregate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue'))
    rsots           = Rso.objects.filter(status__in=['1','3'], rso_date__range=daterange).aggregate(total=-Sum('total'),ammount=-Sum('ammount'), mrpvalue=-Sum('mrpvalue'))

    if cnts:
        grandtotals['ammount'] += cnts['ammount'] or 0
        grandtotals['total'] += cnts['total'] or 0

    if qdnts:
        grandtotals['ammount'] += qdnts['ammount'] or 0
        grandtotals['total'] += qdnts['total'] or 0
        grandtotals['mrpvalue'] += qdnts['mrpvalue'] or 0

    if rsots:
        grandtotals['ammount'] += rsots.get('ammount') or 0
        grandtotals['total'] += rsots.get('total') or 0
        grandtotals['mrpvalue'] += rsots.get('mrpvalue') or 0

    return render (request, 'dashboard/index.html',{'companies':comp, 'data':data, 'channels':channels, 'divisions':divisions, 'totals':totals,'grandtotals':grandtotals, 'dff':dff,"start":start, "end":end})


@allowed_users(allowed_roles=['Admin', 'Score Card Report'])
def scorecard(request):
    try:
        divs        = Division.objects.values_list('name', flat=True)
    
        dat = date.today()
        currentmonth = dat.month
        currentyear = dat.year
    
        if request.method == 'POST':
            currentmonth       = int(request.POST.get('month',currentmonth))
            currentyear        = int(request.POST.get('year',currentyear))
    
        lastyear = currentyear -1
        month = date(currentyear, currentmonth,1)
        year = date(currentyear, 1,1)
    
        lastmonth = month - timedelta(days=30)
    
        years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=dat))
        years.reverse()
        months = list(rrule.rrule(rrule.MONTHLY, dtstart=year, count=12))
    
    
#***    ***************************** Total Business: start********************************
    
        totals          = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False).values('division').    order_by('division').annotate(total=Sum('total')))
        cntotals        = list(CreditNote.objects.filter(status__in=['1','3']).values('division').order_by('division').    annotate( total=-Sum('total')))
        qdntotals       = list(Qdn.objects.filter(status__in=['1','3']).values('division').order_by('division').annotate    (total=-Sum('total')))
        rsototals       = list(Rso.objects.filter(status__in=['1','3']).values('division').order_by('division').annotate    (total=-Sum('total')))
    
        finals = totals + cntotals + qdntotals + rsototals
        df = pd.DataFrame(finals)
        finals = df.groupby(df.get('division')).sum().reset_index().to_dict('records')
        finalstotal = df.agg({'total':'sum'}).reset_index().to_dict('records')
        finals.extend(finalstotal)
#***    ***************************** Total Business: end********************************
    
    
#***    ***************************** Years Totals: start********************************
    
        yearstotals          = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False).annotate    (year=ExtractYear('inv_date'),quarter=ExtractQuarter('inv_date')).values('year','quarter','division').order_by    ('-year','quarter','division').annotate(total=Sum('total')))
        cnyearstotals        = list(CreditNote.objects.filter(status__in=['1','3']).annotate(year=ExtractYear    ('cn_date'),quarter=ExtractQuarter('cn_date')).values('year','quarter','division').order_by('-year','quarter',    'division').annotate( total=-Sum('total')))
        qdnyearstotals       = list(Qdn.objects.filter(status__in=['1','3']).annotate(year=ExtractYear('qdn_date'),    quarter=ExtractQuarter('qdn_date')).values('year','quarter','division').order_by('-year','quarter','division').    annotate(total=-Sum('total')))
        rsoyearstotals       = list(Rso.objects.filter(status__in=['1','3']).annotate(year=ExtractYear('rso_date'),    quarter=ExtractQuarter('rso_date')).values('year','quarter','division').order_by('-year','quarter','division').    annotate(total=-Sum('total')))
    
        years_totals = yearstotals + cnyearstotals + qdnyearstotals + rsoyearstotals
        df = pd.DataFrame(years_totals)
        quarter_totals = df.groupby(['year','quarter','division']).agg({'total':'sum'}).reset_index().to_dict('records')
        quarters = df.groupby(['year','quarter']).agg({'total':'sum'}).reset_index().to_dict('records')
    
        rows        = groupby(quarters, itemgetter('year'))
        quarters     = {c_title: list(items) for c_title, items in rows}
    
        yearss = df.groupby(['year']).agg({'total':'sum'}).reset_index().to_dict('records')
        years_totals = df.groupby(['year','division']).agg({'total':'sum'}).reset_index().to_dict('records')
    
        yearss = {items['year']: items['total'] for items in yearss}
    
        rows        = groupby(quarter_totals, itemgetter('year'))
        quartes     = {c_title: list(items) for c_title, items in rows}
    
        rows        = groupby(years_totals, itemgetter('year'))
        data        = {c_title: list(items) for c_title, items in rows}
    
#***    ***************************** Years Totals: end********************************
    
    
#***    ***************************** Month Sales: start********************************
    
        monthgross           = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False, inv_date__month =     month.month, inv_date__year = month.year).values('division').order_by('division').annotate(total=Sum('total')))
        cnmonthtotals        = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__month = month.month,     cn_date__year = month.year).values('division').order_by('division').annotate( total=-Sum('total')))
        qdnmonthtotals       = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__month = month.month,     qdn_date__year = month.year).values('division').order_by('division').annotate(total=-Sum('total')))
        rsomonthtotals       = list(Rso.objects.filter(status__in=['1','3'], rso_date__month = month.month,     rso_date__year = month.year).values('division').order_by('division').annotate(total=-Sum('total')))
    
        month_totals = monthgross + cnmonthtotals + qdnmonthtotals + rsomonthtotals
        df = pd.DataFrame(month_totals)
        monthnet = df.groupby(df.get('division')).agg({'total':'sum'}).reset_index().to_dict('records')
        monthnet_total = df.agg({'total':'sum'}).total
        monthgross_total = Decimal(0.00)
        for i in range(0,len(monthgross)):
            monthgross_total += monthgross[i]['total']
    
        month_return = cnmonthtotals + qdnmonthtotals + rsomonthtotals
        df = pd.DataFrame(month_return)
        if df.empty:
            monthreturn = {}
            monthreturn_total = Decimal(0.00)
        else:
            monthreturn = df.groupby(df.get('division')).agg({'total':'sum'}).reset_index().to_dict('records')
            monthreturn_total = df.agg({'total':'sum'}).total
#***    ***************************** Month Sales: end********************************
    
    
#***    ***************************** Last Month Sales: start********************************
        lmonthgross1            = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False,inv_date__month =     lastmonth.month))
        lmonthgross           = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False, inv_date__month =     lastmonth.month, inv_date__year = lastmonth.year).values('division').order_by('division').annotate(total=Sum    ('total')))
        lcnmonthtotals        = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__month = lastmonth.month,     cn_date__year = lastmonth.year).values('division').order_by('division').annotate( total=-Sum('total')))
        lqdnmonthtotals       = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__month = lastmonth.month,     qdn_date__year = lastmonth.year).values('division').order_by('division').annotate(total=-Sum('total')))
        lrsomonthtotals       = list(Rso.objects.filter(status__in=['1','3'], rso_date__month = lastmonth.month,     rso_date__year = lastmonth.year).values('division').order_by('division').annotate(total=-Sum('total')))
    
        lmonth_totals = lmonthgross + lcnmonthtotals + lqdnmonthtotals + lrsomonthtotals
        df = pd.DataFrame(lmonth_totals)
        print("===>>", lmonthgross1)
        lmonthnet = df.groupby(df.get('division')).agg({'total':'sum'}).reset_index().to_dict('records')
        lmonthnet_total = sum(item['total'] for item in lmonthnet)
#***    ***************************** Last Month Sales: end********************************
    
#***    ***************************** Last Year Sales: start********************************
    
        ymonthgross           = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict = False, inv_date__month =     month.month, inv_date__year = lastyear).values('division').order_by('division').annotate(total=Sum('total')))
        ycnmonthtotals        = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__month = month.month,     cn_date__year = lastyear).values('division').order_by('division').annotate( total=-Sum('total')))
        yqdnmonthtotals       = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__month = month.month,     qdn_date__year = lastyear).values('division').order_by('division').annotate(total=-Sum('total')))
        yrsomonthtotals       = list(Rso.objects.filter(status__in=['1','3'], rso_date__month = month.month,     rso_date__year = lastyear).values('division').order_by('division').annotate(total=-Sum('total')))
    
        ymonth_totals = ymonthgross + ycnmonthtotals + yqdnmonthtotals + yrsomonthtotals
        df = pd.DataFrame(ymonth_totals)
        ymonth_totals = df.groupby(df.get('division')).agg({'total':'sum'}).reset_index().to_dict('records')
        lyearnet_total = sum(item['total'] for item in ymonth_totals)
    
#***    ***************************** Last Year Sales: end********************************
    
#***    ***************************** Month Counts: start********************************
    
        quantitytotal       = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month =     month.month,inv_date__year = month.year).values('division').order_by('division').annotate(total_count=Sum    ('bill_qty')+Sum('free_qty')))
        customercount       = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month =     month.month,inv_date__year = month.year).values('division').order_by('division').annotate(total_count=Count    ('buyer',distinct=True)))
        zonecount           = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month =     month.month,inv_date__year = month.year).values('buyer__zone__name','division').order_by('buyer__zone__name',    'division').annotate(total_count=Count('buyer',distinct=True)))
        statecount       = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month = month.    month,inv_date__year = month.year).values('division').order_by('division').annotate(total_count=Count    ('buyer__state',distinct=True)))
        citycount       = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month = month.    month,inv_date__year = month.year).values('division').order_by('division').annotate(total_count=Count    ('buyer__city',distinct=True)))
    
        citycount_total = sum(item['total_count'] for item in citycount)
        statecount_total = sum(item['total_count'] for item in statecount)
        customercount_total = sum(item['total_count'] for item in customercount)
        quantitytotal_total = sum(item['total_count'] for item in quantitytotal)
    
        zonetotals           = list(Invoice.objects.filter(status__in=['1','3','4'],is_ict=False, inv_date__month =     month.month,inv_date__year = month.year).values('buyer__zone__name','division').order_by('buyer__zone__name',    'division').annotate(total=Sum('total')))
        cnzonetotals        = list(CreditNote.objects.filter(status__in=['1','3'], cn_date__month = month.month).values    ('buyer__zone__name','division').order_by('buyer__zone__name','division').annotate( total=-Sum('total')))
        qdnzonetotals       = list(Qdn.objects.filter(status__in=['1','3'], qdn_date__month = month.month).values    ('buyer__zone__name','division').order_by('buyer__zone__name','division').annotate(total=-Sum('total')))
        rsozonetotals       = list(Rso.objects.filter(status__in=['1','3'], rso_date__month = month.month).values    ('buyer__zone__name','division').order_by('buyer__zone__name','division').annotate(total=-Sum('total')))
    
        zonecount_east = sum(item['total_count'] for item in zonecount if item['buyer__zone__name'] == 'EAST')
        zonecount_north = sum(item['total_count'] for item in zonecount if item['buyer__zone__name'] == 'NORTH')
        zonecount_south = sum(item['total_count'] for item in zonecount if item['buyer__zone__name'] == 'SOUTH')
        zonecount_west = sum(item['total_count'] for item in zonecount if item['buyer__zone__name'] == 'WEST')
    
        rows            = groupby(zonecount, itemgetter('buyer__zone__name'))
        zonecount       = {c_title: list(items) for c_title, items in rows}
    
        zonecount['EAST'].append({'grand_total_count': zonecount_east})
        zonecount['NORTH'].append({'grand_total_count': zonecount_north})
        zonecount['SOUTH'].append({'grand_total_count': zonecount_south})
        zonecount['WEST'].append({'grand_total_count': zonecount_west})
    
        brandcount     = list(InvItems.objects.filter(inv__status__in=['1','3','4'],inv__is_ict=False,     inv__inv_date__month = month.month,inv__inv_date__year = month.year).annotate(division=F('inv__division')).    values('division').order_by('division').annotate(total_count=Count('item__brand',distinct=True)))
        productcount     = list(InvItems.objects.filter(inv__status__in=['1','3','4'],inv__is_ict=False,     inv__inv_date__month = month.month,inv__inv_date__year = month.year).annotate(division=F('inv__division')).    values('division').order_by('division').annotate(total_count=Count('item',distinct=True)))
        classcount     = list(InvItems.objects.filter(inv__status__in=['1','3','4'],inv__is_ict=False,     inv__inv_date__month = month.month,inv__inv_date__year = month.year).annotate(division=F('inv__division')).    values('division').order_by('division').annotate(total_count=Count('item__product_class',distinct=True)))
        subclasscount     = list(InvItems.objects.filter(inv__status__in=['1','3','4'],inv__is_ict=False,     inv__inv_date__month = month.month,inv__inv_date__year = month.year).annotate(division=F('inv__division')).    values('division').order_by('division').annotate(total_count=Count('item__sub_class',distinct=True)))
        subbrandcount     = list(InvItems.objects.filter(inv__status__in=['1','3','4'],inv__is_ict=False,     inv__inv_date__month = month.month,inv__inv_date__year = month.year).annotate(division=F('inv__division')).    values('division').order_by('division').annotate(total_count=Count('item__sub_brand',distinct=True)))
    
        subclasscount_total = sum(item['total_count'] for item in subclasscount)
        classcount_total = sum(item['total_count'] for item in classcount)
        subbrandcount_total = sum(item['total_count'] for item in subbrandcount)
        brandcount_total = sum(item['total_count'] for item in brandcount)
        productcount_total = sum(item['total_count'] for item in productcount)
    
        zonetotals = zonetotals + cnzonetotals + qdnzonetotals + rsozonetotals
        df = pd.DataFrame(zonetotals)
        zonetotals = df.groupby([df.get('buyer__zone__name'),df.get('division')]).agg({'total':'sum'}).reset_index().    to_dict('records')
        zonetotal_east = sum(item['total'] for item in zonetotals if item['buyer__zone__name'] == 'EAST')
        zonetotal_north = sum(item['total'] for item in zonetotals if item['buyer__zone__name'] == 'NORTH')
        zonetotal_south = sum(item['total'] for item in zonetotals if item['buyer__zone__name'] == 'SOUTH')
        zonetotal_west = sum(item['total'] for item in zonetotals if item['buyer__zone__name'] == 'WEST')
        
        rows            = groupby(zonetotals, itemgetter('buyer__zone__name'))
        zonetotals       = {c_title: list(items) for c_title, items in rows}
        zonetotals['EAST'].append({'grand_total': zonetotal_east})
        zonetotals['NORTH'].append({'grand_total': zonetotal_north})
        zonetotals['SOUTH'].append({'grand_total': zonetotal_south})
        zonetotals['WEST'].append({'grand_total': zonetotal_west})
        # month_return = cnmonthtotals + qdnmonthtotals + rsomonthtotals
        # df = pd.DataFrame(month_return)
        # monthreturn = df.groupby(df.get('division')).agg({'total':'sum'}).reset_index().to_dict('records')
#***    ***************************** Month Counts: end********************************
    
        targets     = list(SalesTarget.objects.filter(months=month).annotate(division = F('buyer__devision__name')).    values('division').order_by('division').annotate(target = Max('target')))
        context     = {'months' : months, 'currentmonth':month,'currentyear':year,'years':years,'divs':divs,     'divs':divs,'totals':finals,'years_totals':data,'yearss':yearss,'quartes':quartes,'quarters':quarters,    'monthnet':monthnet,'lmonthnet':lmonthnet,'lyearnet':ymonth_totals,'monthgross':monthgross,    'monthreturn':monthreturn
                    ,'brandcount': brandcount,'classcount':classcount,'subclasscount':subclasscount,    'subbrandcount':subbrandcount,'productcount':productcount
                    ,'customercount':customercount, 'zonecount':zonecount,'zonetotals':zonetotals,    'statecount':statecount,'citycount':citycount,'quantitytotal':quantitytotal,'targets':targets,     'monthnet_total':monthnet_total,'monthgross_total':monthgross_total,     'monthreturn_total':monthreturn_total
                    ,'citycount_total':citycount_total, 'statecount_total':statecount_total, 'customercount_total':     customercount_total, 'quantitytotal_total': quantitytotal_total
                    ,'subclasscount_total':subclasscount_total, 'classcount_total':classcount_total,     'subbrandcount_total':subbrandcount_total,'brandcount_total':brandcount_total,     'productcount_total':productcount_total
                    ,'lmonthnet_total':lmonthnet_total, 'lyearnet_total':lyearnet_total
        }
        return render (request, 'reports/sales/stockaeging.html', context)
    except Exception as e:
        # Handle the exception here
        error_message = "No records available."
        
        # Add the error message to the existing context
        context ={
            'error_message': error_message,
        }

        return render (request, 'reports/sales/stockaeging.html', context)

@login_required(login_url=reverse_lazy('login'))
def home(request):
    comp = Company.objects.all()

    return render (request, 'dashboard/myhome.html',{'companies':comp})


    #  ----------------------------------------------------------------------------------HTMX-Partials-----------

def clear(request):
    return HttpResponse("")