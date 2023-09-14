from decimal import Decimal
from django.shortcuts import render
from django.db.models import Sum, Max
from inventory.models import Product_master, Gst_list, Std_rate
from ledgers.models import Division, Party_master, Zone, Party_contact_details
from planning.models import BomItems, JobOrder
from production.models import Consumption, ConsumptionItems, JobCard, RMIndent, RMItemGodown
from purchase.models import PoItems, Purchase, Purchase_order, grnItems, PiItems
from sales.models import CreditNote, CreditNoteItems, Invoice, LoadingSheet, Qdn, QdnItems, Rso, RsoItems, SaleQty, SalesTarget, Salesorder, SoItems, DnItems, InvItems
from sales.views import salable
from warehouse.models import PalletTransferEntry, ShortageDamageEntry, Stock_summary
from company.models import Company
from core.decorators import auth_users, allowed_users
from django.http import JsonResponse
from django.db.models.functions import TruncMonth, ExtractDay, Cast, ExtractQuarter, ExtractYear,Floor
from datetime import datetime, date, timedelta
from django.db.models import Count, F, Value, IntegerField, Q, DecimalField
from itertools import groupby
from operator import itemgetter
from dateutil import rrule
import requests, xmltodict, json
from django.http import HttpResponse
from collections import defaultdict
import pandas as pd



def sls_reports(request):

    return render (request, 'reports/accounting/sales-reports.html')

def wrh_reports(request):

    return render (request, 'reports/inventory/warehouse-reports.html')

def prd_reports(request):

    return render (request, 'reports/production/production-reports.html')


def ivt_reports(request):

    return render (request, 'reports/inventory/inventory-reports.html')

def prs_reports(request):

    return render (request, 'reports/accounting/purchase-reports.html')


def pmdata(request):

    queryset = list(Product_master.objects.all().values("article_code","ean_code","product_code","old_product_code","product_name","description","brand__code","brand__name","sub_brand__name","category__name","product_class__name","sub_class__name","product_type__name","units_of_measure__symbol","hsn","gst","shape_code","size","style_shape","series","pattern","country_of_origin","color_shade_theme","inner_qty","outer_qty","imported_by","mfd_by","mkt_by",'mrp'))
    return JsonResponse({'data':queryset})


@allowed_users(allowed_roles=['Admin', 'Article Master Report'])
def pm(request):

    return render (request, 'reports/inventory/product_master.html')


def permissions(request):

    return render (request, 'reports/permissions_list.html')

def smdata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(Product_master.objects.filter(product_type__name = "FINISHED GOODS").values("id","brand__name","sub_brand__name","category__name","product_class__name","sub_class__name","article_code","ean_code","product_code","product_name","inner_qty","outer_qty","hsn","gst","mrp","series","shape_code","pattern"))
    
    for i in queryset:
        i['qty'] = salable(com,i['id'])

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Stock Summary (Salable) Report'])
def sm(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    return render (request, 'reports/inventory/stock_summary.html')

def stockdata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(Stock_summary.objects.filter(company=com).values("product__article_code","product__ean_code","product__product_code","product__product_name","product__description","product__inner_qty","product__outer_qty","product__brand__name","product__sub_brand__name","product__category__name","product__product_class__name",
        "product__sub_class__name","product__series","product__shape_code","product__pattern","product__units_of_measure__symbol","product__hsn","product__gst","godown__name","godown__godown_type","mrp","closing_balance","rate"))

    for i in queryset:
        if i['godown__godown_type']:
            i['godown__godown_type']='Salable'
        else:
            i['godown__godown_type']='Non Salable'


    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Stock Report'])
def stock(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    return render (request, 'reports/inventory/stock_report.html')

def inventorydata(request):

    queryset = list(Stock_summary.objects.all().values("product__product_code","company","godown__godown_type").annotate(qty=Sum('closing_balance'),name=F('product__product_name'), brand=F('product__brand__name'),subbrand = F('product__sub_brand__name'),
    category=F('product__category__name'),pclass = F('product__product_class__name'),subclass= F('product__sub_class__name'),alu = F('product__article_code'),ean_code = F('product__ean_code'),inner=F('product__inner_qty'),outer = F('product__outer_qty'), hsn=F('product__hsn'),
    gst = F('product__gst'), mrp = F('product__mrp'), series= F('product__series'), shape=F('product__shape_code'), pattern=F('product__pattern') ))

    data = {}
    for i in queryset:
        if not data.get(i['product__product_code']):
            data[i['product__product_code']]={**i}

        if i['company'] == 1 and i['godown__godown_type'] == False:
         data[i['product__product_code']]['b'] = i['qty']

        if i['company'] == 1 and i['godown__godown_type'] == True:
         data[i['product__product_code']]['a'] = i['qty']

        if i['company'] == 2 and i['godown__godown_type'] == True:
         data[i['product__product_code']]['c'] = i['qty']

        if i['company'] == 2 and i['godown__godown_type'] == False:
         data[i['product__product_code']]['d'] = i['qty']

        data[i['product__product_code']]['name']= i['name']

    data2 = [{**data[i]} for i in data]

    return JsonResponse({'data':data2})

@allowed_users(allowed_roles=['Admin', 'Inventory Report'])
def inventory(request):

    return render (request, 'reports/inventory/inventory_report.html')


def vmdata(request):

    queryset = list(Party_master.objects.filter(group__name = 'Sundry Creditors').values("vendor_code","name","zone__name","pin_code","city__name","state__name","addressline1","addressline2","addressline3","contact_person","phone_no","mobile_no","email_id","cc_email","gstin","payment_terms","credit_limit","closing_balance"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Vendor Master Report'])
def vm(request):

    return render (request, 'reports/accounting/vendor_master.html')


def cmdata(request):

    queryset = list(Party_master.objects.filter(group__name = 'Sundry Debtors').values("vendor_code","name","zone__name","region__name","zsm__name","rsm__name","asm__name","se__name","party_type__name","pin_code","devision__name","cc_email",
        "city__name","state__name","addressline1","addressline2","addressline3","contact_person","phone_no","mobile_no","email_id","gstin","payment_terms","credit_limit","price_level__name","closing_balance"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Customer Master Report'])
def cm(request):

    return render (request, 'reports/accounting/customer_master.html')

def dndata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(DnItems.objects.filter(dn__company=com).annotate(invoice = F('igst')+ F('amount')).values("dn__sales_order__so_date","dn__sales_order__so_no","dn__dn_date","dn__dn_no","dn__order_no","dn__buyer__devision__name","dn__buyer__name","dn__buyer__vendor_code","dn__buyer__zone__name",
        "dn__buyer__region__name","dn__buyer__zsm__name","dn__buyer__rsm__name","dn__buyer__asm__name","dn__buyer__se__name","dn__buyer__party_type__name","dn__buyer_state","dn__buyer_city","dn__mode_of_payment","item__brand__name","item__sub_brand__name","item__category__name",
        "item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__product_name","item__inner_qty","pack","dn__scheme","billed_qty","free_qty",
        "mrp","offer_mrp","rate","discount","amount","item__hsn","igstrate","igst","invoice"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Delivery Note Report'])
def dn(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/delivery_note_report.html')


def ddndata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(LoadingSheet.objects.filter(company=com).values("dn__sales_order__so_date","dn__sales_order__so_no","dn__dn_date","dn__dn_no","dn__order_no","dn__buyer__devision__name","dn__buyer__name","dn__buyer__vendor_code",
        "dn__buyer__party_type__name","item__product_code","item__product_name","item__inner_qty","item__outer_qty","dn__scheme","qty","godown"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Loading Sheet Report'])
def ddn(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/ddelivery_note_report.html')

def grndata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(grnItems.objects.filter(grn__company=com).values("grn__grn_no","grn__grn_date","grn__po__po_no","grn__po__po_date","grn__other_reference","grn__seller__name","item__brand__name","item__article_code","item__product_code","item__product_name","item__mrp",
        "item__inner_qty","item__outer_qty","item__hsn","igstrate","recd_qty"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'GRN Report'])
def grn(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    return render (request, 'reports/accounting/grn_report.html')

def podata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(PoItems.objects.filter(po__company=com).values("po__po_date","po__po_no","po__other_reference","po__seller__name","item__article_code","product_code","item__product_name","item__brand__name","item__mrp","basic_qty","rate","item__hsn",
        "igstrate","igst","amount","item__units_of_measure__symbol","po__po_due_date"))
    for i in queryset:
        i['invoice'] = i['amount'] + i['igst']
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Purchase Order Report'])
def po(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render(request, 'reports/accounting/purchase_order_report.html')

def pogrndata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(PoItems.objects.filter(po__company=com).values("po__po_date","po__po_no","po__other_reference","po__seller__name","item__product_name","product_code","item__brand__name","item__mrp","basic_qty","actual_qty","item__article_code"))
    for i in queryset:
        i['recieved_qty'] = i['basic_qty'] - i['actual_qty']
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'PO vs GRN Report'])
def pogrn(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/po_vs_grn_report.html')


def purchasedata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(PiItems.objects.filter(pi__company=com,pi__status__in=[1,3], recd_qty__gt=0).values("pi__pi_date","pi__pi_no","grn__po__po_due_date","grn__po__po_date","grn__po__po_no","grn__grn_no","grn__grn_date","pi__supplier_invoice","grn__other_reference","pi__seller__name","pi__seller__zone__name","pi__seller_state","pi__seller_city","pi__seller_pincode","pi__seller_address1","pi__seller_gstin",
        "item__article_code","item__ean_code","product_code","item__product_name","item__inner_qty","item__inner_qty","item__outer_qty","pi__company__name","item__brand__name","item__sub_brand__name","item__category__name","item__product_class__name","item__sub_class__name",
        "item__hsn","mrp","recd_qty","rate","igst","igstrate","amount"))

    for i in queryset:
        i['total'] = i['amount'] + i['igst']
        i['mrptotal'] = Decimal(i['mrp']) * i['recd_qty']

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Purchase Report'])
def purchase(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/purchase_report.html')

def multiaddressdata(request):

    queryset = list(Party_contact_details.objects.all().values("party__name","address_type","mailing_name","addressline1","addressline2","addressline3","country__name","state__name","city__name",
        "pin_code","contact_person","phone_no","mobile_no","fax_no","email_id","pan_no","gst_registration_type","gstin"))

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Multiple Addresss Report'])
def multiaddress(request):
    return render (request, 'reports/accounting/multiaddress_report.html')

def standardcostdata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)
    queryset = list(Std_rate.objects.filter(rate_type='1').values("product__brand__name", "product__article_code", "product__product_code", "product__product_name", "product__outer_qty", "rate", "applicable_from"))

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Standard Cost Report'])
def standardcost(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/standardcost_report.html')


def sodata(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    queryset = list(SoItems.objects.filter(so__company=com, so__status__in =['1','3'] ).values("so__so_date","so__so_no","so__order_no","so__buyer__devision__name","so__buyer__name","so__buyer__vendor_code","so__buyer__zone__name","so__buyer__region__name","so__buyer__zsm__name","so__buyer__rsm__name","so__buyer__asm__name",
        "so__buyer__se__name","so__buyer__party_type__name","so__buyer_state","so__buyer_city","so__mode_of_payment","item__brand__name","item__sub_brand__name","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code",
        "item__product_name","item__inner_qty","pack","billed_qty","free_qty","mrp","offer_mrp","rate","discount","amount","item__hsn","igstrate","igst"))

    for i in queryset:
        i['tmrp'] = round((Decimal(i['mrp']) * Decimal(i['billed_qty'])),2)
        i['total'] = round((Decimal(i['igst']) + Decimal(i['amount'])),2)
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Sales Order Report'])
def so(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/sales_order_report.html')

# def invdata(request):

#     try:
#         skey = (request.session.get('skey').get('company').get('id'))
#     except:
#         return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

#     com = Company.objects.get(pk=skey)

#     queryset = list(InvItems.objects.filter(inv__company=com).values("inv__buyer__devision__name","inv__buyer__name","inv__buyer__vendor_code","inv__buyer__zone__name","inv__buyer__region__name","inv__buyer_state","inv__buyer_city","inv__buyer__zsm__name","inv__buyer__rsm__name","inv__buyer__asm__name","inv__buyer__se__name",
#         "inv__buyer__party_type__name","item__brand__name","item__sub_brand__name","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__product_name","item__inner_qty","pack","inv__dn__sales_order","inv__dn__sales_order__order_no",
#         "inv__dn__sales_order__so_date","inv__dn","inv__dn__dn_date","inv__inv_no","inv__inv_date","billed_qty","free_qty","actual_qty","rate","discount","mrp","mrp","offer_mrp","offer_mrp","amount","igstrate","igst","amount","item__hsn","inv__company"))
#     return JsonResponse({'data':queryset})

# @allowed_users(allowed_roles=['Admin', 'Sales Invoice Report'])
# def inv(request):

#     return render (request, 'reports/accounting/sales_report.html')

def sodninvdata(request):
    start       = request.GET.get('from','a')
    end         = request.GET.get('to','a')

    if len(start) < 10:
        start   = datetime(2022, 4, 1)
    else:
        start   = datetime.strptime(start,'%Y-%m-%d')
    if len(end) < 10:
        end     = datetime.today()
    else:
        end     = datetime.strptime(end,'%Y-%m-%d')

    daterange   = [start, end]

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)
    com = Company.objects.get(pk=skey)

    queryset = list(Salesorder.objects.filter(company=com, buyer__devision__name__in = divs,so_date__range = daterange,status__in =['1','3']).values("buyer__devision__name","so_date","so_no","order_no","buyer__name","buyer__vendor_code","buyer__zone__name","buyer__region__name","buyer_state","buyer_city","buyer__zsm__name","buyer__rsm__name","buyer__asm__name","buyer__se__name","buyer__party_type__name","buyer__payment_terms",
        "bill_qty","free_qty","total","dn__dn_no","dn__dn_date","dn__bill_qty","dn__carrier_agent","dn__free_qty","dn__total","dn__inv__inv_no","dn__inv__inv_date","dn__inv__bill_qty","dn__inv__free_qty","dn__inv__ammount","dn__inv__total","dn__inv__lr_no","dn__inv__lr_date"))

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Order vs Sales Tracker Report'])
def sodninv(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/so_dn_inv_report.html')

def bomdata(request):

    queryset = list(BomItems.objects.all().values("bom__name","bom__product__product_code","item__product_code","qty"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'BOM Report'])
def bom(request):

    return render(request, 'reports/production/bom.html')

# def productiondata(request):

#     queryset = list(BomItems.objects.all().values("bom","bom__product","item__product_code","qty"))
#     return JsonResponse({'data':queryset})

# @allowed_users(allowed_roles=['Admin', 'Production Report'])
# def production(request):

#     return render(request, 'reports/production/production.html')

# def consumptiondata(request):

#     queryset = list(BomItems.objects.all().values("bom","bom__product","item__product_code","qty"))
#     return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Material Used Report'])
def consumption(request):

    return render(request, 'reports/inventory/hsn_report.html')

def hsndata(request):

    queryset = list(Gst_list.objects.all().values("applicable_from","product__product_code","product__product_name","hsncode","discription","is_Non_gst","calc_type","taxability","reverse_charge","input_credit_ineligible","cgstrate","sgstrate","igstrate","suply_type"))
    for i in queryset:
        if i['is_Non_gst']:
            i['is_Non_gst'] = 'Yes'
        else:
            i['is_Non_gst'] = 'No'

        if i['input_credit_ineligible']:
            i['input_credit_ineligible'] = 'Yes'
        else:
            i['input_credit_ineligible'] = 'No'

        if i['reverse_charge']:
            i['reverse_charge'] = 'Yes'
        else:
            i['reverse_charge'] = 'No'
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'HSN Report'])
def hsn(request):

    return render(request, 'reports/inventory/hsn_report.html')


def WeekOfMonth(date):

    day     = ExtractDay(date)
    week    = (day / 7) + 1
    return Floor(week)


def dsum(*dicts):
    ret = defaultdict(int)
    for d in dicts:
        for k, v in d.items():
            ret[k] += v
    return dict(ret)

@allowed_users(allowed_roles=['Admin', 'Weekly Sales Performance Report'])
def weeksales(request):

    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com         = Company.objects.get(pk=skey)

    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    current_year = date.today().year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    if division == ['All']:
        division = divs

    invoice     = Invoice.objects.filter(company=com, status__in=['1','3','4'], division__in = division, inv_date__year=current_year, is_ict=False).annotate(month=TruncMonth('inv_date'),week=Cast(WeekOfMonth('inv_date'), IntegerField())).values('month','week').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    cn          = CreditNote.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, cn_date__year=current_year).annotate(month=TruncMonth('cn_date'),week=Cast(WeekOfMonth('cn_date'), IntegerField())).values('month','week').order_by('-month').annotate(total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    qdn         = Qdn.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, qdn_date__year=current_year).annotate(month=TruncMonth('qdn_date'),week=Cast(WeekOfMonth('qdn_date'), IntegerField())).values('month','week').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    rso         = Rso.objects.filter(company=com, status__in=['1','3'], buyer__devision__name__in = division, rso_date__year=current_year).annotate(month=TruncMonth('rso_date'),week=Cast(WeekOfMonth('rso_date'), IntegerField())).values('month','week').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))


    moths       = Invoice.objects.filter(company=com, status__in=['1','3','4'], division__in = division, inv_date__year=current_year, is_ict=False).annotate(month=TruncMonth('inv_date')).values('month').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    cnmonths    = CreditNote.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, cn_date__year=current_year).annotate(month=TruncMonth('cn_date')).values('month').order_by('-month').annotate(total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    qdnmonths   = Qdn.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, qdn_date__year=current_year).annotate(month=TruncMonth('qdn_date')).values('month').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))
    rsomonths   = Rso.objects.filter(company=com, status__in=['1','3'], buyer__devision__name__in = division, rso_date__year=current_year).annotate(month=TruncMonth('rso_date')).values('month').order_by('-month').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue'))


    rows        = groupby(invoice, itemgetter('month'))
    data        = {c_title: list(items) for c_title, items in rows}

    cnrows      = groupby(cn, itemgetter('month'))
    cndata      = {c_title: list(items) for c_title, items in cnrows}

    qdnrows     = groupby(qdn, itemgetter('month'))
    qdndata     = {c_title: list(items) for c_title, items in qdnrows}

    rsorows     = groupby(rso, itemgetter('month'))
    rsodata     = {c_title: list(items) for c_title, items in rsorows}

    rows2       = groupby(moths, itemgetter('month'))
    data2       = {c_title: list(items) for c_title, items in rows2}

    for i in data2.keys():
        cn = cnmonths.filter(month=i)
        rso = rsomonths.filter(month=i)
        qdn = qdnmonths.filter(month=i)

        if cn:
            data2[i][0]['total_price'] -= cn[0]['total_price']
            data2[i][0]['basic'] -= cn[0]['basic']

        if qdn:
            data2[i][0]['total_price'] -= qdn[0]['total_price']
            data2[i][0]['basic'] -= qdn[0]['basic']
            data2[i][0]['total_qty'] -= qdn[0]['total_qty']
            data2[i][0]['mrp'] -= qdn[0]['mrp']

        if rso:
            data2[i][0]['total_price'] -= rso[0]['total_price']
            data2[i][0]['basic'] -= rso[0]['basic']
            data2[i][0]['total_qty'] -= rso[0]['total_qty']
            data2[i][0]['mrp'] -= rso[0]['mrp']

    for i in data.keys():
        data2[i][0]['week'] = 6
        (data[i]).append(data2[i][0])
        for j in data[i]:
            if cndata.get(i):
                second = next((item for item in cndata[i] if item["week"] == j['week']), False)
                if second:
                    j['total_price'] -= second['total_price']
                    j['basic'] -= second['basic']

            if qdndata.get(i):
                third = next((item for item in qdndata[i] if item["week"] == j['week']), False)
                if third:
                    j['total_price'] -= third['total_price']
                    j['basic'] -= third['basic']
                    j['total_qty'] -= third['total_qty']
                    j['mrp'] -= third['mrp']

            if rsodata.get(i):
                forth = next((item for item in rsodata[i] if item["week"] == j['week']), False)
                if forth:
                    j['total_price'] -= forth['total_price']
                    j['basic'] -= forth['basic']
                    j['total_qty'] -= forth['total_qty']
                    j['mrp'] -= forth['mrp']

    end_date = date.today()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()

    context     = {'data' : data, 'currentdiv':currentdiv, 'years':years, 'current_year':current_year}
    context['divs'] = divs

    return render (request, 'reports/sales/weeksales.html', context)

def filterdivision(request):

    pass

@allowed_users(allowed_roles=['Admin', 'Target vs Sales Performance Report'])
def citysales(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)

    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    if division == ['All']:
        division = divs
    invoice     = Invoice.objects.filter(company=com,status__in=['1','3','4'],division__in = division, inv_date__year=current_year,is_ict=False).annotate(month=TruncMonth('inv_date')).values('buyer__vendor_code','month').order_by('buyer').annotate(total=Sum('total'), customer_code=F('buyer__vendor_code'), customer_name=F('buyer__name'), se=F('buyer__se__name'), asm=F('buyer__asm__name'), rsm=F('buyer__rsm__name'), zsm=F('buyer__zsm__name'), city=F('buyer_city'), state=F('buyer_state'), region=F('buyer__region__name'), zone=F('buyer__zone__name'), channel_type=F('buyer__party_type__name'), division=F('division'))

    rows        = groupby(invoice, itemgetter('buyer__vendor_code'))
    data        = {c_title: list(items) for c_title, items in rows}

    targets     = SalesTarget.objects.all().annotate(month=TruncMonth('months')).values('buyer__vendor_code','month').order_by('buyer').annotate(target = Max('target'), customer_code=F('buyer__vendor_code'), customer_name=F('buyer__name'), se=F('buyer__se__name'), asm=F('buyer__asm__name'), rsm=F('buyer__rsm__name'), zsm=F('buyer__zsm__name'), city=F('buyer__city__name'), state=F('buyer__state__name'), region=F('buyer__region__name'), zone=F('buyer__zone__name'), channel_type=F('buyer__party_type__name'), division=F('buyer__devision__name'))

    rows2        = groupby(targets, itemgetter('buyer__vendor_code'))
    data2        = {c_title: list(items) for c_title, items in rows2}

    dd = defaultdict(list)
    for d in (data, data2):
        # print(d)
        for key, value in d.items():
            dd[key].extend(value)

    dd.default_factory = None
    start_date = date(int(current_year), 1, 1)
    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    # rows2        = groupby(moths, itemgetter('month'))
    # data2        = {c_title: list(items) for c_title, items in rows2}

    # queryset    = list(InvItems.objects.filter(inv__company=com).values("inv__buyer__devision__name","inv__inv_date","actual_qty","rate","mrp","offer_mrp","amount","igst"))
    context     = {'data' : dd, 'months':months, 'years':years, 'current_year':current_year,'currentdiv':currentdiv, 'divs':divs}

    return render (request, 'reports/sales/citysales.html', context)

@allowed_users(allowed_roles=['Admin', 'Customer Sales Performance Report'])
def customersales(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    if division == ['All']:
        division = divs
    invoice     = list(Invoice.objects.filter(company=com, status__in=['1','3','4'],division__in = division, inv_date__year=current_year,is_ict=False).annotate(month=TruncMonth('inv_date')).values('buyer__name','month').order_by('-buyer__name').annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue')))
    cn          = list(CreditNote.objects.filter(company=com, status__in=['1','3'], division__in = division, cn_date__year=current_year).annotate(month=TruncMonth('cn_date')).values('buyer__name','month').order_by('-buyer__name').annotate(total_price=-Sum('total'),basic=-Sum('ammount')))
    qdn         = list(Qdn.objects.filter(company=com, status__in=['1','3'], division__in = division, qdn_date__year=current_year).annotate(month=TruncMonth('qdn_date')).values('buyer__name','month').order_by('-buyer__name').annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))
    rso         = list(Rso.objects.filter(company=com, status__in=['1','3'], division__in = division, rso_date__year=current_year).annotate(month=TruncMonth('rso_date')).values('buyer__name','month').order_by('-buyer__name').annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))

    # rows        = groupby(invoice, itemgetter('buyer__name'))
    # data        = {c_title: list(items) for c_title, items in rows}

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get('buyer__name'),df.get('month')]).sum(numeric_only=False).reset_index().to_dict('records')

    rows        = groupby(df, itemgetter('buyer__name'))
    data        = {c_title: list(items) for c_title, items in rows}

    end_date = date.today()
    start_date = date(int(current_year), 1, 1)

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    context     = {'data' : data, 'months':months, 'years':years,'currentdiv':currentdiv, 'divs':divs, 'current_year':current_year}

    return render (request, 'reports/sales/customersales.html', context)

@allowed_users(allowed_roles=['Admin', 'Regional Sales Performance Report'])
def zonesales(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    defaultfilter = 'buyer__zone__name'
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        defaultfilter = request.POST.get('defaultfilter')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    currentfilter = defaultfilter
    if division == ['All']:
        division = divs

    invoice     = list(Invoice.objects.filter(company=com, status__in=['1','3','4'],division__in = division, inv_date__year=current_year,is_ict=False).annotate(month=TruncMonth('inv_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_qty=Sum('bill_qty')+Sum('free_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue')))
    cn          = list(CreditNote.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, cn_date__year=current_year).annotate(month=TruncMonth('cn_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_price=-Sum('total'),basic=-Sum('ammount')))
    qdn         = list(Qdn.objects.filter(company=com, status__in=['1','3'], inv__division__in = division, qdn_date__year=current_year).annotate(month=TruncMonth('qdn_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))
    rso         = list(Rso.objects.filter(company=com, status__in=['1','3'], buyer__devision__name__in = division, rso_date__year=current_year).annotate(month=TruncMonth('rso_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get(defaultfilter),df.get('month')]).sum().reset_index().to_dict('records')

    rows        = groupby(df, itemgetter(defaultfilter))
    data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(int(current_year), 1, 1)
    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    context     = {'data' : data, 'months':months, 'years':years,'currentdiv':currentdiv, 'divs':divs, 'currentfilter':currentfilter, 'current_year':current_year}

    return render (request, 'reports/sales/zonesales.html', context)

@allowed_users(allowed_roles=['Admin', 'Zonal Sales Performance Report'])
def statesales(request):

    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']

    if request.method == 'POST':
        division    = request.POST.getlist('division')

    currentdiv  = division
    if division == ['All']:
        division = divs

    invoice     = list(Invoice.objects.filter(company=com, status__in=['1','3','4'],division__in = division).annotate(month=TruncMonth('inv_date')).values('buyer_state','month').order_by('-buyer_state').annotate(total_qty=Sum('bill_qty'),total_price=Sum('total'),basic=Sum('ammount'),mrp = Sum('mrpvalue')))
    # cn          = list(CreditNote.objects.filter(company=com, status__in=['1','3'], inv__division__in = division).annotate(month=TruncMonth('cn_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_price=-Sum('total'),basic=-Sum('ammount')))
    # qdn         = list(Qdn.objects.filter(company=com, status__in=['1','3'], inv__division__in = division).annotate(month=TruncMonth('qdn_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))
    # rso         = list(Rso.objects.filter(company=com, status__in=['1','3'], buyer__devision__name__in = division).annotate(month=TruncMonth('rso_date')).values(currentfilter,'month').order_by(currentfilter).annotate(total_qty=-Sum('bill_qty')-Sum('free_qty'),total_price=-Sum('total'),basic=-Sum('ammount'),mrp = -Sum('mrpvalue')))

    # rows        = groupby(invoice, itemgetter('buyer_state'))
    # data        = {c_title: list(items) for c_title, items in rows}

    # finals = invoice + cn + qdn + rso
    # df = pd.DataFrame(finals)
    # df = df.groupby([df.get(defaultfilter),df.get('month')]).sum().reset_index().to_dict('records')

    # rows        = groupby(df, itemgetter(defaultfilter))
    # data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(2022, 4, 1)

    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date))
    months.reverse()
    context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs}

    return render (request, 'reports/sales/statesales.html', context)

@allowed_users(allowed_roles=['Admin', 'Zonal Sales Performance Report'])
def zonewisebrandreport(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    defaultfilter = 'item__brand__name'

    start       = str(date(2022, 4, 1))
    end         = str(date.today())

    if request.method == 'POST':
        division        = request.POST.getlist('division')
        defaultfilter   = request.POST.get('defaultfilter')
        start           = request.POST.get('startdate')
        end             = request.POST.get('enddate')

    daterange   = [start, end]
    currentdiv  = division
    currentfilter = defaultfilter
    if division == ['All']:
        division = divs

    invoice     = list(InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division,inv__is_ict=False,inv__inv_date__range = daterange).values(currentfilter,'item__product_code','inv__buyer__zone__name').order_by(currentfilter).annotate(basic=Sum('amount'),total_qty=Sum('actual_qty',output_field=IntegerField()),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst')))
    cn          = list(CreditNoteItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division,inv__cn_date__range = daterange).values(currentfilter,'item__product_code','inv__buyer__zone__name').order_by(currentfilter).annotate(basic=-Sum('amount'),total_price=-Sum('igst'),total_qty=Sum(0),mrp=Sum(0)))
    qdn          = list(QdnItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division,inv__qdn_date__range = daterange).values(currentfilter,'item__product_code','inv__buyer__zone__name').order_by(currentfilter).annotate(basic=-Sum('amount'),total_qty=-Sum('free_qty',output_field=IntegerField())-Sum('billed_qty',output_field=IntegerField()),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))
    rso          = list(RsoItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division,inv__rso_date__range = daterange).values(currentfilter,'item__product_code','inv__buyer__zone__name').order_by(currentfilter).annotate(basic=-Sum('amount'),total_qty=-Sum('free_qty',output_field=IntegerField())-Sum('billed_qty',output_field=IntegerField()),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get(currentfilter),df.get('inv__buyer__zone__name')]).agg({'basic':'sum','total_qty':'sum','total_price':'sum','mrp':'sum', 'item__product_code':'first'}).reset_index().to_dict('records')


    rows        = groupby(df, itemgetter(currentfilter))
    data        = {c_title: list(items) for c_title, items in rows}

    zones       = Zone.objects.all()

    context     = {'data' : data, 'zones':zones, 'currentdiv':currentdiv, 'divs':divs, 'currentfilter':currentfilter, 'start':start, 'end':end}

    return render (request, 'reports/sales/zonewisebrandreport.html', context)

@allowed_users(allowed_roles=['Admin', 'Quarterly Sales Performance Report'])
def quarterwisebrandreport(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    defaultfilter = 'item__brand__name'
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        defaultfilter = request.POST.get('defaultfilter')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    currentfilter = defaultfilter
    if division == ['All']:
        division = divs


    start_date = date(int(current_year), 1, 1)
    end_date = date.today()
    invoice     = list(InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division,inv__is_ict=False, inv__inv_date__year=current_year).annotate(quarter=ExtractQuarter('inv__inv_date')).values(currentfilter,'quarter', 'item__product_code').order_by(currentfilter).annotate(basic=Sum('amount',output_field=DecimalField()),total_qty=Sum('actual_qty',output_field=IntegerField()),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst',output_field=DecimalField())))

    cn          = list(CreditNoteItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__cn_date__year=current_year).annotate(quarter=ExtractQuarter('inv__cn_date')).values(currentfilter,'quarter', 'item__product_code').order_by(currentfilter).annotate(basic=-Sum('amount',output_field=DecimalField()),total_qty=-Sum(0),mrp = Sum(0),total_price=-Sum('igst',output_field=DecimalField())))

    qdn         = list(QdnItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__qdn_date__year=current_year).annotate(quarter=ExtractQuarter('inv__qdn_date')).values(currentfilter,'quarter', 'item__product_code').order_by(currentfilter).annotate(basic=-Sum('amount',output_field=DecimalField()),total_qty=-Sum('billed_qty',output_field=IntegerField()) - Sum('free_qty',output_field=IntegerField()),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst',output_field=DecimalField())))

    rso         = list(RsoItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__rso_date__year=current_year).annotate(quarter=ExtractQuarter('inv__rso_date')).values(currentfilter,'quarter', 'item__product_code').order_by(currentfilter).annotate(basic=-Sum('amount',output_field=DecimalField()),total_qty=-Sum('billed_qty',output_field=IntegerField()) - Sum('free_qty',output_field=IntegerField()),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst',output_field=DecimalField())))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get(currentfilter),df.get('quarter')]).agg({'basic':'sum','total_qty':'sum','total_price':'sum','mrp':'sum', 'item__product_code':'first'}).reset_index().to_dict('records')

    rows        = groupby(df, itemgetter(currentfilter))
    data        = {c_title: list(items) for c_title, items in rows}

    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()

    context     = {'data' : data, 'currentdiv':currentdiv, 'divs':divs, 'currentfilter':currentfilter, 'years':years, 'current_year':current_year}

    return render (request, 'reports/sales/quarterwisebrandreport.html', context)

@allowed_users(allowed_roles=['Admin', 'Category Sales Performance Report'])
def brandsales(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    defaultfilter = 'item__brand__name'
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        defaultfilter = request.POST.get('defaultfilter')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    currentfilter = defaultfilter
    if division == ['All']:
        division = divs

    invoice     = list(InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division,inv__is_ict=False, inv__inv_date__year=current_year).annotate(month=TruncMonth('inv__inv_date')).values(currentfilter,'month').order_by(currentfilter).annotate(basic=Sum('amount'),total_qty=Sum('actual_qty'),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst')))

    # rows        = groupby(invoice, itemgetter(defaultfilter))
    # data        = {c_title: list(items) for c_title, items in rows}

    cn          = list(CreditNoteItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__cn_date__year=current_year).annotate(month=TruncMonth('inv__cn_date')).values(currentfilter,'month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_price=-Sum('igst')))
    qdn         = list(QdnItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__qdn_date__year=current_year).annotate(month=TruncMonth('inv__qdn_date')).values(currentfilter,'month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_qty=-Sum('billed_qty') - Sum('free_qty'),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))
    rso         = list(RsoItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__rso_date__year=current_year).annotate(month=TruncMonth('inv__rso_date')).values(currentfilter,'month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_qty=-Sum('billed_qty')- Sum('free_qty'),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get(currentfilter),df.get('month')]).sum(numeric_only=False).reset_index().to_dict('records')


    rows        = groupby(df, itemgetter(currentfilter))
    data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(int(current_year), 1, 1)
    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    context     = {'data' : data, 'months':months, 'currentdiv':currentdiv, 'divs':divs, 'currentfilter':currentfilter, 'years':years, 'current_year':current_year}

    return render (request, 'reports/sales/brandsales.html', context)

@allowed_users(allowed_roles=['Admin', 'Category Sales Performance Report'])
def classsales(request):
    pass
#     try:
#         skey    = (request.session.get('skey').get('company').get('id'))
#     except:
#         return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
#     com         = Company.objects.get(pk=skey)
#     groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

#     division    = ['All']

#     if request.method == 'POST':
#         division    = request.POST.getlist('division')

#     currentdiv  = division
#     if division == ['All']:
#         division = divs

#     invoice     = InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division).annotate(month=TruncMonth('inv__inv_date')).values('item__product_class__name','month').order_by('item__product_class__name').annotate(basic=Sum('amount'),total_qty=Sum('billed_qty'),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst'))

#     rows        = groupby(invoice, itemgetter('item__product_class__name'))
#     data        = {c_title: list(items) for c_title, items in rows}

#     start_date = date(2022, 4, 1)

#     end_date = date.today()

#     months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date))
#     months.reverse()
#     context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs}

#     return render (request, 'reports/sales/classsales.html', context)

@allowed_users(allowed_roles=['Admin', 'Category Sales Performance Report'])
def subclasssales(request):
    pass
#     try:
#         skey    = (request.session.get('skey').get('company').get('id'))
#     except:
#         return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
#     com         = Company.objects.get(pk=skey)
#     groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

#     division    = ['All']

#     if request.method == 'POST':
#         division    = request.POST.getlist('division')

#     currentdiv  = division
#     if division == ['All']:
#         division = divs

#     invoice     = InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division).annotate(month=TruncMonth('inv__inv_date')).values('item__sub_class__name','month').order_by('item__sub_class__name').annotate(basic=Sum('amount'),total_qty=Sum('billed_qty'),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst'))

#     rows        = groupby(invoice, itemgetter('item__sub_class__name'))
#     data        = {c_title: list(items) for c_title, items in rows}

#     start_date = date(2022, 4, 1)

#     end_date = date.today()

#     months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date))
#     months.reverse()
#     context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs}

#     return render (request, 'reports/sales/subclasssales.html', context)

@allowed_users(allowed_roles=['Admin', 'Product Sales Performance Report'])
def productsales(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    if division == ['All']:
        division = divs

    invoice     = list(InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division ,inv__is_ict=False, inv__inv_date__year=current_year).annotate(month=TruncMonth('inv__inv_date')).values('item__product_name','item__product_code','month').order_by('item__product_code').annotate(basic=Sum('amount'),total_qty=Sum('actual_qty'),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst')))
    cn          = list(CreditNoteItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__cn_date__year=current_year).annotate(month=TruncMonth('inv__cn_date')).values('item__product_name','item__product_code','month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_price=-Sum('igst')))
    qdn         = list(QdnItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__qdn_date__year=current_year).annotate(month=TruncMonth('inv__qdn_date')).values('item__product_name','item__product_code','month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_qty=-Sum('billed_qty') - Sum('free_qty'),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))
    rso         = list(RsoItems.objects.filter(inv__company=com, inv__status__in=['1','3'],inv__division__in = division, inv__rso_date__year=current_year).annotate(month=TruncMonth('inv__rso_date')).values('item__product_name','item__product_code','month').order_by('item__product_code').annotate(basic=-Sum('amount'),total_qty=-Sum('billed_qty')- Sum('free_qty'),mrp = -Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=-Sum('igst')))

    finals = invoice + cn + qdn + rso
    df = pd.DataFrame(finals)
    df = df.groupby([df.get('item__product_code'),df.get('month')]).sum(numeric_only=False).reset_index().to_dict('records')


    rows        = groupby(df, itemgetter('item__product_code'))
    data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(int(current_year), 1, 1)
    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs, 'years':years, 'current_year':current_year}

    return render (request, 'reports/sales/productsales.html', context)


# def paymentreceivable(request):
#     context = {}
#     return render (request, 'reports/sales/paymentreceivable.html', context)

# def paymentPayable(request):
#     context = {}
#     return render (request, 'reports/accounting/paymentPayable.html', context)


######################################################################################################


def invdata(request):
    start       = request.GET.get('from','a')
    end         = request.GET.get('to','a')

    if len(start) < 10:
        start   = datetime(2022, 4, 1)
    else:
        start   = datetime.strptime(start,'%Y-%m-%d')
    if len(end) < 10:
        end     = datetime.today()
    else:
        end     = datetime.strptime(end,'%Y-%m-%d')

    daterange   = [start, end]
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)
    com = Company.objects.get(pk=skey)

    queryset = list(InvItems.objects.filter(inv__company=com,inv__division__in = divs,inv__status__in=['1','3','4'] ,inv__inv_date__range = daterange).values("inv__division","inv__buyer__name","inv__buyer__vendor_code","inv__buyer__zone__name","inv__buyer__region__name","inv__buyer_state","inv__buyer_city","inv__buyer__zsm__name","inv__buyer__rsm__name","inv__buyer__asm__name","inv__buyer__se__name",
        "inv__channel","item__brand__name","item__sub_brand__name","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__product_name","item__inner_qty","item__outer_qty","inv__dn__sales_order__so_no","inv__order_no",
        "inv__dn__sales_order__so_date","inv__dn__dn_no","inv__dn__dn_date","inv__inv_no","inv__inv_date","billed_qty","free_qty","actual_qty","rate","discount","inv__discount","mrp","offer_mrp","amount","igstrate","igst","item__hsn","inv__company__name"))

    cn  = list(CreditNoteItems.objects.filter(inv__company=com,inv__division__in = divs,inv__status__in=['1','3','4'], inv__cn_date__range = daterange,amount__gt=0).values("inv__division","inv__buyer__name","inv__buyer__vendor_code","inv__buyer__zone__name","inv__buyer__region__name","inv__buyer_state","inv__buyer_city","inv__buyer__zsm__name","inv__buyer__rsm__name","inv__buyer__asm__name","inv__buyer__se__name",
        "inv__channel","inv__cn_no","inv__inv__inv_no","inv__cn_date","inv__channel","inv__discount","item__brand__name","item__sub_brand__name","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__hsn","item__product_name","item__inner_qty","item__outer_qty", "mrp","rate","discount","amount","igst","igstrate","inv__company__name"))

    qdn = list(QdnItems.objects.filter(inv__company=com,inv__division__in = divs,inv__status__in=['1','3','4'], inv__qdn_date__range = daterange,amount__gt=0).values("inv__division","inv__buyer__name","inv__buyer__vendor_code","inv__buyer__zone__name","inv__buyer__region__name","inv__buyer_state","inv__buyer_city","inv__buyer__zsm__name","inv__buyer__rsm__name","inv__buyer__asm__name","inv__buyer__se__name",
        "inv__qdn_no","inv__inv__inv_no","inv__qdn_date",'inv__channel',"item__brand__name","item__sub_brand__name","inv__discount","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__product_name","item__inner_qty","item__hsn","item__outer_qty","rate", "mrp","billed_qty","free_qty","discount","amount","igst","igstrate","inv__company__name"))

    rso = list(RsoItems.objects.filter((Q(free_qty__gt=0,inv__division__in = divs,inv__company=com,inv__status__in=['1','3','4'], inv__rso_date__range = daterange) | Q(billed_qty__gt=0,inv__division__in = divs,inv__company=com,inv__status__in=['1','3'], inv__rso_date__range = daterange))).values("inv__division","inv__buyer__name","inv__buyer__vendor_code","inv__buyer__zone__name","inv__buyer__region__name","inv__buyer_state","inv__buyer_city","inv__buyer__zsm__name","inv__buyer__rsm__name","inv__buyer__asm__name","inv__buyer__se__name",
        "inv__channel","inv__rso_no","inv__inv__inv_no","inv__rso_date","item__brand__name","item__sub_brand__name","inv__discount","item__category__name","item__product_class__name","item__sub_class__name","item__article_code","item__ean_code","item__product_code","item__product_name","item__inner_qty","item__hsn","item__outer_qty","rate", "mrp","billed_qty","free_qty","discount","amount","igst","igstrate","inv__company__name"))

    queryset.extend(cn)
    queryset.extend(qdn)
    queryset.extend(rso)

    for i in queryset:
        i['mrpvalue'] = round((Decimal(i['mrp']) * Decimal(i.get('billed_qty') or 0)),2)
        i['omrpvalue'] = round((Decimal(i.get('offer_mrp') or 0) * Decimal(i.get('billed_qty') or 0 )),2)
        i['total'] = round((Decimal(i['igst']) + Decimal(i['amount'])),2)
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Sales Invoice Report'])
def inv(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/sales_report.html')

@allowed_users(allowed_roles=['Admin', 'Count of Item Sold Report'])
def itemsoldcount(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']
    start_date  = date.today()
    current_year = start_date.year

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        current_year = request.POST.get('year')
        start_date  = date(int(current_year), 1, 1)

    currentdiv  = division
    if division == ['All']:
        division = divs

    invoice     = InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__division__in = division ,inv__is_ict=False, inv__inv_date__year=current_year).annotate(month=TruncMonth('inv__inv_date')).values('item__product_name','item__product_code','month').order_by('item__product_code').annotate(total_count=Count('item'))
    rows        = groupby(invoice, itemgetter('item__product_code'))
    data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(int(current_year), 1, 1)
    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date, count=12))
    months.reverse()
    years = list(rrule.rrule(rrule.YEARLY, dtstart=date(2019, 1, 1), until=end_date))
    years.reverse()
    context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs, 'years':years, 'current_year':current_year}

    return render (request, 'reports/sales/countitemsold.html', context)

@allowed_users(allowed_roles=['Admin', 'Product vs Party Sales Report'])
def productvspartysales(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['IB']
    start       = str(date.today())
    end         = str(date.today())

    if request.method == 'POST':
        division    = request.POST.getlist('division')
        start       = request.POST.get('startdate')
        end         = request.POST.get('enddate')

    daterange   = [start, end]
    currentdiv  = division
    # if division == ['All']:
    #     division = divs

    invoice     = InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__is_ict=False,inv__division__in = division, inv__inv_date__range = daterange).values('item__product_code','item__product_name','inv__buyer__name').order_by('item__product_code').annotate(basic=Sum('amount'),total_qty=Sum('actual_qty'),mrp = Sum(F('mrp') * F('billed_qty'),output_field=IntegerField()),total_price=Sum('igst'),brand = F('item__brand__name'))
    rows        = groupby(invoice, itemgetter('item__product_code'))
    data        = {c_title: list(items) for c_title, items in rows}

    parties     = Invoice.objects.filter(company=com, status__in=['1','3','4'],is_ict=False,division__in = division, inv_date__range = daterange).order_by('buyer__name').values_list('buyer__name', flat=True).order_by('buyer__name')
    context     = {'data' : data, 'parties':parties,'currentdiv':currentdiv, 'divs':divs, 'start':start, 'end':end}

    return render (request, 'reports/sales/productvsparty.html', context)


@allowed_users(allowed_roles=['Admin', 'Score Card Report'])
def scorecard(request):
    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(pk=skey)
    groups      = request.user.groups.values_list('name',flat=True)
    divs        = Division.objects.filter(name__in = groups).values_list('name', flat=True)

    division    = ['All']

    if request.method == 'POST':
        division    = request.POST.getlist('division')

    currentdiv  = division
    if division == ['All']:
        division = divs

    invoice     = InvItems.objects.filter(inv__company=com, inv__status__in=['1','3','4'],inv__is_ict=False,inv__division__in = division).annotate(month=TruncMonth('inv__inv_date')).values('item__brand__name', 'item__product_name','item__product_code','inv__buyer__name','billed_qty').order_by('item__product_code').annotate(total_count=Count('item'))
    rows        = groupby(invoice, itemgetter('item__product_code'))
    data        = {c_title: list(items) for c_title, items in rows}

    start_date = date(2022, 4, 1)

    end_date = date.today()

    months = list(rrule.rrule(rrule.MONTHLY, dtstart=start_date, until=end_date))
    months.reverse()
    context     = {'data' : data, 'months':months,'currentdiv':currentdiv, 'divs':divs}

    return render (request, 'reports/sales/scorecard.html', context)

def paymentPayabledata(request):
    mainxml = '''<ENVELOPE>
                    <HEADER>
                        <VERSION>1</VERSION>
                        <TALLYREQUEST>EXPORT</TALLYREQUEST>
                        <TYPE>Collection</TYPE>
                        <ID>CMPRecevables</ID>
                    </HEADER>
                    <BODY>
                        <DESC>
                            <STATICVARIABLES>
                                    <SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY>
                                    <SVEXPORTFORMAT>$$SysName:xml</SVEXPORTFORMAT>
                            </STATICVARIABLES>
                            <TDL>
                                <TDLMESSAGE>
                                    <COLLECTION NAME="CMPRecevables" ISMODIFY="No" ISFIXED="No" ISINITIALIZE="No" ISOPTION="No" ISINTERNAL="No">
                                        <Type>Bills</Type>
                                        <Filters>IsPayable</Filters>
                                        <NativeMethod>Parent</NativeMethod>
                                    </COLLECTION>
                                </TDLMESSAGE>
                            </TDL>
                        </DESC>
                    </BODY>
                </ENVELOPE>'''
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    payload = mainxml.replace('Company_name',com.tally_name)
    req = requests.post(url=com.ipaddress, data=payload)
    response = req.text.replace('&#4;', 'NA')
    data_dict = xmltodict.parse(response, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))
    if jsondata["ENVELOPE"]==None:
        return HttpResponse("No Sales Order in found for selected Date")
    data = jsondata["ENVELOPE"]["BODY"]["DATA"]["COLLECTION"]['BILL']
    report = []
    print(data)
    for i in data[0:10]:
        inv_no=(i['NAME']['#text'])
        party=(i['PARENT']['#text']).upper()
        amount=(i['CLOSINGBALANCE']['#text'])
        credit_days=(i['BILLCREDITPERIOD']['#text'])
        party = Party_master.objects.filter(name=party)
        if party:
            names = {}
            names['division'] = party[0].devision.name
            names['channel'] = party[0].party_type.name
            names['zone'] = party[0].zone.name
            names['region'] = party[0].region.name
            names['state'] = party[0].state.name
            names['city'] = party[0].city.name
            names['zsm'] = party[0].zsm.name
            names['rsm'] = party[0].rsm.name
            names['asm'] = party[0].asm.name
            names['se'] = party[0].se.name
            names['code'] = party[0].vendor_code
            names['name'] = party[0].name
            names['party_margin'] = party[0].price_level
            names['inv_no'] = inv_no
            names['date'] = credit_days
            names['credit_days'] = credit_days
            names['amount'] = amount
            names['received_amt'] = credit_days
            names['outstanding'] = credit_days
            names['overdue'] = credit_days
            report.append(names)

    return JsonResponse({'data':report})

@allowed_users(allowed_roles=['Admin', 'Payment Payable Report'])
def paymentPayable(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/paymentPayable.html')

def paymentreceivabledata(request):
    mainxml = '''<ENVELOPE>
                    <HEADER>
                        <VERSION>1</VERSION>
                        <TALLYREQUEST>EXPORT</TALLYREQUEST>
                        <TYPE>Collection</TYPE>
                        <ID>CMPRecevables</ID>
                    </HEADER>
                    <BODY>
                        <DESC>
                            <STATICVARIABLES>
                                    <SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY>
                                    <SVEXPORTFORMAT>$$SysName:xml</SVEXPORTFORMAT>
                            </STATICVARIABLES>
                            <TDL>
                                <TDLMESSAGE>
                                    <COLLECTION NAME="CMPRecevables" ISMODIFY="No" ISFIXED="No" ISINITIALIZE="No" ISOPTION="No" ISINTERNAL="No">
                                        <Type>Bills</Type>
                                        <Filters>IsReceivable</Filters>
                                        <NativeMethod>Parent</NativeMethod>
                                    </COLLECTION>
                                </TDLMESSAGE>
                            </TDL>
                        </DESC>
                    </BODY>
                </ENVELOPE>'''
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    payload = mainxml.replace('Company_name',com.tally_name)
    req = requests.post(url=com.ipaddress, data=payload)
    response = req.text.replace('&#4;', 'NA')
    data_dict = xmltodict.parse(response, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))
    if jsondata["ENVELOPE"]==None:
        return HttpResponse("No Sales Order in found for selected Date")
    data = jsondata["ENVELOPE"]["BODY"]["DATA"]["COLLECTION"]['BILL']
    report = []
    print(data[0:10])
    for i in data[0:10]:
        inv_no=(i['NAME']['#text'])
        party=(i['PARENT']['#text']).upper()
        amount=(i['CLOSINGBALANCE']['#text'])
        inv_date=(i['BILLDATE']['#text'])
        credit_days=(i['BILLCREDITPERIOD']['#text'])
        received_amt=(i['BASECLOSING']['#text'])
        outstanding=(i['FINALBALANCE']['#text'])
        overdue=(i['OPENINGBALANCE']['#text'])
        party = Party_master.objects.filter(name=party)
        if party:
            names = {}
            names['division'] = party[0].devision.name
            names['channel'] = party[0].party_type.name
            names['zone'] = party[0].zone.name
            names['region'] = party[0].region.name
            names['state'] = party[0].state.name
            names['city'] = party[0].city.name
            names['zsm'] = party[0].zsm.name
            names['rsm'] = party[0].rsm.name
            names['asm'] = party[0].asm.name
            names['se'] = party[0].se.name
            names['code'] = party[0].vendor_code
            names['name'] = party[0].name
            names['party_margin'] = credit_days
            names['inv_no'] = inv_no
            names['date'] = inv_date
            names['credit_days'] = credit_days
            names['amount'] = amount
            names['received_amt'] = received_amt
            names['outstanding'] = outstanding
            names['overdue'] = overdue
            report.append(names)

    return JsonResponse({'data':report})


@allowed_users(allowed_roles=['Admin', 'Payment Receivable Report'])
def paymentreceivable(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    return render (request, 'reports/accounting/paymentReceivable.html')


def palletdata(request):
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    queryset = list(PalletTransferEntry.objects.filter(company=com).values("created","item__product_code","item__product_name","qty","fgodown","tgodown","createdby"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Pallet Transfer Report'])
def pallet(request):

    return render(request, 'reports/inventory/pallet_report.html')


def shortagedata(request):
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    queryset = list(ShortageDamageEntry.objects.filter(company=com).values("createdby","purchase__pi_no","jobwork__no","created","item__product_code","item__product_name","sqty","sremarks","dqty","dremarks"))
    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Shortage-Damage Report'])
def shortage(request):

    return render(request, 'reports/inventory/shortage_report.html')

def prdtrackdata(request):
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    queryset = list(JobOrder.objects.filter(company=com).values("created","id","product__product_code","product__product_name","qty","no","issuedby").order_by('no'))

    for i in queryset[:]:
        jc=JobCard.objects.filter(joborder=i['id']).order_by('no')
        if len(jc) > 0:
            i['jobcard'] = jc[0].no
            i['jobcard_qty'] = jc[0].qty

        if len(jc) > 1:
            for j in jc[1:]:
                k = i.copy()
                k['jobcard'] = j.no
                k['jobcard_qty'] = j.qty
                queryset.append(k)

    for i in queryset[:]:
        if i.get('jobcard'):
            jc=RMIndent.objects.filter(jobcard__no=i['jobcard'])
            if len(jc) > 0:
                i['rmindent'] = jc[0].no
                if jc[0].status == '3':
                    i['mt'] = 'YES'
            if len(jc) > 1:
                for j in jc[1:]:
                    k = i.copy()
                    k['rmindent'] = j.no
                    if j.status == '3':
                        k['mt'] = "YES"
                    queryset.append(k)


    for i in queryset[:]:
        if i.get('jobcard'):
            jc=Consumption.objects.filter(jobcard__no=i['jobcard'])
            if len(jc) > 0:
                i['prd'] = jc[0].no
                i['prd_qty'] = jc[0].qty
            if len(jc) > 1:
                for j in jc[1:]:
                    k = i.copy()
                    k['prd'] = j.no
                    k['prd_qty'] = j.qty
                    queryset.append(k)

    return JsonResponse({'data':queryset})

@allowed_users(allowed_roles=['Admin', 'Production Tracker Report'])
def prdtrack(request):

    return render(request, 'reports/production/prdtrack.html')


def rmindentdata(request):
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    queryset = list(RMItemGodown.objects.filter(rmitem__rmindent__company=com).values('rmitem__rmindent__jobcard__no','rmitem__rmindent__jobcard__product__product_code','rmitem__item__product_code','godown','qty'))

    return JsonResponse({'data':queryset})


@allowed_users(allowed_roles=['Admin', 'RM Indent Report'])
def rmindent(request):

    return render(request, 'reports/production/rmindent.html')

def prddata(request):

    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    queryset = list(ConsumptionItems.objects.filter(consumption__company=com).values('consumption__no','consumption__jobcard__no','consumption__jobcard__product__product_code','consumption__qty','consumption__date','item__product_code','qty'))

    return JsonResponse({'data':queryset})


@allowed_users(allowed_roles=['Admin', 'Production Report'])
def prd(request):

    return render(request, 'reports/production/prd.html')