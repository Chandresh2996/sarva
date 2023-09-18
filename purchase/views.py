from decimal import Decimal
from django.views.generic import ListView
from django.db.models import Sum
from django.shortcuts import render, redirect
from django.http import HttpResponse
import datetime
import math
from django.db.models import Q
import requests
from accounts.mail import send_email
from company.models import Company
from inventory.models import Godown, Gst_list, Product_master, Std_rate, Currency
from ledgers.models import LedgersType, Party_contact_details, Party_master, Price_level, Price_list
from purchase.models import DebitNote, DebitNoteItems, Grn, PiItems, PoItems, Purchase, Purchase_order, PurchaseReturn, PurchaseReturnItems, Qdn, QdnItems, grnItems
from purchase.xmlcreator import debitxml, prxml, purchasexml, qdnxml
from sales.models import Rso, RsoItems
from warehouse.models import Stock_summary
from django.utils.decorators import method_decorator
from core.decorators import auth_users, allowed_users, is_company
from tablib import Dataset
from django.contrib import messages

def purchases(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    context = {}
    context['po']       = Purchase_order.objects.filter(company=com).count()
    context['purchase'] = Purchase.objects.filter(company=com).count()
    context['qdn']      = Qdn.objects.filter(company=com).count()
    context['db']       = DebitNote.objects.filter(company=com).count()
    context['pr']       = PurchaseReturn.objects.filter(company=com).count()
    context['sr']       = Std_rate.objects.count()

    return render(request, 'purchase/purchases.html',context)

@method_decorator(allowed_users(allowed_roles=['Admin', 'Standard Cost View', 'Standard Cost Create', 'Standard Cost Update', 'Standard Cost Delete']), name='dispatch')
class StandardRate(ListView):
    model = Std_rate
    template_name = 'purchase/list_sr.html'
    context_object_name = 'items'
    paginate_by = 10

    def get_queryset(self):
        # import pdb; pdb.set_trace()
        query       = self.request.GET.get('q', None)
        qs          = Std_rate.objects.all().order_by("product")
        if query is not None:
            qs=qs.filter(
                Q(product__product_code__icontains=query)
            )
        return qs

@allowed_users(allowed_roles=['Admin', 'Standard Cost Create', 'Standard Cost Update', 'Standard Cost Delete'])
def addsr(request):
    if request.method == 'POST':

        product = Product_master.objects.get(product_code=request.POST.get('name'))
        uom     = str(product.units_of_measure)
        Std_rate.objects.update_or_create(product=product, rate_type = '1', defaults={'applicable_from' : datetime.date.today(), 'uom': uom, 'rate' : request.POST.get('group_code')})
        messages.success(request, "Standard Rate Added Successfully")
        return redirect('purchase:stdrate')

    context = {}
    context['skucode']       = Product_master.objects.all()
    return render(request, 'purchase/add_sr.html',context)

@allowed_users(allowed_roles=['Admin',  'Standard Cost Update', 'Standard Cost Delete'])
def editsr(request, pk):

    Std_rate.objects.get(id=pk)


    if request.method == 'POST':

        product = Product_master.objects.get(product_code=request.POST.get('name'))
        uom     = str(product.units_of_measure)
        Std_rate.objects.update_or_create(product=product, rate_type = '1', defaults={'applicable_from' : datetime.date.today(), 'uom': uom, 'rate' : request.POST.get('group_code')})
        messages.success(request, "Standard Rate Updated Successfully")
        return redirect('purchase:stdrate')

    context = {}
    context['skucode']       = Product_master.objects.all()
    return render(request, 'purchase/add_sr.html',context)


@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Purchase Order View', 'Purchase Order Create', 'Purchase Order Update', 'Purchase Order Delete']), name='dispatch')
class PurchaseOrder(ListView):
    model = Purchase_order
    template_name = 'purchase/list_po.html'
    context_object_name = 'pos'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Purchase_order.objects.filter(company=self.request.META['com']).order_by('-po_no')
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(po_no__icontains=query) )
        return qs


# def po(request):
#     po = Purchase_order.objects.filter(company=com).order_by('-created')
#     company = Company.objects.all()
#     context = {'pos': po, 'company': company}

#     return render(request, 'purchase/list_po.html', context)

@allowed_users(allowed_roles=['Admin', 'Purchase Order View', 'Purchase Order Create', 'Purchase Order Update', 'Purchase Order Delete'])
def addpo(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    series = com.po_series
    po = Purchase_order.objects.filter(company=com, po_no__contains=series).order_by('po_no').last()
    if po:
        ponum = int(po.po_no[len(series):]) + 1
        ponumber = series + (str(ponum)).zfill(5)
    else:
        ponumber = series + '00001'

    if request.method == 'POST':

        party_name = request.POST.get("party_name")

        if request.POST.get("po_due_date"):
            po_due_date = request.POST.get("po_due_date")
        else:
            po_due_date = None

        mode_of_payment             = request.POST.get("mode_of_payment")
        other_reference             = request.POST.get("other_reference")
        terms_of_delivery           = request.POST.get("terms_of_delivery")

        party_address_type          = request.POST.get("party_address_type")
        dispatch_through            = request.POST.get("dispatch_through")
        destintaion                 = request.POST.get("destintaion")

        product_codelist            = request.POST.getlist('product_code')
        actualqtylist               = request.POST.getlist('aqty')
        ratelist                    = request.POST.getlist("rate")
        narration                   = request.POST.get("narration")
        ol_rate                     = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = 0
        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger        = LedgersType.objects.get(id=other_ledger)
            po.other_ledger     = other_ledger
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        po = Purchase_order()
        po.company = com
        party = Party_master.objects.get(group__name="Sundry Creditors",name=party_name)
        if party_address_type:
            party_add = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            po.seller_address_type = party_add.address_type
        else:
            party_add = party
            po.seller_address_type = "Default"

        po.po_no = ponumber
        po.po_due_date = po_due_date

        po.seller                   = party
        po.seller_mailingname       = party_add.mailing_name
        po.seller_address1          = party_add.addressline1
        po.seller_address2          = party_add.addressline2
        po.seller_address3          = party_add.addressline3
        po.seller_city              = str(party_add.city)
        po.seller_state             = str(party_add.state)
        po.seller_country           = str(party_add.country)
        po.seller_pincode           = party_add.pin_code
        po.seller_gst_reg_type      = party_add.gst_registration_type
        po.seller_gstin             = party_add.gstin

        po.shipto                   = com
        po.shipto_address_type      = com.dis_addtype
        po.shipto_mailingname       = com.dis_name
        po.shipto_address1          = com.dis_add1
        po.shipto_address2          = com.dis_add2
        po.shipto_address3          = com.dis_add3
        po.shipto_city              = com.dis_city
        po.shipto_state             = com.dis_state
        po.shipto_country           = com.dis_country
        po.shipto_pincode           = com.dis_pincode
        po.shipto_gstin             = com.dis_gstin

        po.mode_of_payment          = mode_of_payment
        po.destintaion              = destintaion
        po.dispatch_through         = dispatch_through
        po.other_reference          = other_reference
        po.terms_of_delivery        = terms_of_delivery
        po.narration                = narration

        po.currency                 = request.POST.get('currency')
        po.ol_rate                  = ol_rate
        po.ammount                  = 0
        po.cgst                     = 0
        po.sgst                     = 0
        po.igst                     = 0
        po.other                    = 0
        po.tcs                      = 0
        po.round_off                = 0
        po.total                    = 0

        po.save()

        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0

        try:
            for i,j in enumerate(product_codelist):
                actualqty           = Decimal(actualqtylist[i])
                rate                = Decimal(ratelist[i])
                product             = Product_master.objects.get(product_code=str(j).upper())
                pack                = product.outer_qty

                ammount             = round((actualqty * rate),2)
                if po.currency != 'INR':
                    igstrate = Decimal(0)
                else:
                    igstrate        = product.gst
                cgstrate            = igstrate/2
                sgstrate            = igstrate/2
                igst                = round((ammount * (igstrate / 100)),2)
                cgst                = round((ammount * (cgstrate / 100)),2)
                sgst                = round((ammount * (sgstrate / 100)),2)

                totalammount        = totalammount + ammount
                totalcgst           = totalcgst + cgst
                totalsgst           = totalsgst + sgst
                totaligst           = totaligst + igst

                PoItems.objects.create(po=po, item=product, product_code=j, pack=pack,
                                    igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                    actual_qty=(actualqty), basic_qty=actualqty, rate=(rate), amount=(ammount))


        except BaseException as exception:
            print(exception)
            PoItems.objects.filter(po=po).delete()
            po.delete()
            return redirect('purchase:po')

        po.ammount                  = totalammount
        if po.currency != 'INR':
            po.cgst                 = 0
            po.sgst                 = 0
            po.igst                 = 0
        else:
            po.cgst                 = round((totalcgst + (other * ol_rate /200)),2)
            po.sgst                 = round((totalsgst + (other * ol_rate /200)),2)
            po.igst                 = round((totaligst + (other * ol_rate /100)),2)
        po.tcs                      = round(totaltcs,2)
        po.other                    = other
        total                       = totalammount + po.igst + totaltcs + other
        po.total                    = round(total)
        po.round_off                = po.total - total
        po.save()
        messages.success(request, "Purchase Oder: {} Created Successfully".format(ponumber))
        return redirect('purchase:po')

    parties             = Party_master.objects.filter(group__name="Sundry Creditors").order_by('name')
    items               = Product_master.objects.all()
    ledgers             = LedgersType.objects.filter(Q(under = 5))
    company             = Company.objects.all()
    currency            = Currency.objects.all()
    context             = {'parties': parties, 'items': items, 'ponumber': ponumber, 'company': company, 'ledgers':ledgers, 'currency': currency}

    return render(request, 'purchase/add_po.html', context)

@allowed_users(allowed_roles=['Admin', 'Purchase Order Update', 'Purchase Order Delete'])
def poedit(request, pk):

    if request.method == 'POST':

        po = Purchase_order.objects.get(pk=pk)

        po.narration            = request.POST.get("narration")
        po.mode_of_payment      = request.POST.get("mode_of_payment")
        po.other_reference      = request.POST.get("other_reference")
        po.terms_of_delivery    = request.POST.get("terms_of_delivery")
        po.party_address_type   = request.POST.get("party_address_type")
        po.dispatch_through     = request.POST.get("dispatch_through")
        po.destintaion          = request.POST.get("destintaion")
        ol_rate                 = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = Decimal(0)
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger        = LedgersType.objects.get(id=other_ledger)
            po.other_ledger     = other_ledger

        actualqtylist           = request.POST.getlist('aqty')
        product_codelist        = request.POST.getlist('product_code')
        ratelist                = request.POST.getlist("rate")

        po.currency             = request.POST.get('currency')
        po.ol_rate              = ol_rate
        po.ammount              = 0
        po.cgst                 = 0
        po.sgst                 = 0
        po.igst                 = 0
        po.tcs                  = 0
        po.other                = 0
        po.round_off            = 0
        po.total                = 0

        po.save()

        totalammount            = 0
        totalcgst               = 0
        totalsgst               = 0
        totaligst               = 0

        try:
            items=PoItems.objects.filter(po=po).delete()
            for i,j in enumerate(product_codelist):
                product_code    = j

                actualqty       = Decimal(actualqtylist[i])
                rate            = Decimal(ratelist[i])

                product         = Product_master.objects.get(product_code=str(j).upper())
                pack            = product.outer_qty
                if po.currency != 'INR':
                    igstrate = Decimal(0)
                else:
                    igstrate    = product.gst

                ammount         = round((actualqty * rate),2)
                cgstrate        = igstrate/2
                sgstrate        = igstrate/2

                igst            = round((ammount * (igstrate / 100)),2)
                cgst            = round((ammount * (cgstrate / 100)),2)
                sgst            = round((ammount * (sgstrate / 100)),2)


                totalammount    = totalammount + ammount
                totalcgst       = totalcgst + cgst
                totalsgst       = totalsgst + sgst
                totaligst       = totaligst + igst

                PoItems.objects.create(po=po, item=product, product_code=product_code,pack=pack,
                                    igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                    actual_qty=(actualqty),basic_qty=actualqty , rate=(rate), amount=(ammount))


        except BaseException as exception:
            print(exception)

        po.ammount              = totalammount
        if po.currency != 'INR':
            po.cgst             = 0
            po.sgst             = 0
            po.igst             = 0
        else:
            po.cgst             = round((totalcgst + (other * ol_rate /200)),2)
            po.sgst             = round((totalsgst + (other * ol_rate /200)),2)
            po.igst             = round((totaligst + (other * ol_rate /100)),2)
        po.tcs                  = totaltcs
        po.other                = other
        total                   = totalammount + po.igst + totaltcs + other
        po.total                = round(total)
        po.round_off            = Decimal(po.total - total)
        po.save()
        messages.success(request, "Purchase Oder: {} Updated Successfully".format(po))

        return redirect('purchase:po')

    ledgers         = LedgersType.objects.filter(under__name = 'Direct Expense')
    po              = Purchase_order.objects.get(pk=pk)
    items           = list(PoItems.objects.filter(po=po).values('product_code','item__product_name','item__product_type__name','item__mrp','amount','item__units_of_measure__symbol','pack','actual_qty','rate','igstrate','sgstrate','cgstrate','igst','cgst','sgst'))
    products        = Product_master.objects.all()
    parties         = Party_master.objects.filter(group__name="Sundry Creditors")
    currency         = Currency.objects.all()
    for i in items:
        if i['item__product_type__name'] == 'Finished Goods':
            st=Std_rate.objects.get(product__product_code=i['product_code'], rate_type='1')
            i['stdrate'] = st.rate
    return render(request, 'purchase/edit_po.html', {'pk': pk, 'po': po, 'items': items,'parties':parties ,'ledgers':ledgers,'products':products, 'currency': currency})

@allowed_users(allowed_roles=['Admin', 'Purchase Order Amend', 'Purchase Order Delete'])
def poamend(request, pk):

    if request.method == 'POST':

        po = Purchase_order.objects.get(pk=pk)

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = Decimal(0)
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger        = LedgersType.objects.get(id=other_ledger)
            po.other_ledger     = other_ledger
        ol_rate                 = Decimal(request.POST.get("ol_rate"))

        actualqtylist           = request.POST.getlist('aqty')
        product_codelist        = request.POST.getlist('product_code')

        totalammount    = 0
        totalcgst       = 0
        totalsgst       = 0
        totaligst       = 0

        try:
            for i,j in enumerate(product_codelist):

                product         = Product_master.objects.get(product_code=j)
                amendqty        = Decimal(actualqtylist[i])
                item            = PoItems.objects.get(po=po,item=product)
                item.amend_qty  += amendqty
                item.actual_qty += amendqty
                item.amount     += round((amendqty * item.rate),2)
                item.igst       = round((item.amount * (item.igstrate / 100)),2)
                item.cgst       = round((item.amount * (item.cgstrate / 100)),2)
                item.sgst       = round((item.amount * (item.sgstrate / 100)),2)
                item.save()

                totalammount    = totalammount + item.amount
                totalcgst       = totalcgst + item.cgst
                totalsgst       = totalsgst + item.sgst
                totaligst       = totaligst + item.igst

        except BaseException as exception:
            print(exception)

        po.ammount      = totalammount
        po.cgst         = round((totalcgst + (other * ol_rate / 200)),2)
        po.sgst         = round((totalsgst + (other * ol_rate / 200)),2)
        po.igst         = round((totaligst + (other * ol_rate / 100)),2)
        po.tcs          = totaltcs
        po.other        = other
        total           = totalammount + po.igst + totaltcs + other
        po.total        = round(total)
        po.round_off    = Decimal(po.total - total)
        po.save()
        messages.success(request, "Purchase Oder Ammended Successfully")

        return redirect('purchase:po')
    ledgers = LedgersType.objects.filter(Q(under = 5) | Q (under = 6))
    po = Purchase_order.objects.get(pk=pk)
    items = PoItems.objects.filter(po=po)
    products = Product_master.objects.all()
    company = Company.objects.all()
    return render(request, 'purchase/amend_po.html', {'pk': pk, 'po': po, 'items': items, 'company': company,'ledgers':ledgers,'products':products})

@allowed_users(allowed_roles=['Admin', 'Purchase Order View', 'Purchase Order Create', 'Purchase Order Update', 'Purchase Order Delete'])
def poshow(request, pk):

    po = Purchase_order.objects.get(pk=pk)
    items = PoItems.objects.filter(po=po)
    company = Company.objects.all()
    return render(request, 'purchase/show_po.html', {'pk': pk, 'po': po, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'Purchase Order Delete'])
def pocancel(request, pk):

    po = Purchase_order.objects.get(pk=pk)
    po.status = "2"
    po.save()
    return HttpResponse("PO Cancelled")


from datetime import date
from num2words import num2words
from wkhtmltopdf.views import PDFTemplateResponse

def popdf(request, pk):

    template = 'purchase/pdf_po.html'
    po = Purchase_order.objects.get(pk=pk)
    poitems = PoItems.objects.filter(po=po)
    total = num2words(po.total , to="currency",currency=po.currency, lang="en_IN")
    print(total)
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '10',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'encoding': "UTF-8",
        'no-outline': None,
        'footer_right': 'Page [page] of [toPage]',
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': True}

    com = Company.objects.get(pk=1)
    context = {'po':po,'poitems': poitems, 'company': com,'total':total ,'date': date.today()}
    # return render(request, template, context)
    return PDFTemplateResponse(request=request, context=context, template=template, filename=str(po.seller)+'-'+str(po.po_no)+'.pdf', cmd_options=cmd_options)

@allowed_users(allowed_roles=['Admin', 'Purchase Order Email'])
def mailpo(request, pk):

    po = Purchase_order.objects.get(pk=pk)
    attachname = str(po.po_no)+'.pdf'
    attach = popdf(request, pk)
    email = po.seller.email_id
    email_cc = po.seller.cc_email
    send_email(request,email,email_cc,"PURCHASE ORDER",attach, attachname)

def dnpdf(request, pk):

    template = 'purchase/pdf_dn.html'
    po = DebitNote.objects.get(pk=pk)
    poitems = DebitNoteItems.objects.filter(debitNote=po, rate_diff__gt=0)
    total = num2words(po.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '10',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'encoding': "UTF-8",
        'no-outline': None,
        'footer_right': 'Page [page] of [toPage]',
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': True}

    com = Company.objects.get(pk=1)
    context = {'po':po,'poitems': poitems, 'company': com,'total':total ,'date': date.today()}
    # return render(request, template, context)
    return render(request, 'purchase/pdf_dn.html', context)
    # return PDFTemplateResponse(request=request, context=context, template=template, filename=str(po.db_no)+'.pdf', cmd_options=cmd_options)

@allowed_users(allowed_roles=['Admin', 'Debit Note Email'])
def maildn(request, pk):

    po = DebitNote.objects.get(pk=pk)
    attachname = str(po.db_no)+'.pdf'
    attach = dnpdf(request, pk)
    email = po.seller.email_id
    email_cc = po.seller.cc_email
    send_email(request,email,email_cc,"DEBITNOTE",attach, attachname)

def prpdf(request, pk):

    template = 'purchase/pdf_pr.html'
    po = PurchaseReturn.objects.get(pk=pk)
    poitems = PurchaseReturnItems.objects.filter(pr=po,return_qty__gt=0)
    total = num2words(po.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '10',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'encoding': "UTF-8",
        'no-outline': None,
        'footer_right': 'Page [page] of [toPage]',
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': True}

    com = Company.objects.get(pk=1)
    context = {'po':po,'poitems': poitems, 'company': com,'total':total ,'date': date.today()}
    # return render(request, template, context)
    return render(request, 'purchase/pdf_pr.html', context)
    # return PDFTemplateResponse(request=request, context=context, template=template, filename=str(po.pr_no)+'.pdf', cmd_options=cmd_options)

@allowed_users(allowed_roles=['Admin', 'Purchase Return Email'])
def mailpr(request, pk):

    po = PurchaseReturn.objects.get(pk=pk)
    attachname = str(po.pr_no)+'.pdf'
    attach = popdf(request, pk)
    email = po.seller.email_id
    email_cc = po.seller.cc_email
    send_email(request,email,email_cc,"PURCHASE RETURN",attach, attachname)

def qdnpdf(request, pk):

    template = 'purchase/pdf_qdn.html'
    po = Qdn.objects.get(pk=pk)
    poitems = QdnItems.objects.filter(qdn=po, qdn_qty__gt=0)
    total = num2words(po.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '10',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'encoding': "UTF-8",
        'no-outline': None,
        'footer_right': 'Page [page] of [toPage]',
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': True}

    com = Company.objects.get(pk=1)
    context = {'po':po,'poitems': poitems, 'company': com,'total':total ,'date': date.today()}
    # return render(request, template, context)
    return render(request, 'purchase/pdf_qdn.html', context)
    # return PDFTemplateResponse(request=request, context=context, template=template, filename=str(po.qdn_no)+'.pdf', cmd_options=cmd_options)

@allowed_users(allowed_roles=['Admin', 'purchase QDN Email'])
def mailqdn(request, pk):

    po = Qdn.objects.get(pk=pk)
    attachname = str(po.qdn_no)+'.pdf'
    attach = qdnpdf(request, pk)
    email = po.seller.email_id
    email_cc = po.seller.cc_email
    send_email(request,email,email_cc,"QDN",attach, attachname)

#-------------------------------------------------------------------------GRN

@allowed_users(allowed_roles=['Admin', 'GRN Create', 'GRN Update', 'GRN Delete'])
def addgrn(request):

    skey            = (request.session.get('skey').get('company').get('id'))
    com             = Company.objects.get(id=skey)
    po              = Purchase_order.objects.filter(company=com,status__in=['1','3'])
    series          = com.grn_series

    if request.method == 'POST':
        # try:
            po_no                       = request.POST.get("po_no")
            po                          = Purchase_order.objects.get(id=po_no)

            grn             = Grn.objects.filter(company=po.company, grn_no__contains=series).order_by('created').last()
            if grn:
                ponum       = int(grn.grn_no[len(series):]) + 1
                grnnumber   = series + (str(ponum)).zfill(5)
            else:
                grnnumber   = series + '00001'

            dispatch_through            = request.POST.get("dispatch_through")
            destintaion                 = request.POST.get("destintaion")
            narration                   = request.POST.get("narration")
            other_ledger                = request.POST.get("other_ledger")
            if other_ledger:
                other_ledger            = LedgersType.objects.get(id=other_ledger)

            if request.POST.get("other"):
                other = Decimal(request.POST.get("other"))
            else:
                other = 0

            if request.POST.get("totaltcs"):
                totaltcs = Decimal(request.POST.get("totaltcs"))
            else:
                totaltcs = 0
            ol_rate                     = Decimal(request.POST.get("ol_rate"))

            exchangeINR                 = request.POST.get("exchangerate")
            if not exchangeINR:
                exchangeINR = 1

            grn                         = Grn()
            grn.po                      = po
            grn.company                 = po.company
            grn.grn_no                  = grnnumber
            grn.seller                  = po.seller
            grn.seller_address_type     = po.seller_address_type
            grn.seller_address1         = po.seller_address1
            grn.seller_address2         = po.seller_address2
            grn.seller_address3         = po.seller_address3
            grn.seller_gstin            = po.seller_gstin
            grn.seller_state            = po.seller_state
            grn.seller_city             = po.seller_city
            grn.seller_country          = po.seller_country
            grn.seller_pincode          = po.seller_pincode
            grn.seller_gst_reg_type     = po.seller_gst_reg_type
            grn.seller_mailingname      = po.seller_mailingname

            grn.shipto                  = po.shipto
            grn.shipto_address_type     = po.shipto_address_type
            grn.shipto_address1         = po.shipto_address1
            grn.shipto_address2         = po.shipto_address2
            grn.shipto_address3         = po.shipto_address3
            grn.shipto_gstin            = po.shipto_gstin
            grn.shipto_state            = po.shipto_state
            grn.shipto_city             = po.shipto_city
            grn.shipto_country          = po.shipto_country
            grn.shipto_pincode          = po.shipto_pincode
            # grn.shipto_pan_no           = po.shipto_pan_no
            grn.shipto_mailingname      = po.shipto_mailingname

            grn.mode_of_payment         = po.mode_of_payment
            grn.other_reference         = po.other_reference
            grn.terms_of_delivery       = po.terms_of_delivery

            grn.currency                = po.currency
            grn.ex_rate                 = Decimal(exchangeINR)

            grn.dispatch_through        = dispatch_through
            grn.destintaion             = destintaion

            grn.ammount                 = 0
            grn.other                   = 0
            grn.cgst                    = 0
            grn.igst                    = 0
            grn.sgst                    = 0
            grn.tcs                     = 0
            grn.round_off               = 0
            grn.total                   = 0

            grn.narration               = narration
            grn.save()

            totalammount                = 0
            totalcgst                   = 0
            totalsgst                   = 0
            totaligst                   = 0

            qtys                        = request.POST.getlist("recd_qty")

            godown                      = Godown.objects.get(name="UN ALLOCATED")
            items                       = PoItems.objects.filter(po=po, actual_qty__gt=0)
            today                       = datetime.date.today()
            grncount                    = Grn.objects.filter(created__date=today).count()
            grnbatch                    = today.strftime("%Y%m%d") + str(grncount+1).zfill(3)

            for j,i in enumerate(items):

                product_code        = i.product_code
                item                = i.item
                pack                = i.pack
                rate                = i.rate
                recd_qty            = Decimal(qtys[j])
                batch               = grnbatch + str(j+1).zfill(3)

                ammount             = round((recd_qty * rate),2)
                igstrate            = Decimal(i.item.gst)
                cgstrate            = igstrate/2
                sgstrate            = cgstrate
                igst                = round((ammount * (igstrate / 100)),2)
                cgst                = round((ammount * (cgstrate / 100)),2)
                sgst                = round((ammount * (sgstrate / 100)),2)

                totalcgst           = totalcgst + cgst
                totalsgst           = totalsgst + sgst
                totaligst           = totaligst + igst
                totalammount        = totalammount + ammount

                i.actual_qty        = i.actual_qty - recd_qty
                i.save()

                Stock_summary.objects.create(company=grn.company,godown=godown, product=i.item, rate=Decimal(rate) * Decimal(exchangeINR), batch=batch, mrp=i.item.mrp, closing_balance=recd_qty)

                grnItems.objects.create(grn=grn, item=item,mrp=i.item.mrp,batch=batch, product_code=product_code, pack=pack, recd_qty=recd_qty, actual_qty=Decimal(i.actual_qty), igstrate=i.igstrate ,sgstrate=i.sgstrate ,cgstrate=i.cgstrate,
                                    rate=Decimal(rate), amount=Decimal(ammount),igst=igst ,sgst=sgst ,cgst=cgst)


            grn.ammount                 = totalammount
            grn.cgst                    = round((totalcgst + (other*ol_rate/200)),2)
            grn.sgst                    = round((totalsgst + (other*ol_rate/200)),2)
            grn.igst                    = round((totaligst + (other*ol_rate/100)),2)
            grn.tcs                     = totaltcs
            grn.other                   = other

            total                       = totalammount + grn.igst + totaltcs + other
            grn.total                   = round(total)
            grn.round_off               = Decimal(grn.total - total)
            grn.save()
            messages.success(request, "GRN: {} Added Successfully".format(grn))

            if PoItems.objects.filter(po=po, actual_qty__gt=0):
                po.status= '3'
            else:
                po.status= '4'
            po.save()
        # except BaseException as exp:
            # grnItems.objects.filter(grn=grn).delete()
            # grn.delete()
            # return redirect("purchase:grn")

            return redirect("purchase:grn")

    grn             = Grn.objects.filter(company=com, grn_no__contains=series).order_by('created').last()
    if grn:
        ponum       = int(grn.grn_no[len(series):]) + 1
        grnnumber   = series + (str(ponum)).zfill(5)
    else:
        grnnumber   = series + '00001'

    context = {'pos': po, 'grnnumber': grnnumber}

    return render(request, 'purchase/add_grn.html', context)

@allowed_users(allowed_roles=['Admin', 'GRN Update', 'GRN Delete'])
def grnedit(request, pk):

    grn                     = Grn.objects.get(pk=pk)
    items                   = grnItems.objects.filter(grn=grn)

    if request.method == 'POST':
        dispatch_through    = request.POST.get("dispatch_through")
        destintaion         = request.POST.get("destintaion")
        narration           = request.POST.get("narration")
        other_ledger        = request.POST.get("other_ledger")

        grn.dispatch_through        = dispatch_through
        grn.destintaion             = destintaion
        grn.narration               = narration
        if other_ledger:
            other_ledger    = LedgersType.objects.get(id=other_ledger)

        if request.POST.get("other"):
            other           = Decimal(request.POST.get("other"))
        else:
            other = 0

        if request.POST.get("totaltcs"):
            totaltcs        = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = 0
        ol_rate             = Decimal(request.POST.get("ol_rate"))

        qtys                = request.POST.getlist("actualqty")

        exchangeINR         = request.POST.get("exchangerate")
        if not exchangeINR:
            exchangeINR = 1

        totalammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0
        try:
            flag = True
            for j,i in enumerate(items):
                    recd_qty            = Decimal(qtys[j])
                    p                   = PoItems.objects.get(po=grn.po,item=i.item)
                    p.actual_qty        += i.recd_qty - recd_qty
                    p.save()
                    i.actual_qty        += i.recd_qty - recd_qty

                    i.recd_qty          = recd_qty
                    ammount             = round((recd_qty * i.rate),2)
                    igst                = round((ammount * (i.igstrate / 100)),2)
                    cgst                = round((ammount * (i.cgstrate / 100)),2)
                    sgst                = round((ammount * (i.sgstrate / 100)),2)

                    totalcgst           = totalcgst + cgst
                    totalsgst           = totalsgst + sgst
                    totaligst           = totaligst + igst
                    totalammount        = totalammount + ammount

                    if i.actual_qty > 0.00:
                        flag = False
                    i.amount            = ammount
                    i.save()

                    st=Stock_summary.objects.get(company=grn.company, product=i.item, rate=i.rate, batch=i.batch)
                    st.rate=i.rate/grn.ex_rate*Decimal(exchangeINR)
                    st.closing_balance=recd_qty
                    st.save()
            po = Purchase_order.objects.get(id=grn.po.id)
            if flag:
                po.status= '4'
            else:
                po.status= '3'
            po.save()
        except BaseException as exp:
            print(exp)
            grn.delete()
            return redirect("purchase:grn")

        grn.ammount                 = totalammount
        grn.cgst                    = round((totalcgst + (other * ol_rate / 200)),2)
        grn.sgst                    = round((totalsgst + (other * ol_rate / 200)),2)
        grn.igst                    = round((totaligst + (other * ol_rate / 100)),2)
        grn.tcs                     = totaltcs
        grn.other                   = other
        grn.ex_rate                 = Decimal(exchangeINR)

        total                       = totalammount + grn.igst + totaltcs + other
        grn.total                   = round(total)
        grn.round_off               = Decimal(grn.total - total)
        grn.save()
        messages.success(request, "GRN: {} Updated Successfully".format(grn))

        return redirect("purchase:grn")

    return render(request, 'purchase/edit_grn.html', {'grn': grn, 'items': items})

@allowed_users(allowed_roles=['Admin', 'GRN View', 'GRN Create', 'GRN Update', 'GRN Delete'])
def grnshow(request, pk):

    grn             = Grn.objects.get(pk=pk)
    items           = grnItems.objects.filter(grn=grn)

    return render(request, 'purchase/show_grn.html', {'pk': pk, 'grn': grn, 'items': items})

@allowed_users(allowed_roles=['Admin', 'GRN Delete'])
def grncancel(request,pk):

    grn             = Grn.objects.get(pk=pk)
    po              = Purchase_order.objects.get(grn=grn)
    po.status       = '1'
    po.grn.set      = 'None'
    po.save()

    items           = grnItems.objects.filter(grn=grn)
    godown          = Godown.objects.get(name="UN ALLOCATED")

    poitems         = PoItems.objects.filter(po=po)
    for i in poitems:
        for j in items:
            if j.item == i.item:
                ss=Stock_summary.objects.filter(company=grn.company,godown=godown, product=j.item,batch=j.batch)
                ss.delete()
                i.actual_qty += j.recd_qty
        i.save()
    grn.status = "2"
    grn.save()
    messages.success(request, "GRN: {} Cancelled Successfully".format(grn))
    return redirect("purchase:grn")

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'GRN View', 'GRN Create', 'GRN Update', 'GRN Delete']), name='dispatch')
class GrnView(ListView):
    model = Grn
    template_name = 'purchase/list_grn.html'
    context_object_name = 'grns'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Grn.objects.filter(company=self.request.META['com']).order_by("-grn_no")
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(grn_no__icontains=query) )
        return qs


#-------------------------------------------------------------------------Purchase
allowed_users(allowed_roles=['Admin', 'Purchase Create', 'Purchase Update', 'Purchase Delete'])
def addpi(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    pos     = Purchase_order.objects.filter(company=com, status__in = [3,4])
    series  = com.pi_series
    pi      = Purchase.objects.filter(company=com, pi_no__contains=series).last()
    if pi:
        ponum = int(pi.pi_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'

    if request.method == 'POST':

        grn_no              = request.POST.get("grn")
        grn                 = Grn.objects.get(id=grn_no)
        narration           = request.POST.get("narration")
        reference           = request.POST.get("reference")
        reference_date      = request.POST.get("reference_date")
        ol_rate             = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("other"):
            other           = Decimal(request.POST.get("other"))
        else:
            other           = 0

        other_ledger        = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger    = LedgersType.objects.get(id=other_ledger)
            pi.other_ledger = other_ledger

        if request.POST.get("totaltcs"):
            totaltcs        = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs        = 0

        pi                          = Purchase()
        pi.company                  = grn.company
        pi.pi_no                    = grnnumber

        pi.seller                   = grn.seller
        pi.seller_address_type      = grn.seller_address_type
        pi.seller_gst_reg_type      = grn.seller_gst_reg_type
        pi.seller_state             = grn.seller_state
        pi.seller_country           = grn.seller_country
        pi.seller_city              = grn.seller_city
        pi.seller_mailingname       = grn.seller_mailingname
        pi.seller_address1          = grn.seller_address1
        pi.seller_address2          = grn.seller_address2
        pi.seller_address3          = grn.seller_address3
        pi.seller_pincode           = grn.seller_pincode
        pi.seller_gstin             = grn.seller_gstin

        pi.shipto                   = grn.shipto
        pi.shipto_address_type      = grn.shipto_address_type
        pi.shipto_country           = grn.shipto_country
        pi.shipto_state             = grn.shipto_state
        pi.shipto_city              = grn.shipto_city
        pi.shipto_mailingname       = grn.shipto_mailingname
        pi.shipto_address1          = grn.shipto_address1
        pi.shipto_address2          = grn.shipto_address2
        pi.shipto_address3          = grn.shipto_address3
        pi.shipto_pincode           = grn.shipto_pincode
        pi.shipto_gstin             = grn.shipto_gstin
        pi.shipto_pan_no            = grn.shipto_pan_no

        pi.ol_rate                  = ol_rate
        pi.ammount                  = 0
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = 0
        pi.other                    = 0
        pi.round_off                = 0
        pi.total                    = 0

        pi.mode_of_payment          = grn.mode_of_payment
        pi.supplier_invoice         = reference
        pi.supplier_date            = reference_date
        pi.terms_of_delivery        = grn.terms_of_delivery
        pi.dispatch_through         = grn.dispatch_through
        pi.destination              = grn.destintaion
        pi.currency                 = grn.currency
        pi.ex_rate                  = grn.ex_rate
        pi.narration = narration
        pi.save()

        ratelist                    = request.POST.getlist("rate")
        poitems                     = grnItems.objects.filter(grn=grn)

        for row in poitems.values():
            row.pop('id')
            row.pop('actual_qty')
            row['basic_qty']        = 0
            row['recd_qty']         = 0
            row['amount']           = 0
            PiItems.objects.create(pi=pi,**row)

        grn.pi                      = pi
        grn.status                  = 3
        grn.save()

        items = grnItems.objects.filter(grn=grn)

        totalammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0
        try:
            for j,i in enumerate(items):

                p                   = PiItems.objects.get(pi=pi,batch=i.batch,item=i.item)
                p.rate              = Decimal(ratelist[j])
                p.recd_qty          = Decimal(i.recd_qty)

                amount              = round((i.recd_qty * p.rate),2)
                p.amount            = amount
                p.igstrate          = Decimal(i.igstrate)
                p.cgstrate          = Decimal(i.cgstrate)
                p.sgstrate          = Decimal(i.sgstrate)
                if pi.currency != 'INR':
                    cgst            = 0
                    sgst            = 0
                    igst            = 0
                else:
                    cgst            = round((amount * i.cgstrate / 100),2)
                    sgst            = round((amount * i.sgstrate / 100),2)
                    igst            = round((amount * i.igstrate / 100),2)
                p.igst              = Decimal(igst)
                p.cgst              = Decimal(cgst)
                p.sgst              = Decimal(sgst)
                p.save()
                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                totalammount        = totalammount  + amount

                st=Stock_summary.objects.filter(company=pi.company, product=i.item, batch=i.batch)
                for s in st:
                    s.rate = p.rate
                    s.save()

        except BaseException as exp:
            print(exp)
            grn.pi        = pi
            grn.status    = 1
            grn.save()
            PiItems.objects.filter(pi=pi).delete()
            pi.delete()
            return redirect("purchase:addpi")

        po = Purchase_order.objects.get(id=grn.po.id)
        if po.status == '4':
            activegrn = Grn.objects.filter(po=po, status='1')
            if not activegrn:
                po.status = 5
                po.save()

        pi.ammount                 = totalammount
        if pi.currency != 'INR':
            pi.cgst                    = 0
            pi.sgst                    = 0
            pi.igst                    = 0

        else:
            pi.cgst                    = round((totalcgst + (other * ol_rate / 200)),2)
            pi.sgst                    = round((totalsgst + (other * ol_rate / 200)),2)
            pi.igst                    = round((totaligst + (other * ol_rate / 100)),2)
        pi.tcs                     = totaltcs
        pi.other                   = other

        total                      = totalammount + pi.igst + pi.tcs + pi.other
        pi.total                   = round(total)
        pi.round_off               = pi.total - total
        pi.save()
        messages.success(request, "Purchase Invoice: {} Added Successfully".format(pi))
        return redirect("purchase:pi")

    company = Company.objects.all()
    ledgers = LedgersType.objects.filter(under__name = 'Direct Expense')
    context = {'pos': pos, 'pinumber': grnnumber, 'company': company,'ledgers':ledgers}

    return render(request, 'purchase/add_pi.html', context)

allowed_users(allowed_roles=['Admin', 'Purchase View', 'Purchase Create', 'Purchase Update', 'Purchase Delete'])
def pishow(request, pk):

    pi = Purchase.objects.get(pk=pk)
    items = PiItems.objects.filter(pi=pi)

    return render(request, 'purchase/show_pi.html', {'pi': pi,'items':items})

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Purchase View', 'Purchase Create', 'Purchase Update', 'Purchase Delete']), name='dispatch')
class PurchaseView(ListView):
    model = Purchase
    template_name = 'purchase/list_pi.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Purchase.objects.filter(company=self.request.META['com']).order_by("-pi_no")
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(pi_no__icontains=query) | Q(pi_no__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'Purchase Delete'])
def picancel(request, pk):

    pi          = Purchase.objects.get(pk=pk)
    pi.status   = "2"
    pi.save()

    grn         = Grn.objects.get(pi=pi)
    grn.status  = '1'
    grn.pi      = None
    grn.save()

    po          = Purchase_order.objects.get(id=grn.po.id)
    if po.status == '5':
        po.status   = "4"
        po.save()
    messages.success(request, "Purchase Invoice Cancelled Successfully")
    return redirect('purchase:pi')

@allowed_users(allowed_roles=['Admin', 'DebitNote Delete'])
def dbcancel(request, pk):

    pi = DebitNote.objects.get(pk=pk)
    pi.status = "2"
    pi.grn = None
    pi.save()
    messages.success(request, "Debit Note Cancelled Successfully")
    return redirect('purchase:db')

@allowed_users(allowed_roles=['Admin', 'Purchase QDN Delete'])
def qdncancel(request, pk):

    pi = DebitNote.objects.get(pk=pk)
    pi.status = "2"
    pi.grn = None
    pi.save()
    messages.success(request, "QDN Cancelled Successfully")
    return redirect('purchase:db')

@allowed_users(allowed_roles=['Admin', 'Purchase Return Delete'])
def prcancel(request, pk):

    pi = DebitNote.objects.get(pk=pk)
    pi.status = "2"
    pi.grn = None
    pi.save()
    messages.success(request, "Purchase Return Cancelled Successfully")
    return redirect('purchase:db')

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'DebitNote Delete', 'DebitNote View', 'DebitNote Create', 'DebitNote Update']), name='dispatch')
class debitnote(ListView):
    model = DebitNote
    template_name = 'purchase/list_db.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = DebitNote.objects.filter(company=self.request.META['com']).order_by('-db_no')
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(db_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Purchase QDN Delete', 'Purchase QDN View', 'Purchase QDN Create', 'Purchase QDN Update']), name='dispatch')
class quantity_dn(ListView):
    model = Qdn
    template_name = 'purchase/list_qdn.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Qdn.objects.filter(company=self.request.META['com']).order_by('-qdn_no')
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(qdn_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Purchase Return Delete', 'Purchase Return View', 'Purchase Return Create', 'Purchase Return Update']), name='dispatch')
class purchase_return(ListView):
    model = PurchaseReturn
    template_name = 'purchase/list_pr.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = PurchaseReturn.objects.filter(company=self.request.META['com']).order_by('-pr_no')
        if query is not None:
            qs=qs.filter( Q(seller__name__icontains=query) | Q(pr_no__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'DebitNote Delete', 'DebitNote Create', 'DebitNote Update'])
def adddb(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    pos     = Purchase.objects.filter(company=com).exclude(status='2')
    series  = com.debitnote_series
    pi      = DebitNote.objects.filter(company=com, db_no__contains=series).last()
    if pi:
        ponum = int(pi.db_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'
    company = Company.objects.all()

    if request.method == 'POST':

        grn_no      = request.POST.get("grn_no")
        grn         = Purchase.objects.get(pi_no=grn_no)

        ol_rate     = Decimal(request.POST.get("ol_rate"))
        narration   = request.POST.get("narration")
        dif_rate    = request.POST.getlist("dif_rate")
        if request.POST.get("tcs"):
            totaltcs = Decimal(request.POST.get("tcs"))
        else:
            totaltcs = 0
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi = DebitNote()
        pi.company = grn.company
        pi.pi_no = grn
        pi.db_no = grnnumber

        pi.seller                   = grn.seller
        pi.seller_address_type      = grn.seller_address_type
        pi.seller_gst_reg_type      = grn.seller_gst_reg_type
        pi.seller_state             = grn.seller_state
        pi.seller_country           = grn.seller_country
        pi.seller_city              = grn.seller_city
        pi.seller_mailingname       = grn.seller_mailingname
        pi.seller_address1          = grn.seller_address1
        pi.seller_address2          = grn.seller_address2
        pi.seller_address3          = grn.seller_address3
        pi.seller_pincode           = grn.seller_pincode
        pi.seller_gstin             = grn.seller_gstin

        pi.shipto                   = grn.shipto
        pi.shipto_address_type      = grn.shipto_address_type
        pi.shipto_country           = grn.shipto_country
        pi.shipto_state             = grn.shipto_state
        pi.shipto_city              = grn.shipto_city
        pi.shipto_mailingname       = grn.shipto_mailingname
        pi.shipto_address1          = grn.shipto_address1
        pi.shipto_address2          = grn.shipto_address2
        pi.shipto_address3          = grn.shipto_address3
        pi.shipto_pincode           = grn.shipto_pincode
        pi.shipto_gstin             = grn.shipto_gstin

        pi.ammount                  = 0
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = totaltcs
        pi.other                    = 0
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate

        pi.mode_of_payment          = grn.mode_of_payment
        pi.other_reference          = grn.other_reference
        pi.terms_of_delivery        = grn.terms_of_delivery
        pi.dispatch_through         = grn.dispatch_through

        pi.narration                = narration
        pi.save()

        items               = PiItems.objects.filter(pi=grn)

        totalammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0
        try:
            for j,i in enumerate(items):

                item                = i.item
                product_code        = i.product_code
                batch               = i.batch
                pack                = i.pack
                mrp                 = i.mrp
                actual_qty          = i.recd_qty
                actual_rate         = i.rate
                rate                = Decimal(dif_rate[j])
                amount              = rate * actual_qty
                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate
                igst                = igstrate * amount / 100
                cgst                = cgstrate * amount / 100
                sgst                = sgstrate * amount / 100

                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                totalammount        = totalammount  + amount

                DebitNoteItems.objects.create(debitNote=pi,amount=amount,item=item,igstrate=igstrate,product_code=product_code,
                                              cgstrate=cgstrate,batch=batch, sgstrate=sgstrate,pack=pack,
                                              igst=igst,mrp=mrp,cgst=cgst,actual_qty=actual_qty,
                                              sgst=sgst,actual_rate=actual_rate,rate_diff=rate)
                st = Stock_summary.objects.filter(company=pi.company, product=i.item, batch__in = i.batch.split('~'))
                for s in st:
                    s.rate          -= rate
                    s.save()
        except BaseException as exp:
            print(exp)
            DebitNoteItems.objects.filter(debitNote=pi).delete()
            pi.delete()
            return redirect("purchase:db")

        pi.ammount                 = totalammount
        pi.cgst                    = totalcgst + (other * ol_rate / 100)
        pi.sgst                    = totalsgst + (other * ol_rate / 100)
        pi.igst                    = totaligst + (other * ol_rate / 100)
        pi.tcs                     = totaltcs
        pi.other                   = other

        total                      = totalammount + pi.igst + totaltcs + other
        pi.total                   = math.ceil(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()
        messages.success(request, "Debit Note Added Successfully")
        return redirect("purchase:db")



    context = {'pos': pos, 'grnnumber': grnnumber, 'company': company}

    return render(request, 'purchase/add_db.html', context)

@allowed_users(allowed_roles=['Admin', 'Purchase QDN Delete' 'Purchase QDN Create', 'Purchase QDN Update'])
def addqdn(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    pos     = Purchase.objects.filter(company=com)
    series  = com.purchase_qdn_series
    pi      = Qdn.objects.filter(company=com, qdn_no__contains=series).last()
    if pi:
        ponum = int(pi.qdn_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'
    company = Company.objects.all()

    if request.method == 'POST':

        grn_no      = request.POST.get("grn_no")
        ol_rate     = Decimal(request.POST.get("ol_rate"))
        grn         = Purchase.objects.get(pi_no=grn_no)
        narration   = request.POST.get("narration")
        s_qtylist   = request.POST.getlist("s_qty")

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = 0

        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi                          = Qdn()

        pi.company                  = grn.company
        pi.pi_no                    = grn
        pi.qdn_no                   = grnnumber

        pi.seller                   = grn.seller
        pi.seller_address_type      = grn.seller_address_type
        pi.seller_gst_reg_type      = grn.seller_gst_reg_type
        pi.seller_state             = grn.seller_state
        pi.seller_country           = grn.seller_country
        pi.seller_city              = grn.seller_city
        pi.seller_mailingname       = grn.seller_mailingname
        pi.seller_address1          = grn.seller_address1
        pi.seller_address2          = grn.seller_address2
        pi.seller_address3          = grn.seller_address3
        pi.seller_pincode           = grn.seller_pincode
        pi.seller_gstin             = grn.seller_gstin

        pi.shipto                   = grn.shipto
        pi.shipto_address_type      = grn.shipto_address_type
        pi.shipto_country           = grn.shipto_country
        pi.shipto_state             = grn.shipto_state
        pi.shipto_city              = grn.shipto_city
        pi.shipto_mailingname       = grn.shipto_mailingname
        pi.shipto_address1          = grn.shipto_address1
        pi.shipto_address2          = grn.shipto_address2
        pi.shipto_address3          = grn.shipto_address3
        pi.shipto_pincode           = grn.shipto_pincode
        pi.shipto_gstin             = grn.shipto_gstin

        pi.ammount                  = 0
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = totaltcs
        pi.other                    = 0
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate

        pi.mode_of_payment          = grn.mode_of_payment
        pi.other_reference          = grn.other_reference
        pi.terms_of_delivery        = grn.terms_of_delivery
        pi.dispatch_through         = grn.dispatch_through

        pi.narration                = narration
        pi.save()

        items                       = PiItems.objects.filter(pi=grn)

        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        try:
            for j,i in enumerate(items):
                item                = i.item
                product_code        = i.product_code
                batch               = i.batch
                pack                = i.pack
                mrp                 = i.mrp
                actual_qty          = i.recd_qty
                qdn_qty             = Decimal(s_qtylist[j])
                rate                = i.rate

                amount              = Decimal(rate * qdn_qty)
                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate
                igst                = Decimal((igstrate * amount)/100)
                cgst                = igst/2
                sgst                = igst/2
                print(cgst)
                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                totalammount        = totalammount  + amount

                QdnItems.objects.create(qdn=pi,amount=amount,item=item,igstrate=igstrate,product_code=product_code,
                                              cgstrate=cgstrate,batch=batch, sgstrate=sgstrate,pack=pack,
                                              igst=igst,mrp=mrp,cgst=cgst,actual_qty=actual_qty,qdn_qty=qdn_qty,
                                              sgst=sgst,rate=rate)

                st = Stock_summary.objects.filter(company=pi.company, product=i.item,batch__in=batch.split('~'),godown__name = 'SHORTAGE')
                for s in st:
                    s.closing_balance          -= qdn_qty
                    if s.closing_balance == 0:
                        s.delete()
                    else:
                        s.save()

        except BaseException as exp:
            QdnItems.objects.filter(qdn=pi).delete()
            pi.delete()
            return redirect("purchase:qdn")


        pi.ammount                 = totalammount
        pi.cgst                    = totalcgst + (other * ol_rate / 100)
        pi.sgst                    = totalsgst + (other * ol_rate / 100)
        pi.igst                    = totaligst + (other * ol_rate / 100)

        pi.other                   = other

        total                      = totalammount + pi.igst + totaltcs + other
        pi.total                   = math.ceil(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()
        messages.success(request, "QDN Added Successfully")
        return redirect("purchase:qdn")

    context = {'pos': pos, 'grnnumber': grnnumber, 'company': company}

    return render(request, 'purchase/add_qdn.html', context)

@allowed_users(allowed_roles=['Admin', 'Purchase Return Delete', 'Purchase Return Create', 'Purchase Return Update'])
def addpr(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    pos     = Purchase.objects.filter(company=com)
    series  = com.purchase_return_series
    pi      = PurchaseReturn.objects.filter(company=com, pr_no__contains=series).last()
    if pi:
        ponum = int(pi.pr_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'

    if request.method == 'POST':

        grn_no          = request.POST.get("grn_no")
        ol_rate         = Decimal(request.POST.get("ol_rate"))
        grn             = Purchase.objects.get(pi_no=grn_no)

        narration       = request.POST.get("narration")
        d_qtylist       = request.POST.getlist("d_qty")

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = 0

        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi                          = PurchaseReturn()

        pi.company                  = grn.company
        pi.pi_no                    = grn
        pi.pr_no                    = grnnumber

        pi.seller                   = grn.seller
        pi.seller_address_type      = grn.seller_address_type
        pi.seller_gst_reg_type      = grn.seller_gst_reg_type
        pi.seller_state             = grn.seller_state
        pi.seller_country           = grn.seller_country
        pi.seller_city              = grn.seller_city
        pi.seller_mailingname       = grn.seller_mailingname
        pi.seller_address1          = grn.seller_address1
        pi.seller_address2          = grn.seller_address2
        pi.seller_address3          = grn.seller_address3
        pi.seller_pincode           = grn.seller_pincode
        pi.seller_gstin             = grn.seller_gstin

        pi.shipto                   = grn.shipto
        pi.shipto_address_type      = grn.shipto_address_type
        pi.shipto_country           = grn.shipto_country
        pi.shipto_state             = grn.shipto_state
        pi.shipto_city              = grn.shipto_city
        pi.shipto_mailingname       = grn.shipto_mailingname
        pi.shipto_address1          = grn.shipto_address1
        pi.shipto_address2          = grn.shipto_address2
        pi.shipto_address3          = grn.shipto_address3
        pi.shipto_pincode           = grn.shipto_pincode
        pi.shipto_gstin             = grn.shipto_gstin

        pi.ammount                  = 0
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = totaltcs
        pi.other                    = 0
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate

        pi.mode_of_payment          = grn.mode_of_payment
        pi.other_reference          = grn.other_reference
        pi.terms_of_delivery        = grn.terms_of_delivery
        pi.dispatch_through         = grn.dispatch_through

        pi.narration                = narration
        pi.save()

        items               = PiItems.objects.filter(pi=grn)

        totalammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0
        try:
            for j,i in enumerate(items):
                item                = i.item
                product_code        = i.product_code
                batch               = i.batch
                pack                = i.pack
                mrp                 = i.mrp
                actual_qty          = i.recd_qty
                return_qty          = Decimal(d_qtylist[j])

                rate                = i.rate

                amount              = rate * return_qty
                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate
                igst                = (igstrate * amount)/100
                cgst                = igst/2
                sgst                = igst/2
                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                totalammount        = totalammount  + amount

                PurchaseReturnItems.objects.create(pr=pi,amount=amount,item=item,igstrate=igstrate,product_code=product_code,
                                              cgstrate=cgstrate,batch=batch, sgstrate=sgstrate,pack=pack,
                                              igst=igst,mrp=mrp,cgst=cgst,actual_qty=actual_qty,
                                              sgst=sgst,return_qty=return_qty,rate=rate)


                st2 = Stock_summary.objects.filter(company=pi.company, product=i.item,batch__in=batch.split('~'),godown__name = 'DAMAGE & SCRAP')
                for s in st2:
                    s.closing_balance          -= return_qty
                    if s.closing_balance == 0:
                            s.delete()
                    else:
                        s.save()
        except BaseException as exp:
            print(exp)
            PurchaseReturnItems.objects.filter(pr=pi).delete()
            pi.delete()
            return redirect("purchase:pr")


        pi.ammount                 = totalammount
        pi.cgst                    = totalcgst + (other * ol_rate / 100)
        pi.sgst                    = totalsgst + (other * ol_rate / 100)
        pi.igst                    = totaligst + (other * ol_rate / 100)

        pi.other                   = other

        total                      = totalammount + pi.igst + totaltcs + other
        pi.total                   = math.ceil(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()
        messages.success(request, "Purchase Return Created Successfully")
        return redirect("purchase:pr")

    parties = Party_master.objects.filter(group__name="Sundry Creditors").order_by('name')
    context = {'pos': pos, 'grnnumber': grnnumber, 'parties': parties}

    return render(request, 'purchase/add_pr.html', context)

@allowed_users(allowed_roles=['Admin', 'DebitNote View', 'DebitNote Delete', 'DebitNote Create', 'DebitNote Update'])
def dbshow(request, pk):

    pi      = DebitNote.objects.get(pk=pk)
    items   = DebitNoteItems.objects.filter(debitNote=pi)

    return render(request, 'purchase/show_db.html', {'pi': pi,'items':items})

@allowed_users(allowed_roles=['Admin', 'Purchase QDN View', 'Purchase QDN Delete', 'Purchase QDN Create', 'Purchase QDN Update'])
def qdnshow(request, pk):

    pi      = Qdn.objects.get(pk=pk)
    items   = QdnItems.objects.filter(qdn=pi)

    return render(request, 'purchase/show_dbq.html', {'pi': pi,'items':items})

@allowed_users(allowed_roles=['Admin', 'Purchase Return View', 'Purchase Return Delete', 'Purchase Return Create', 'Purchase Return Update'])
def prshow(request, pk):

    pi      = PurchaseReturn.objects.get(pk=pk)
    items   = PurchaseReturnItems.objects.filter(pr=pi)

    return render(request, 'purchase/show_pr.html', {'pi': pi,'items':items})

import xmltodict, json
def sendpi(request, pk):

    inv     = Purchase.objects.get(pk=pk)
    items   = PiItems.objects.filter(pi=inv,recd_qty__gt =0)

    xml     = purchasexml(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    mainxml = mainxml.replace('xml_creator', xml)
    mainxml = mainxml.replace('$', '&#36;')
    payload = mainxml.replace('₹', '&#8377;')
    print(payload)
    req     = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))

    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('purchase:pi')
    return HttpResponse(req)


def senddb(request, pk):

    inv = DebitNote.objects.get(pk=pk)
    items = DebitNoteItems.objects.filter(debitNote=inv)

    xml = debitxml(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    payload = mainxml.replace('xml_creator', xml)
    req = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))

    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('purchase:db')
    return HttpResponse(req)
def sendqdn(request, pk):

    inv = Qdn.objects.get(pk=pk)
    items = QdnItems.objects.filter(qdn=inv)

    xml = qdnxml(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    payload = mainxml.replace('xml_creator', xml)
    req = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))

    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('purchase:qdn')
    return HttpResponse(req)

def sendpr(request, pk):

    inv = PurchaseReturn.objects.get(pk=pk)
    items = PurchaseReturnItems.objects.filter(pr=inv)


    xml = prxml(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    payload = mainxml.replace('xml_creator', xml)
    req = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))

    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('purchase:pr')
    return HttpResponse(req)

#------------------------------------------------------------------  Ajax Views

def item(request):

    no = int(request.GET['no'])+1
    items = Product_master.objects.all()
    context = {'no': no,'items':items}

    return render(request, 'purchase/partials/po-item.html', context)

def ivtitem(request):

    no = int(request.GET['no'])+1
    context = {'no': no, 'items': Product_master.objects.all()}

    return render(request, 'purchase/partials/ivt-item.html', context)

def party_address(request):
    party = Party_master.objects.get(group__name="Sundry Creditors",name=request.GET.get('party'))
    address_type = request.GET.get('address')
    address = Party_contact_details.objects.get(
        party=party, address_type=address_type)
    return render(request, 'purchase/partials/party_address.html', {'address': address})


def address(request):
    party = Party_master.objects.get(group__name="Sundry Creditors",name=request.GET.get('party'))
    address_types = Party_contact_details.objects.filter(
        party=party).order_by('address_type')
    return render(request, 'purchase/partials/address.html', {'address': party, 'address_types': address_types})


def product_code(request):
    search_text=(request.GET.get('item'))
    currentcurrency = request.GET.get('currentcurrency', None)
    product = Product_master.objects.filter(Q(product_code=search_text) | Q(article_code=search_text))
    if product:
        for i,j in enumerate(product):
            if str(j.product_type) == 'FINISHED GOODS':
                std = Std_rate.objects.filter(product=product[i])
                if len(std) == 0:
                    std = 0
                else:
                    std = std[0].rate
            else:
                std = Std_rate.objects.filter(product=product[i])
                if len(std) == 0:
                    std = ''
                else:
                    std = std[0].rate
        return render(request, 'purchase/partials/product_code.html', {'product': product,'std':std, 'currentcurrency':currentcurrency})


def product_pack(request):
    pass
    # product = Product_master.objects.get(product_code=request.GET.get('item'))
    # # std=Std_rate.objects.filter(product=product, rate_type = '1').last()
    # return HttpResponse(product.outer_qty)


def product_std_rate(request):
    pass
    # product = Product_master.objects.get(product_code=request.GET.get('item'))
    # # std=Std_rate.objects.filter(product=product, rate_type = '1').last()
    # return HttpResponse(std.rate)

def product_mrp(request):
    pass



def product_stock(request):
    product = Product_master.objects.get(product_code=request.GET.get('item'))
    batch = Stock_summary.objects.filter(
        name=product, godown__godown_type=True).aggregate(Sum('closing_balance'))
    return HttpResponse(batch["closing_balance__sum"])


def product_rate(request):
    pass
    # product = Product_master.objects.get(product_code=request.GET.get('item'))
    # price_level = Price_level.objects.get(name=request.GET.get('price_list'))
    # rate = Price_list.objects.filter(
    #     item=product, price_level=price_level).first()
    # return HttpResponse(rate.rate)


def product_gst(request):

    product         = Product_master.objects.get(product_code=request.GET.get('item'))
    gst             = Gst_list.objects.filter(product=product).last()

    context         = {'item': {'igst': gst.igstrate, 'cgst': gst.cgstrate, 'sgst': gst.sgstrate}}

    return render(request, 'purchase/partials/gst.html', context)


def load_po_upload(request):

    no              = request.GET.get('no')
    currency        = request.GET.get('currency')
    product_code    = request.GET.get('product_code')

    product         = Product_master.objects.get(product_code=product_code)
    if currency != 'INR':
        gst         = Decimal(0)
    else:
        gst         = product.gst
    rate            = Decimal(request.GET.get('rate'))
    actualqty       = request.GET.get('actualqty')
    warningmessage = ''
    if product and str(product.product_type) == 'FINISHED GOODS':
        standardRate = Std_rate.objects.get(product__product_code=product_code).rate
        if rate > standardRate:
            warningmessage = 'Product Rate never be more than Standard Rate'
            standardRate = 0
        # try:
        #     standardRate = Std_rate.objects.get(product__product_code=product_code).rate
        #     if rate < standardRate:
        #         warningmessage = 'Product Rate never be more than Standard Rate'
        # except:
        #     warningmessage = "Standard Rate is not seted on the Product"
        #     standardRate = 0
    else:
        standardRate = ''


    amount          = (Decimal(actualqty) * Decimal(rate))
    igst            = (gst * amount / 100)
    sgst            = (gst * amount / 200)
    cgst            = (gst * amount / 200)

    context = {
        'no': no,
        'product': product,
        'rate': Decimal(rate),
        'actualqty': actualqty,
        'gst': gst,
        'igst': igst,
        'cgst': cgst,
        'sgst': sgst,
        'amount': amount,
        'standardRate': standardRate,
        'warningmessage': warningmessage,
    }
    return render(request, 'purchase/partials/po-upload.html', context)


def load_po(request):

    no = request.GET.get('pono')
    po          = Purchase_order.objects.get(id=no)
    items       = PoItems.objects.filter(po=po, actual_qty__gt=0)

    context     = {'po': po, 'items': items, 'items12': Product_master.objects.all(),}

    return render(request, 'purchase/partials/po.html', context)

def load_grnlist(request):

    po                              = Purchase_order.objects.get(pk=request.GET.get('grn'))
    items                           = Grn.objects.filter(po=po,status=1)
    context     = {'pos': items}

    return render(request, 'purchase/partials/list-grn.html', context)

def load_grn(request):

    grn                             = Grn.objects.get(pk=request.GET.get('grn'))
    items                           = grnItems.objects.filter(grn=grn)

    context     = {'grn': grn, 'items': items}

    return render(request, 'purchase/partials/grn.html', context)

def load_skuname(request):

    skucode     = Product_master.objects.get(product_code=request.GET.get('product'))

    return render(request, 'purchase/partials/sr.html', {'skucode': skucode})

def load_db(request):

    grn                             = Purchase.objects.get(pi_no=request.GET.get('grn'))
    items                           = PiItems.objects.filter(pi=grn)

    context     = {'grn': grn, 'items': items}

    return render(request, 'purchase/partials/db.html', context)

def load_qdn(request):

    grn                             = Purchase.objects.get(pi_no=request.GET.get('grn'))
    pitems                          = PiItems.objects.filter(pi=grn)
    items                           = list(pitems.values('product_code','item__product_name','mrp','pack', 'recd_qty', 'rate', 'sgstrate', 'cgstrate', 'igstrate'))

    for j,i in enumerate(pitems):

        st                          = Stock_summary.objects.filter(company=grn.company, product=i.item,batch__in=i.batch.split('~'),godown__name = 'SHORTAGE').aggregate(Sum('closing_balance'))
        items[j]['shortage']        = st["closing_balance__sum"]

    context = {'grn': grn, 'items': items}

    return render(request, 'purchase/partials/qdn.html', context)

def load_pr(request):

    grn                             = Purchase.objects.get(pi_no=request.GET.get('grn'),status__in=['1','3'])
    pitems                          = PiItems.objects.filter(pi=grn)
    items                           = list(pitems.values('product_code','item__product_name','mrp','pack', 'recd_qty', 'rate', 'sgstrate', 'cgstrate', 'igstrate'))

    for j,i in enumerate(pitems):

        st2                         = Stock_summary.objects.filter(company=grn.company, product=i.item,batch__in=i.batch.split('~'),godown__name = 'DAMAGE & SCRAP').aggregate(Sum('closing_balance'))
        items[j]['damage']          = st2["closing_balance__sum"]

    context = {'grn': grn, 'items': items}

    return render(request, 'purchase/partials/pr.html', context)

def load_sr_upload(request):

    return render(request, 'purchase/partials/sr-upload.html',)

def standard_cost_import_data(request):

    if request.method == 'POST':

        dataset                     = Dataset()
        new_products                = request.FILES['importData']

        imported_data               = dataset.load(new_products.read())

        for i in imported_data:
            pc                      = i[0]
            pd                      = Product_master.objects.get(product_code=pc)
            rate                    = i[1]
            applicable_from         = date.today()
            uom                     = str(pd.units_of_measure)

            Std_rate.objects.update_or_create(product = pd, rate_type = '1', defaults = {'applicable_from':applicable_from, 'rate':rate, 'uom':uom})

    return redirect('purchase:stdrate')

