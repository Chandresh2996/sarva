from datetime import date, datetime, timedelta
from decimal import Decimal
import json
import math
from django.db.models import Sum
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db.models import Q
from accounts.mail import send_email
from company.models import Company
from purchase.models import Grn
from inventory.models import Godown, Gst_list, Product_master
from ledgers.models import LedgersType, Party_contact_details, Party_master, Price_level, Price_list, State, City
from sales.xmlcreator import cncreator, creditmemocreator, invcreator, qdncreator, rsocreator
from .models import CreditNote, CreditNoteItems, Delivery_note, DnItems, InvItems, Invoice, LoadingSheet, PackingSheet, Qdn, QdnItems, Rso, RsoItems, SaleQty, Salesorder, SoItems, SalesTarget, ProformaInvoice, ProformaInvItems
from warehouse.models import Stock_summary
from wkhtmltopdf.views import  PDFTemplateResponse
import requests
from django.utils.decorators import method_decorator
from core.decorators import auth_users, allowed_users, is_company
from django.views.generic import ListView
from django.contrib import messages
from django.db.models import F, Sum

# Create your views here.


def salable(com,code):
    sqty = 0
    stock = 0
    queryset = list(Stock_summary.objects.filter(company=com,product=code,godown__godown_type=True).values('product').annotate(qty=Sum('closing_balance')))
    if queryset:
        stock = queryset[0]['qty']
    so = list(SoItems.objects.filter(so__company=com,so__status='1',item=code).values('item').annotate(qty=Sum('actual_qty')))
    if so:
        sqty = (so[0]['qty'])
    return stock - sqty
# ____________________________________________________________________________________Sales Order_________________________
def sales(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    context = {}
    context['pl'] = Price_list.objects.count()
    context['ecomso'] = Salesorder.objects.filter(company=com,buyer__devision__name = 'ECOM').count()
    context['so'] = Salesorder.objects.filter(company=com).count()
    context['sale'] = Invoice.objects.filter(company=com).count()
    context['qdn'] = Qdn.objects.filter(company=com).count()
    context['cn'] = CreditNote.objects.filter(company=com).count()
    context['rso'] = Rso.objects.filter(company=com).count()
    context['saleProforma'] =ProformaInvoice.objects.filter(company=com).count()

    return render(request, 'sales/sales.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales Order Delete', 'Sales Order Create', 'Sales Order Update'])
def so(request):

    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)
    series      = com.so_series
    so          = Salesorder.objects.filter(company=com, so_no__contains=series).order_by('so_no').last()
    if so:
        sonum       = int(so.so_no[len(series):]) + 1
        sonumber    = series + (str(sonum)).zfill(5)
    else:
        sonumber    = series + '00001'

    if request.method == 'POST':
        party_name                  = request.POST.get("party_name")
        consignee_name              = request.POST.get("consignee_name")

        if request.POST.get("so_due_date"):
            so_due_date             = request.POST.get("so_due_date")
        else:
            so_due_date             = None

        mode_of_payment             = request.POST.get("mode_of_payment")
        other_reference             = request.POST.get("other_reference")
        order_no                    = request.POST.get("order_no")
        terms_of_delivery           = request.POST.get("terms_of_delivery")
        narration                   = request.POST.get("narration")

        if request.POST.get("isscheme"):
            isscheme                = True
        else:
            isscheme                = False

        party_address_type          = request.POST.get("party_address_type")
        consignee_address_type      = request.POST.get("consignee_address_type")

        actualqtylist               = request.POST.getlist('aqty')
        stocklist                   = request.POST.getlist('stock')
        product_codelist            = request.POST.getlist('product_code')
        offermrplist                = request.POST.getlist("offermrp")
        billqtylist                 = request.POST.getlist("billqty")
        ratelist                    = request.POST.getlist("rate")
        discountlist                = request.POST.getlist("discount")

        if request.POST.get("extradiscount"):
            extradiscount           = Decimal(request.POST.get("extradiscount"))
        else:
            extradiscount           = 0.0

        party                       = Party_master.objects.get(group__name="Sundry Debtors",name=party_name)
        consignee                   = Party_master.objects.get(group__name="Sundry Debtors",name=consignee_name)

        so                          = Salesorder()
        so.company                  = com

        if party_address_type:
            party_add               = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            so.buyer_address_type   = party_add.address_type
        else:
            party_add               = party
            so.buyer_address_type   = "Default"

        if consignee_address_type:
            shipto_add              = Party_contact_details.objects.get(party=consignee, address_type=consignee_address_type )
            so.shipto_address_type  = shipto_add.address_type
        else:
            shipto_add              = consignee
            so.shipto_address_type  = "Default"

        so.so_no                    = sonumber
        so.so_due_date              = so_due_date

        so.buyer                    = party
        so.buyer_gstin              = party_add.gstin
        so.buyer_address1           = party_add.addressline1
        so.buyer_address2           = party_add.addressline2
        so.buyer_address3           = party_add.addressline3
        so.buyer_mailingname        = party_add.mailing_name
        so.buyer_pincode            = party_add.pin_code
        so.buyer_state              = str(party_add.state)
        so.buyer_country            = str(party_add.country)
        so.buyer_city               = str(party_add.city)
        so.buyer_gst_reg_type       = party_add.gst_registration_type

        so.shipto                   = consignee
        so.shipto_mailingname       = shipto_add.mailing_name
        so.shipto_address1          = shipto_add.addressline1
        so.shipto_address2          = shipto_add.addressline2
        so.shipto_address3          = shipto_add.addressline3
        so.shipto_country           = str(shipto_add.country)
        so.shipto_state             = str(shipto_add.state)
        so.shipto_city              = str(shipto_add.city)
        so.shipto_pincode           = shipto_add.pin_code
        so.shipto_gstin             = shipto_add.gstin
        so.shipto_pan_no            = shipto_add.pan_no

        so.price_list               = str(party.price_level)
        so.isscheme                 = isscheme
        so.mode_of_payment          = mode_of_payment
        so.order_no                 = order_no
        so.other_reference          = other_reference
        so.terms_of_delivery        = terms_of_delivery

        ol_rate = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs                = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs                = 0
        other_ledger                = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger            = LedgersType.objects.get(id=other_ledger)
            so.other_ledger         = other_ledger

        if request.POST.get("other"):
            other                   = Decimal(request.POST.get("other"))
        else:
            other                   = Decimal(0)

        so.discount                 = extradiscount
        so.ammount                  = 0
        so.ol_rate                  = ol_rate
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.other                    = 0
        so.total                    = 0
        so.round_off                = 0
        so.bill_qty                 = 0
        so.free_qty                 = 0
        so.narration                = narration
        so.save()

        totalbill_qty               = 0
        totalfree_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        basicammount                = 0
        try:
        
            for i,j in enumerate(product_codelist):
                print(i, "=======", j, "++++++++")
                product             = Product_master.objects.get(product_code=j)
                q = salable(com,product)
                mrp                 = product.mrp
                pack                = product.outer_qty
                offermrp            = Decimal(offermrplist[i])
                actualqty           = Decimal(actualqtylist[i])
                if actualqty > q:
                    actualqty = q
                    if billqty > q:
                        billqty = q
                billqty             = Decimal(billqtylist[i])
                freeqty             = actualqty - billqty
                if so.price_list == 'Manual':
                    rate            = Decimal(ratelist[i])
                else:
                    pl = Price_list.objects.get(product=product, price_level=party.price_level)
                    rate            = pl.rate
                available_qty       = Decimal(stocklist[i])
                discount            = Decimal(discountlist[i])
                amount              = round(((billqty * rate ) * Decimal((1- discount/100))),2)
                ammount             = round((((billqty * rate ) * Decimal(1- discount/100)) * Decimal(1- extradiscount/100)),2)
                igstrate            = product.gst
                cgstrate            = product.gst/2
                sgstrate            = product.gst/2
                igst                = round((ammount * (igstrate / 100)),2)
                cgst                = round((ammount * (cgstrate / 100)),2)
                sgst                = round((ammount * (sgstrate / 100)),2)
                totalbill_qty       += billqty
                totalfree_qty       += freeqty
                basicammount        = basicammount + amount
                totalammount        = totalammount + ammount
                totalcgst           = totalcgst + cgst
                totalsgst           = totalsgst + sgst
                totaligst           = totaligst + igst
                SoItems.objects.create(so=so, item=product, available_qty=available_qty, pack=pack, mrp=mrp, offer_mrp=(offermrp),
                                    igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                        actual_qty=(actualqty), billed_qty=(billqty), free_qty=(freeqty), rate=(rate), discount=(discount), amount=(amount))

        except BaseException as exception:
            print(exception)
            so.delete()
            return redirect('sales:addso')

        so.bill_qty                 = totalbill_qty
        so.free_qty                 = totalfree_qty
        so.ammount                  = round(basicammount,2)
        so.cgst                     = round((totalcgst + (other * ol_rate /200)),2)
        so.sgst                     = round((totalsgst + (other * ol_rate /200)),2)
        so.igst                     = round((totaligst + (other * ol_rate /100)),2)
        so.tcs                      = round(totaltcs,2)
        so.other                    = other
        total                       = totalammount + so.igst + totaltcs + other
        so.total                    = round(total)
        so.round_off                = so.total - total
        so.save()
        # messages.success(request, "Sales Order Created Successfully")
        return redirect('sales:so')

    pricelevels                     = Price_level.objects.all()
    parties                         = Party_master.objects.filter(group__name="Sundry Debtors").order_by('name')
    items                           = Product_master.objects.all()
    ledgers                         = LedgersType.objects.filter(under__name = 'Direct Income')
    company                         = Company.objects.all()
    context                         = {'parties': parties, 'items': items, 'pricelevels': pricelevels, 'sonumber': sonumber, 'company': company, 'ledgers':ledgers}

    return render(request, 'sales/add_so.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales Order Delete', 'Sales Order Update'])
def soedit(request, pk):

    so      = Salesorder.objects.get(pk=pk)
    items   = SoItems.objects.filter(so=so)

    if request.method == 'POST':
        # print(request.POST)
        party_name          = request.POST.get("party_name")
        consignee_name      = request.POST.get("consignee_name")

        if request.POST.get("so_due_date"):
            so_due_date     = request.POST.get("so_due_date")
        else:
            so_due_date     = None

        mode_of_payment     = request.POST.get("mode_of_payment")
        other_reference     = request.POST.get("other_reference")
        order_no            = request.POST.get("order_no")
        terms_of_delivery   = request.POST.get("terms_of_delivery")
        narration           = request.POST.get("narration")

        if request.POST.get("isscheme"):
            isscheme = True
        else:
            isscheme = False

        party_address_type  = request.POST.get("party_address_type")
        consignee_address_type = request.POST.get("consignee_address_type")
        stocklist           = request.POST.getlist('stock')
        actualqtylist       = request.POST.getlist('aqty')
        product_codelist    = request.POST.getlist('product_code')
        offermrplist        = request.POST.getlist("offermrp")
        billqtylist         = request.POST.getlist("billqty")
        ratelist            = request.POST.getlist("rate")
        discountlist        = request.POST.getlist("discount")
        if request.POST.get("extradiscount"):
            extradiscount   = Decimal(request.POST.get("extradiscount"))
        else:
            extradiscount   = 0.0

        print(extradiscount)
        party               = Party_master.objects.get(group__name="Sundry Debtors",name=party_name)
        consignee           = Party_master.objects.get(group__name="Sundry Debtors",name=consignee_name)

        if party_address_type !="Default":
            party_add       = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            so.buyer_address_type = party_add.address_type
        else:
            party_add       = party
            so.buyer_address_type = "Default"
        if consignee_address_type !="Default":
            shipto_add      = Party_contact_details.objects.get(party=consignee, address_type=consignee_address_type )
            so.shipto_address_type = shipto_add.address_type
        else:
            shipto_add      = party
            so.shipto_address_type = "Default"

        so.so_due_date      = so_due_date

        so.buyer                    = party
        so.buyer_gstin              = party_add.gstin
        so.buyer_address1           = party_add.addressline1
        so.buyer_address2           = party_add.addressline2
        so.buyer_address3           = party_add.addressline3
        so.buyer_mailingname        = party_add.mailing_name
        so.buyer_pincode            = party_add.pin_code
        so.buyer_state              = str(party_add.state)
        so.buyer_country            = str(party_add.country)
        so.buyer_city               = str(party_add.city)
        so.buyer_gst_reg_type       = party_add.gst_registration_type

        so.shipto                   = consignee
        so.shipto_mailingname       = shipto_add.mailing_name
        so.shipto_address1          = shipto_add.addressline1
        so.shipto_address2          = shipto_add.addressline2
        so.shipto_address3          = shipto_add.addressline3
        so.shipto_country           = str(shipto_add.country)
        so.shipto_state             = str(shipto_add.state)
        so.shipto_city              = str(shipto_add.city)
        so.shipto_pincode           = shipto_add.pin_code
        so.shipto_gstin             = shipto_add.gstin

        so.price_list               = str(party.price_level)
        so.isscheme                 = isscheme
        so.order_no                 = order_no
        so.mode_of_payment          = mode_of_payment
        so.other_reference          = other_reference
        so.terms_of_delivery        = terms_of_delivery

        ol_rate                     = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs                = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs                = 0
        other_ledger                = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger            = LedgersType.objects.get(id=other_ledger)
            so.other_ledger         = other_ledger
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        so.discount                 = extradiscount

        so.ol_rate                  = ol_rate

        so.narration                = narration
        so.save()

        totalbill_qty               = 0
        totalfree_qty               = 0
        basicammount                = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        SoItems.objects.filter(so=so).delete()
        # try:
        for i,j in enumerate(product_codelist):
            product         = Product_master.objects.get(product_code=j)
            mrp             = product.mrp
            pack            = product.outer_qty
            offermrp        = Decimal(offermrplist[i])
            actualqty       = Decimal(actualqtylist[i])
            billqty         = Decimal(billqtylist[i])
            freeqty         = actualqty - billqty
            if so.price_list == 'Manual':
                rate        = Decimal(ratelist[i])
            else:
                pl = Price_list.objects.get(product=product, price_level=party.price_level)
                rate        = pl.rate

            discount        = Decimal(discountlist[i])
            amount          = round(((billqty * rate ) * Decimal(1- discount/100)),2)
            ammount         = round((amount * Decimal(1- extradiscount/100)),2)

            igstrate        = product.gst
            cgstrate        = product.gst/2
            sgstrate        = product.gst/2
            available_qty   = Decimal(stocklist[i])

            igst            = round((ammount * (igstrate / 100)),2)
            cgst            = round((ammount * (cgstrate / 100)),2)
            sgst            = round((ammount * (sgstrate / 100)),2)

            totalbill_qty   += billqty
            totalfree_qty   += freeqty
            basicammount    = basicammount + amount
            totalammount    = totalammount + ammount
            totalcgst       = totalcgst + cgst
            totalsgst       = totalsgst + sgst
            totaligst       = totaligst + igst

            SoItems.objects.create(so=so, item=product, available_qty=available_qty, pack=pack, mrp=mrp, offer_mrp=(offermrp),
                                igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                    actual_qty=(actualqty), billed_qty=(billqty), free_qty=(freeqty), rate=(rate), discount=(discount), amount=(amount))

        # except BaseException as exception:
        #     print(exception)
        #     so.delete()

        # return redirect('sales:so')

        so.bill_qty     = totalbill_qty
        so.free_qty     = totalfree_qty
        so.ammount      = round(basicammount,2)
        so.cgst         = round((totalcgst + (other * ol_rate /200)),2)
        so.sgst         = round((totalsgst + (other * ol_rate /200)),2)
        so.igst         = round((totaligst + (other * ol_rate /100)),2)
        so.tcs          = round(totaltcs,2)
        so.other        = other
        total           = totalammount + so.igst + totaltcs + other
        so.total        = round(total)
        so.round_off    = so.total - total
        so.save()
        # messages.success(request, "Sales Order Updated Successfully")
        return redirect('sales:so')

    parties = Party_master.objects.filter(group__name="Sundry Debtors")
    products = Product_master.objects.all()
    return render(request, 'sales/edit_so.html', {'parties': parties,'products':items ,'so': so, 'items': products})

@allowed_users(allowed_roles=['Admin', 'Sales Order View', 'Sales Order Delete', 'Sales Order Create', 'Sales Order Update'])
def soshow(request, pk):

    so = Salesorder.objects.get(pk=pk)
    items = SoItems.objects.filter(so=so)

    company = Company.objects.all()
    return render(request, 'sales/show_so.html', {'so': so, 'products': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'Sales Order Delete'])
def socancel(request, pk):

    so      = Salesorder.objects.get(pk=pk)
    so.status = "2"
    so.save()
    return redirect("sales:so")


@allowed_users(allowed_roles=['Admin', 'ECOM Sales Order View', 'ECOM Sales Order Delete', 'ECOM Sales Order Create', 'ECOM Sales Order Update'])
def ecomso(request):

    try:
        skey    = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)
    series      = com.so_series
    so          = Salesorder.objects.filter(company=com, so_no__contains=series).order_by('so_no').last()
    if so:
        sonum       = int(so.so_no[len(series):]) + 1
        sonumber    = series + (str(sonum)).zfill(5)
    else:
        sonumber    = series + '00001'

    if request.method == 'POST':
        party_name                  = request.POST.get("party_name")
        consignee_name              = request.POST.get("consignee_name")

        if request.POST.get("so_due_date"):
            so_due_date             = request.POST.get("so_due_date")
        else:
            so_due_date             = None

        mode_of_payment             = request.POST.get("mode_of_payment")
        other_reference             = request.POST.get("other_reference")
        order_no                    = request.POST.get("order_no")
        terms_of_delivery           = request.POST.get("terms_of_delivery")
        narration                   = request.POST.get("narration")

        if request.POST.get("isscheme"):
            isscheme                = True
        else:
            isscheme                = False

        party_address_type          = request.POST.get("party_address_type")
        consignee_address_type      = request.POST.get("consignee_address_type")

        actualqtylist               = request.POST.getlist('aqty')
        stocklist                   = request.POST.getlist('stock')
        product_codelist            = request.POST.getlist('product_code')
        offermrplist                = request.POST.getlist("offermrp")
        billqtylist                 = request.POST.getlist("billqty")
        ratelist                    = request.POST.getlist("rate")
        discountlist                = request.POST.getlist("discount")

        if request.POST.get("extradiscount"):
            extradiscount           = Decimal(request.POST.get("extradiscount"))
        else:
            extradiscount           = 0.0

        party                       = Party_master.objects.get(id=party_name)
        consignee                   = Party_master.objects.get(id=consignee_name)

        so                          = Salesorder()
        so.company                  = com

        party_add               = party
        so.buyer_address_type   = "Default"

        if consignee_address_type:
            shipto_add              = Party_contact_details.objects.get(party=consignee, address_type=consignee_address_type )
            so.shipto_address_type  = shipto_add.address_type
        else:
            shipto_add              = party
            so.shipto_address_type  = "Default"

        so.so_no                    = sonumber
        so.so_due_date              = so_due_date

        so.buyer                    = party
        so.buyer_gstin              = request.POST.get('party_gstin')
        so.buyer_address1           = request.POST.get('buyer_address1')
        so.buyer_address2           = request.POST.get('buyer_address2')
        so.buyer_address3           = request.POST.get('buyer_address3')
        so.buyer_mailingname        = request.POST.get('buyer_mailingname')
        so.buyer_pincode            = request.POST.get('buyer_pincode')
        so.buyer_state              = State.objects.get(id=request.POST.get('buyer_state')).name
        so.buyer_country            = 'INDIA'
        so.buyer_city               = City.objects.get(id=request.POST.get('buyer_city')).name
        so.buyer_gst_reg_type       = party_add.gst_registration_type

        so.shipto                   = consignee
        so.shipto_mailingname       = request.POST.get('shipto_mailingname')
        so.shipto_address1          = request.POST.get('shipto_address1')
        so.shipto_address2          = request.POST.get('shipto_address2')
        so.shipto_address3          = request.POST.get('shipto_address3')
        so.shipto_country           = 'INDIA'
        so.shipto_state             = State.objects.get(id=request.POST.get('shipto_state')).name
        so.shipto_city              = City.objects.get(id=request.POST.get('shipto_city')).name
        so.shipto_pincode           = request.POST.get('shipto_pincode')
        so.shipto_gstin             = request.POST.get('consignee_gstin')
        so.shipto_pan_no            = shipto_add.pan_no

        so.price_list               = str(party.price_level)
        so.isscheme                 = isscheme
        so.mode_of_payment          = mode_of_payment
        so.order_no                 = order_no
        so.other_reference          = other_reference
        so.terms_of_delivery        = terms_of_delivery

        ol_rate = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs                = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs                = 0
        other_ledger                = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger            = LedgersType.objects.get(id=other_ledger)
            so.other_ledger         = other_ledger

        if request.POST.get("other"):
            other                   = Decimal(request.POST.get("other"))
        else:
            other                   = Decimal(0)

        so.discount                 = extradiscount
        so.ammount                  = 0
        so.ol_rate                  = ol_rate
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.other                    = 0
        so.total                    = 0
        so.round_off                = 0
        so.bill_qty                 = 0
        so.free_qty                 = 0
        so.narration                = narration
        so.save()

        totalbill_qty               = 0
        totalfree_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        basicammount                = 0
        # try:
        for i,j in enumerate(product_codelist):
            product             = Product_master.objects.get(product_code=j,)
            mrp                 = product.mrp
            pack                = product.outer_qty
            offermrp            = Decimal(offermrplist[i])
            actualqty           = Decimal(actualqtylist[i])
            billqty             = Decimal(billqtylist[i])
            freeqty             = actualqty - billqty
            if so.price_list == 'Manual':
                rate            = Decimal(ratelist[i])
            else:
                pl = Price_list.objects.get(product=product, price_level=party.price_level)
                rate            = pl.rate
            available_qty       = Decimal(stocklist[i])
            discount            = Decimal(discountlist[i])
            amount              = round(((billqty * rate ) * Decimal((1- discount/100))),2)
            ammount             = round((((billqty * rate ) * Decimal(1- discount/100)) * Decimal(1- extradiscount/100)),2)
            igstrate            = product.gst
            cgstrate            = product.gst/2
            sgstrate            = product.gst/2
            igst                = round((ammount * (igstrate / 100)),2)
            cgst                = round((ammount * (cgstrate / 100)),2)
            sgst                = round((ammount * (sgstrate / 100)),2)
            totalbill_qty       += billqty
            totalfree_qty       += freeqty
            basicammount        = basicammount + amount
            totalammount        = totalammount + ammount
            totalcgst           = totalcgst + cgst
            totalsgst           = totalsgst + sgst
            totaligst           = totaligst + igst
            SoItems.objects.create(so=so, item=product, available_qty=available_qty, pack=pack, mrp=mrp, offer_mrp=(offermrp),
                                igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                    actual_qty=(actualqty), billed_qty=(billqty), free_qty=(freeqty), rate=(rate), discount=(discount), amount=(amount))
        # except BaseException as exception:
        #     print(exception)
        #     so.delete()
        #     return redirect('sales:addecomso')

        so.bill_qty                 = totalbill_qty
        so.free_qty                 = totalfree_qty
        so.ammount                  = round(basicammount,2)
        so.cgst                     = round((totalcgst + (other * ol_rate /200)),2)
        so.sgst                     = round((totalsgst + (other * ol_rate /200)),2)
        so.igst                     = round((totaligst + (other * ol_rate /100)),2)
        so.tcs                      = round(totaltcs,2)
        so.other                    = other
        total                       = totalammount + so.igst + totaltcs + other
        so.total                    = round(total, 2)
        so.round_off                = so.total - total
        so.save()
        # messages.success(request, "Sales Order Created Successfully")
        return redirect('sales:ecomso')

    pricelevels                     = Price_level.objects.all()
    parties                         = Party_master.objects.filter(group__name="Sundry Debtors").filter(devision__name='ECOM').order_by('name')
    items                           = Product_master.objects.all()
    ledgers                         = LedgersType.objects.filter(under__name = 'Direct Income')
    company                         = Company.objects.all()
    context                         = {'parties': parties, 'items': items, 'pricelevels': pricelevels, 'sonumber': sonumber, 'company': company, 'ledgers':ledgers, 'state': State.objects.all()}

    return render(request, 'sales/add_so_ecom.html', context)

@allowed_users(allowed_roles=['Admin', 'ECOM Sales Order Delete', 'ECOM Sales Order Update'])
def ecomsoedit(request, pk):

    so      = Salesorder.objects.get(pk=pk)
    items   = SoItems.objects.filter(so=so)

    if request.method == 'POST':
        # print(request.POST)
        party_name          = request.POST.get("party_name")
        consignee_name      = request.POST.get("consignee_name")

        if request.POST.get("so_due_date"):
            so_due_date     = request.POST.get("so_due_date")
        else:
            so_due_date     = None

        mode_of_payment     = request.POST.get("mode_of_payment")
        other_reference     = request.POST.get("other_reference")
        order_no            = request.POST.get("order_no")
        terms_of_delivery   = request.POST.get("terms_of_delivery")
        narration           = request.POST.get("narration")

        if request.POST.get("isscheme"):
            isscheme = True
        else:
            isscheme = False

        party_address_type  = request.POST.get("party_address_type")
        consignee_address_type = request.POST.get("consignee_address_type")
        stocklist                   = request.POST.getlist('stock')
        actualqtylist       = request.POST.getlist('aqty')
        product_codelist    = request.POST.getlist('product_code')
        offermrplist        = request.POST.getlist("offermrp")
        billqtylist         = request.POST.getlist("billqty")
        ratelist            = request.POST.getlist("rate")
        discountlist        = request.POST.getlist("discount")

        if request.POST.get("extradiscount"):
            extradiscount   = Decimal(request.POST.get("extradiscount"))
        else:
            extradiscount   = 0.0

        party               = Party_master.objects.get(group__name="Sundry Debtors",name=party_name)
        consignee           = Party_master.objects.get(group__name="Sundry Debtors",name=consignee_name)

        so.so_due_date      = so_due_date

        so.buyer                    = party
        so.buyer_gstin              = request.POST.get('party_gstin')
        so.buyer_address1           = request.POST.get('buyer_address1')
        so.buyer_address2           = request.POST.get('buyer_address2')
        so.buyer_address3           = request.POST.get('buyer_address3')
        so.buyer_mailingname        = request.POST.get('buyer_mailingname')
        so.buyer_pincode            = request.POST.get('buyer_pincode')
        so.buyer_state              = State.objects.get(id=request.POST.get('buyer_state')).name
        so.buyer_country            = 'INDIA'
        so.buyer_city               = City.objects.get(id=request.POST.get('buyer_city')).name

        so.shipto                   = consignee
        so.shipto_mailingname       = request.POST.get('shipto_mailingname')
        so.shipto_address1          = request.POST.get('shipto_address1')
        so.shipto_address2          = request.POST.get('shipto_address2')
        so.shipto_address3          = request.POST.get('shipto_address3')
        so.shipto_country           = 'INDIA'
        so.shipto_state             = State.objects.get(id=request.POST.get('shipto_state')).name
        so.shipto_city              = City.objects.get(id=request.POST.get('shipto_city')).name
        so.shipto_pincode           = request.POST.get('shipto_pincode')
        so.shipto_gstin             = request.POST.get('consignee_gstin')

        so.price_list               = str(party.price_level)
        so.isscheme                 = isscheme
        so.order_no                 = order_no
        so.mode_of_payment          = mode_of_payment
        so.other_reference          = other_reference
        so.terms_of_delivery        = terms_of_delivery

        ol_rate                     = Decimal(request.POST.get("ol_rate"))

        if request.POST.get("totaltcs"):
            totaltcs                = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs                = 0
        other_ledger                = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger            = LedgersType.objects.get(id=other_ledger)
            so.other_ledger         = other_ledger
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        so.discount                 = extradiscount

        so.ol_rate                  = ol_rate

        so.narration                = narration
        so.save()

        totalbill_qty               = 0
        totalfree_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        SoItems.objects.filter(so=so).delete()
        # try:
        for i,j in enumerate(product_codelist):
            product         = Product_master.objects.get(product_code=j)
            mrp             = product.mrp
            pack            = product.outer_qty
            offermrp        = Decimal(offermrplist[i])
            actualqty       = Decimal(actualqtylist[i])
            billqty         = Decimal(billqtylist[i])
            freeqty         = actualqty - billqty
            if so.price_list == 'Manual':
                rate        = Decimal(ratelist[i])
            else:
                pl = Price_list.objects.get(product=product, price_level=party.price_level)
                rate        = pl.rate

            discount        = Decimal(discountlist[i])
            amount          = round(((billqty * rate ) * Decimal(1- discount/100)),2)
            ammount         = round((((billqty * rate ) * Decimal(1- discount/100)) * Decimal(1- extradiscount/100)),2)

            igstrate        = product.gst
            cgstrate        = product.gst/2
            sgstrate        = product.gst/2
            available_qty   = Decimal(stocklist[i])

            igst            = round((ammount * (igstrate / 100)),2)
            cgst            = round((ammount * (cgstrate / 100)),2)
            sgst            = round((ammount * (sgstrate / 100)),2)

            totalbill_qty   += billqty
            totalfree_qty   += freeqty
            totalammount    = totalammount + amount
            totalcgst       = totalcgst + cgst
            totalsgst       = totalsgst + sgst
            totaligst       = totaligst + igst

            SoItems.objects.create(so=so, item=product, available_qty=available_qty, pack=pack, mrp=mrp, offer_mrp=(offermrp),
                                igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                    actual_qty=(actualqty), billed_qty=(billqty), free_qty=(freeqty), rate=(rate), discount=(discount), amount=(amount))

        # except BaseException as exception:
        #     print(exception)
        #     so.delete()

        # return redirect('sales:so')

        so.bill_qty     = totalbill_qty
        so.free_qty     = totalfree_qty
        so.ammount      = round(totalammount,2)
        so.cgst         = round((totalcgst + (other * ol_rate /200)),2)
        so.sgst         = round((totalsgst + (other * ol_rate /200)),2)
        so.igst         = round((totaligst + (other * ol_rate /100)),2)
        so.tcs          = round(totaltcs,2)
        so.other        = other
        total           = so.ammount + so.igst + totaltcs + other
        so.total        = round(total, 2)
        so.round_off    = so.total - total
        so.save()
        # messages.success(request, "Sales Order Updated Successfully")
        return redirect('sales:ecomso')

    parties = Party_master.objects.filter(group__name="Sundry Debtors").filter(devision__name='ECOM')
    products = Product_master.objects.all()
    buyercity = City.objects.filter(state__name=so.buyer_state)
    consigneecity = City.objects.filter(state__name=so.shipto_state)
    return render(request, 'sales/edit_so_ecom.html', {'parties': parties,'products':items ,'so': so, 'items': products, 'state': State.objects.all(), 'buyercity': buyercity, 'consigneecity': consigneecity})

@allowed_users(allowed_roles=['Admin', 'ECOM Sales Order View', 'ECOM Sales Order Delete', 'ECOM Sales Order Create', 'ECOM Sales Order Update'])
def ecomsoshow(request, pk):

    so = Salesorder.objects.get(pk=pk)
    items = SoItems.objects.filter(so=so)

    company = Company.objects.all()
    return render(request, 'sales/show_so_ecom.html', {'so': so, 'products': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'ECOM Sales Order Delete'])
def ecomsocancel(request, pk):

    so      = Salesorder.objects.get(pk=pk)
    so.status = "2"
    so.save()
    return redirect("sales:ecomso")

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Sales Order View', 'Sales Order Delete', 'Sales Order Create', 'Sales Order Update']), name='dispatch')
class solist(ListView):
    model = Salesorder
    template_name = 'sales/sales_order.html'
    context_object_name = 'sos'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Salesorder.objects.filter(company=self.request.META['com']).order_by('-so_date','-so_no')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(so_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'ECOM Sales Order View', 'ECOM Sales Order Delete', 'ECOM Sales Order Create', 'ECOM Sales Order Update']), name='dispatch')
class ecomsolist(ListView):
    model = Salesorder
    template_name = 'sales/ecom_sales_order.html'
    context_object_name = 'sos'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Salesorder.objects.filter(company=self.request.META['com'],buyer__devision__name = 'ECOM').order_by('-so_date','-so_no')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(so_no__icontains=query) )
        return qs

# ____________________________________________________________________________________Delivery Note____________________

@allowed_users(allowed_roles=['Admin', 'Delivery Note Delete', 'Delivery Note Create', 'Delivery Note Update'])
def dn(request):

    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(id=skey)
    series = com.dn_series
    dn = Delivery_note.objects.filter(company=com, dn_no__contains=series).order_by('dn_no').last()
    if dn:
        sonum = int(dn.dn_no[len(series):]) + 1
        dnnumber = series + (str(sonum)).zfill(5)
    else:
        dnnumber = series + '00001'

    if request.method == 'POST':

        so_no = request.POST.get("so_no")
        so = Salesorder.objects.get(company=com,so_no=so_no)

        dispatch_doc_no = request.POST.get("dispatch_doc_no")
        dispatch_through = request.POST.get("dispatch_through")
        destintaion = request.POST.get("destintaion")
        carrier_agent = request.POST.get("carrier_agent")
        vehical_no = request.POST.get("vehical_no")

        lr_no = request.POST.get("lr_no")
        if request.POST.get("lr_date"):
            lr_date = request.POST.get("lr_date")
        else:
            lr_date = None

        narration = request.POST.get("narration")

        dn                  = Delivery_note()
        dn.sales_order      = so
        dn.company          = so.company
        dn.dn_no            = dnnumber

        dn.buyer            = so.buyer
        dn.buyer_address_type = so.buyer_address_type
        dn.buyer_address1   = so.buyer_address1
        dn.buyer_address2   = so.buyer_address2
        dn.buyer_address3   = so.buyer_address3
        dn.buyer_gstin      = so.buyer_gstin
        dn.buyer_state      = so.buyer_state
        dn.buyer_country    = so.buyer_country
        dn.buyer_city       = so.buyer_city
        dn.buyer_gst_reg_type = so.buyer_gst_reg_type
        dn.buyer_mailingname = so.buyer_mailingname
        dn.buyer_pincode = so.buyer_pincode

        dn.shipto_country   =   so.shipto_country
        dn.shipto_state =   so.shipto_state
        dn.shipto_city  =   so.shipto_city
        dn.shipto_mailingname   =   so.shipto_mailingname
        dn.shipto            =   so.shipto
        dn.shipto_address_type = so.shipto_address_type
        dn.shipto_address1 = so.shipto_address1
        dn.shipto_address2 = so.shipto_address2
        dn.shipto_address3 = so.shipto_address3
        dn.shipto_gstin = so.shipto_gstin
        dn.shipto_pincode = so.shipto_pincode
        dn.shipto_pan_no = so.shipto_pan_no
        dn.price_list       = so.price_list
        dn.discount         = so.discount
        dn.mode_of_payment  = so.mode_of_payment
        dn.other_reference  = so.other_reference
        dn.terms_of_delivery= so.terms_of_delivery
        dn.order_no         = so.order_no

        dn.ammount          = so.ammount
        dn.other            = so.other
        dn.other_ledger     = so.other_ledger
        dn.ol_rate          = so.ol_rate
        dn.cgst             = so.cgst
        dn.igst             = so.igst
        dn.sgst             = so.sgst
        dn.tcs              = so.tcs
        dn.round_off        = so.round_off
        dn.total            = so.total


        dn.dispatch_doc_no  = dispatch_doc_no
        dn.dispatch_through = dispatch_through
        dn.destintaion      = destintaion
        dn.carrier_agent    = carrier_agent
        dn.lr_no            = lr_no
        dn.lr_date          = lr_date
        dn.vehical_no       = vehical_no
        dn.narration        = narration
        dn.bill_qty         = so.bill_qty
        dn.free_qty         = so.free_qty
        dn.save()

        items = SoItems.objects.filter(so=so)
        try:
            for i in items:
                item            = i.item
                mrp             = i.mrp
                pack            = i.pack
                available_qty   = i.available_qty
                offermrp        = i.offer_mrp
                actualqty       = i.actual_qty
                billqty         = i.billed_qty
                freeqty         = i.free_qty
                rate            = i.rate
                igst            = i.igst
                cgst            = i.cgst
                sgst            = i.sgst
                igstrate        = i.igstrate
                cgstrate        = i.cgstrate
                sgstrate        = i.sgstrate
                discount        = i.discount
                ammount         = i.amount
                bkey            = 'b'+str(i.item)
                batch           = request.POST.getlist(bkey)
                gkey            = 'g'+str(i.item)
                godowns         = request.POST.getlist(gkey)
                qkey            = 'q'+str(i.item)
                qtys            = request.POST.getlist(qkey)

                dngodowns       = []

                for x, g in enumerate(godowns):
                    gd  = Godown.objects.get(name=g)
                    dngodowns.append(gd)
                    qty =    Decimal(qtys[x])
                    st  = Stock_summary.objects.filter(company=dn.company, product=i.item, godown=gd, closing_balance__gt=0)
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

                    LoadingSheet.objects.create(company=dn.company, dn=dn, item=i.item, prate=prate, mrp=mrp, batch=batch[x], offermrp=offermrp, godown=g, qty=Decimal(qtys[x]))
                item    =   DnItems.objects.create(dn=dn, item=item, pack=pack, available_qty=available_qty, prate=prate,
                                mrp=mrp, offer_mrp=Decimal(offermrp), actual_qty=Decimal(actualqty), billed_qty=Decimal(billqty),
                                igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),
                                free_qty=Decimal(freeqty), rate=Decimal(rate), discount=Decimal(discount), amount=Decimal(ammount))
                item.godown.add(*dngodowns)
                dn.save()
            so.status = '3'
            so.save()
        except BaseException as exp:
            ls = LoadingSheet.objects.filter(dn=dn)
            DnItems.objects.filter(dn=dn).delete()
            dn.delete()
            return redirect("sales:adddn")
        messages.success(request, "Debit Note Created Successfully")
        return redirect("sales:dn")
    so = Salesorder.objects.filter( company=com, dn__isnull=True, status='1')
    context = {'sos': so, 'dnnumber': dnnumber}

    return render(request, 'sales/add_dn.html', context)

@allowed_users(allowed_roles=['Admin', 'Delivery Note Delete', 'Delivery Note Update'])
def dnedit(request, pk):

    dn      = Delivery_note.objects.get(pk=pk)
    dnitems = DnItems.objects.filter(dn=dn)

    if request.POST:

        totalbill_qty               = 0
        totalfree_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        basicammount                = 0

        items = LoadingSheet.objects.filter(company=dn.company, dn=dn)
        for i in items:
            gd = Godown.objects.get(name=i.godown)
            new =Stock_summary.objects.filter(company=i.company, godown=gd, mrp=i.mrp,batch=i.batch, rate=i.prate, product=i.item)
            if new:
                new[0].closing_balance += i.qty
                new[0].save()
            else:
                Stock_summary.objects.create(company=i.company, godown=gd, mrp=i.mrp,batch=i.batch, rate=i.prate, product=i.item,closing_balance = i.qty)
        items.delete()
        for i in dnitems:

            tkey            = 't'+str(i.id)
            total           = request.POST.get(tkey)
            if Decimal(total) <= 0:
                i.delete()
                continue
            i.actual_qty    = Decimal(total)
            zkey            = 'z'+str(i.id)
            billqty         = request.POST.get(zkey)
            i.billed_qty    = Decimal(billqty)
            i.free_qty      = i.actual_qty - i.billed_qty

            i.amount        = round(((i.billed_qty * i.rate ) * Decimal(1- i.discount/100)),2)
            ammount         = round(((i.billed_qty * i.rate ) * Decimal(1- i.discount/100)) * Decimal(1- dn.discount/100),2)
            i.igst          = round((ammount * (i.igstrate / 100)),2)
            i.cgst          = round((ammount * (i.cgstrate / 100)),2)
            i.sgst          = round((ammount * (i.sgstrate / 100)),2)

            totalbill_qty       += i.billed_qty
            totalfree_qty       += i.free_qty
            basicammount        = basicammount + i.amount
            totalammount        = totalammount + ammount
            totalcgst           = totalcgst + i.cgst
            totalsgst           = totalsgst + i.sgst
            totaligst           = totaligst + i.igst
            i.save()

            bkey            = 'b'+str(i.id)
            batch           = request.POST.getlist(bkey)
            gkey            = 'g'+str(i.id)
            godowns         = request.POST.getlist(gkey)
            qkey            = 'q'+str(i.id)
            qtys            = request.POST.getlist(qkey)

            for x, g in enumerate(godowns):
                gd  = Godown.objects.get(name=g)
                qty = Decimal(qtys[x])
                st  = Stock_summary.objects.filter(company=dn.company, product=i.item, godown=gd)
                LoadingSheet.objects.create(company=dn.company, dn=dn, item=i.item,prate=i.prate, mrp=i.mrp, batch=st[0].batch, offermrp=i.offer_mrp, godown=g, qty=qtys[x])
                for st1 in st:
                    if qty >= st1.closing_balance:
                        qty -= st1.closing_balance
                        st1.closing_balance=0
                        st1.delete()
                    else:
                        st1.closing_balance -= qty
                        st1.save()
                        break

        dn.ammount                  = round(basicammount,2)
        dn.bill_qty                 = totalbill_qty
        dn.free_qty                 = totalfree_qty
        dn.cgst                     = round((totalcgst + (dn.other * dn.ol_rate /200)),2)
        dn.sgst                     = round((totalsgst + (dn.other * dn.ol_rate /200)),2)
        dn.igst                     = round((totaligst + (dn.other * dn.ol_rate /100)),2)
        dn.tcs                      = round(dn.tcs,2)
        dn.other                    = round(dn.other,2)
        total                       = totalammount + dn.igst + dn.other
        if dn.tcs > 0:
            dn.tcs = total * Decimal(0.001)
            total = total + dn.tcs
        dn.total                    = round(total)
        dn.round_off                = dn.total - round(total, 2)
        dn.save()
        messages.success(request, "Debit Note Updated Successfully")
        return redirect("sales:dn")
    items = list(dnitems.values('item_id','id','item__product_code','item__product_name','mrp','offer_mrp','pack','available_qty','actual_qty','billed_qty','free_qty','rate','discount','amount','cgstrate','sgstrate','igstrate','cgst','igst','sgst'))
    for i in items:
        a           = list(LoadingSheet.objects.filter(company=dn.company, dn=dn, item=i['item_id'], mrp=i['mrp']).values("batch","godown").annotate(qty=Sum('qty')))
        batch       = Stock_summary.objects.filter(company=dn.company,product=i['item_id'], godown__godown_type=True).order_by('batch')
        i['gds']    = batch
        i['gd']     = a
    return render(request, 'sales/edit_dn.html', {'dn': dn, 'items': items})

@allowed_users(allowed_roles=['Admin', 'Sales Pro Forma Invoice Delete', 'Sales Pro Forma Invoice Update'])
def proformaedit(request, pk):

    inv         = ProformaInvoice.objects.get(pk=pk)
    invitems    = ProformaInvItems.objects.filter(inv=inv).order_by('item__product_code')

    if request.POST:
        billqtylist         = request.POST.getlist("billqty")
        actualqtylist       = request.POST.getlist('aqty')
        extradiscount       = Decimal(request.POST.get('extradiscount'))

        totalbill_qty               = 0
        totalfree_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        basicammount                = 0
        mrpvalue                = 0
        omrpvalue               = 0

        godown = Godown.objects.get(name="PROFORMA CUT")
        batch = date.today().strftime("%y%m%d") + str(ProformaInvoice.objects.count()).zfill(6)
        for i,j in enumerate(invitems):
            actualqty       = Decimal(actualqtylist[i])
            billqty         = Decimal(billqtylist[i])
            freeqty         = actualqty - billqty
            if actualqty <=0:
                Stock_summary.objects.create(company=inv.company, closing_balance=j.actual_qty,godown=godown, mrp=j.mrp, rate=j.rate, product=j.item, batch=batch)
                j.delete()
                continue
            if actualqty < j.actual_qty:
                qty = j.actual_qty - actualqty
                Stock_summary.objects.create(company=inv.company, closing_balance=qty,godown=godown, mrp=j.mrp, rate=j.rate, product=j.item, batch=batch)

            j.amount        = round(((billqty * j.rate ) * (1- j.discount/100)),2)
            ammount         = round((((billqty * j.rate ) * (1- j.discount/100)) * (1- extradiscount/100)),2)

            j.billed_qty    = billqty
            j.actual_qty    = actualqty
            j.free_qty      = freeqty

            j.igst          = round((ammount * (j.igstrate / 100)),2)
            j.cgst          = round((ammount * (j.cgstrate / 100)),2)
            j.sgst          = round((ammount * (j.sgstrate / 100)),2)

            j.save()
            totalbill_qty   += billqty
            totalfree_qty   += freeqty

            mrpvalue            += Decimal(j.mrp * j.billqty)
            omrpvalue           += Decimal(j.offer_mrp * billqty)

            basicammount    = (basicammount + j.amount)
            totalammount    = (totalammount + ammount)
            totalcgst       = (totalcgst + j.cgst)
            totalsgst       = (totalsgst + j.sgst)
            totaligst       = (totaligst + j.igst)

        inv.discount     = extradiscount

        inv.ammount      = round(basicammount,2)
        inv.bill_qty     = totalbill_qty
        inv.free_qty     = totalfree_qty
        inv.mrpvalue     = mrpvalue
        inv.omrpvalue    = omrpvalue
        inv.cgst         = round((totalcgst + (inv.other * inv.ol_rate /200)),2)
        inv.sgst         = round((totalsgst + (inv.other * inv.ol_rate /200)),2)
        inv.igst         = round((totaligst + (inv.other * inv.ol_rate /100)),2)
        total            = totalammount + inv.igst + inv.other
        if inv.tcs > 0:
            inv.tcs = total * Decimal(0.001)
            total = total + inv.tcs
        inv.total        = round(total)
        inv.round_off    = inv.total - round(total, 2)
        inv.save()

        messages.success(request, "Proforma Invoice Updated Successfully")
        return redirect("sales:proformainv")

    return render(request, 'sales/edit_proforma.html', {'dn': inv, 'items': invitems})

@allowed_users(allowed_roles=['Admin', 'Delivery Note Delete', 'Delivery Note Create', 'Delivery Note Update', 'Delivery Note View'])
def dnshow(request, pk):

    dn = Delivery_note.objects.get(pk=pk)
    items = list(DnItems.objects.filter(dn=dn).values('item_id','mrp','available_qty','offer_mrp','actual_qty','pack','billed_qty','free_qty','rate','discount','amount','igstrate','item__product_code','item__product_name'))
    for i in items:
        a=list(LoadingSheet.objects.filter( company=dn.company, dn=dn, item=i['item_id'], mrp=i['mrp']).values('godown','qty'))
        i['gd'] = a
    return render(request, 'sales/show_dn.html', {'pk': pk, 'dn': dn, 'items': items})

@allowed_users(allowed_roles=['Admin', 'Delivery Note Delete'])
def dncancel(request,pk):

    dn = Delivery_note.objects.get(pk=pk)
    items = LoadingSheet.objects.filter(company=dn.company, dn=dn)
    for i in items:
        gd = Godown.objects.get(name=i.godown)
        new =Stock_summary.objects.filter(company=i.company, godown=gd, mrp=i.mrp, rate=i.prate, product=i.item, batch=i.batch)
        if new:
            new[0].closing_balance += i.qty
            new[0].save()
        else:
            Stock_summary.objects.create(company=i.company, godown=gd, mrp=i.mrp, rate=i.prate, product=i.item,closing_balance = i.qty, batch=i.batch)

    dn.status = "2"
    dn.other_reference = str(dn.sales_order)
    so = Salesorder.objects.get(id=dn.sales_order.id)
    so.status = '1'
    so.save()
    dn.sales_order = None
    dn.save()
    messages.success(request, "Debit Note Cancelled Successfully")
    return redirect("sales:dn")

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Delivery Note Delete', 'Delivery Note Create', 'Delivery Note Update', 'Delivery Note View']), name='dispatch')
class dnlist(ListView):
    model = Delivery_note
    template_name = 'sales/delivery_note.html'
    context_object_name = 'dns'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Delivery_note.objects.filter(company=self.request.META['com']).order_by('-dn_date','-dn_no')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(dn_no__icontains=query) | Q(sales_order__so_no__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'Loading Sheet View'])
def ls(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)
    dn  = Delivery_note.objects.filter(status='1', company=com).order_by('ls_status','-dn_no')
    query = request.GET.get('q', None)
    if query is not None:
        dn=dn.filter( Q(buyer__name__icontains=query) | Q(dn_no__icontains=query) )

    context = {'dns': dn[:100]}

    return render(request, 'sales/loading.html', context)


def lspdf(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)

    if request.method == 'POST':
        template = 'sales/ls.html'
        header_template = 'header.html'
        footer_template = 'footer.html'
        ls = LoadingSheet.objects.none()
        dnlist = request.POST.getlist('ls')
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

        for j in dnlist:
            dn = Delivery_note.objects.get(pk=j)
            dn.ls_status = True

            dn.save()
            l = LoadingSheet.objects.filter(dn=dn)
            ls = ls | l

        ls  = ls.values("dn__dn_no","offermrp","mrp","item__article_code","item__product_name","item__product_code","item__inner_qty","godown").annotate(qty=Sum('qty'))

        context = {'ls': ls.order_by(
            "godown"), 'company': com, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
        # return PDFTemplateResponse(request=request, context=context, template=template,footer_template=footer_template,header_template=header_template, filename='loadingsheet.pdf', cmd_options=cmd_options)
        return render(request, 'sales/ls.html', context)

# @allowed_users(allowed_roles=['Admin', 'Packing Sheet Delete', 'Packing Sheet Create', 'Packing Sheet Update', 'Packing Sheet View'])
# def ps(request):

#     try:
#         skey = (request.session.get('skey').get('company').get('id'))
#     except:
#         return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

#     com = Company.objects.get(pk=skey)
#     ps = Delivery_note.objects.filter(company=com, ps_status = True)
#     query = request.GET.get('q', None)
#     if query is not None:
#         ps=ps.filter( Q(buyer__name__icontains=query) | Q(dn_no__icontains=query) )

#     context = {'dns': ps}

#     return render(request, 'sales/packing.html', context)


@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Packing Sheet Delete', 'Packing Sheet Create', 'Packing Sheet Update', 'Packing Sheet View']), name='dispatch')
class pslist(ListView):
    model = Delivery_note
    template_name = 'sales/packing.html'
    context_object_name = 'dns'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Delivery_note.objects.filter(company=self.request.META['com'], ps_status = True).order_by('-dn_no')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(dn_no__icontains=query)  )
        return qs



@allowed_users(allowed_roles=['Admin', 'Packing Sheet Delete', 'Packing Sheet Update'])
def editps(request, pk):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)
    ps = PackingSheet.objects.filter(company=com)
    context = {'dns': ps}

    return render(request, 'sales/packing.html', context)

@allowed_users(allowed_roles=['Admin', 'Packing Sheet Delete', 'Packing Sheet Create', 'Packing Sheet Update'])
def addps(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)

    if request.method == 'POST':
        print(request.POST)
        dn_no               = request.POST.get('dn_no')
        products            = request.POST.getlist('product')
        fno                 = request.POST.getlist('fno')
        tno                 = request.POST.getlist('tno')
        remark               = request.POST.getlist('remark')
        total               = request.POST.get('total')

        dn                  = Delivery_note.objects.get(dn_no=dn_no, company=com)
        dn.ps_status        = True
        dn.save()
        for i,pd in enumerate(products):

            item            = Product_master.objects.get(product_code=pd)
            dnitem          = DnItems.objects.get(dn=dn,item=item)
            PackingSheet.objects.create(company = dn.company, dn=dn, item=item, mrp=item.mrp, offermrp=dnitem.offer_mrp ,qty=dnitem.actual_qty,remarks=remark[i],
                                        from_box=int(fno[i]), to_box=int(tno[i]), total_box=int(total))

        return redirect('sales:ps')
    dn = Delivery_note.objects.filter(ps_status=False, ls_status=True, company=com).order_by("-dn_no")

    context = {'dns': dn}

    return render(request, 'sales/add_ps.html', context)

def pspdf(request,pk):

    if request.method == 'GET':
        template = 'sales/ps.html'
        header_template = 'header.html'
        footer_template = 'footer.html'
        dn = Delivery_note.objects.get(id=pk)
        ls = PackingSheet.objects.filter(dn=dn).order_by('total_box')
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

        com = Company.objects.get(pk=dn.company.id)
        context = {'ls': ls, 'company': com, 'date': date.today()}
        return PDFTemplateResponse(request=request, context=context, template=template, header_template=header_template, footer_template=footer_template, filename='loadingsheet.pdf', cmd_options=cmd_options)




from num2words import num2words
# ____________________________________________________________________________________________________Invoice_______________
def invpdf(request,pk):
    template = 'sales/invpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    inv = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(inv=inv)
    total = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '287mm',
        'page-width': '200mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.inv_no)+'.pdf', cmd_options=cmd_options)
    # return render(request, 'sales/invpdf.html', context)

import reportlab
import io
from django.http import FileResponse
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm
def invpdf2(request,pk):
    buffer = io.BytesIO()

    # Create the PDF object, using the buffer as its "file."
    p = canvas.Canvas(buffer,pagesize=A4)
    width, height = A4[0],A4[1]
    # Draw things on the PDF. Here's where the PDF generation happens.
    # See the ReportLab documentation for the full list of functionality.
    p.rect(10*mm, 10*mm, width-20*mm, height-20*mm, stroke=1, fill=0)
    p.drawString(10*mm, 282*mm, "Hello there.{}".format(pk))

    # Close the PDF object cleanly, and we're done.
    p.showPage()
    p.save()

    # FileResponse sets the Content-Disposition header so that browsers
    # present the option to save the file.
    buffer.seek(0)
    return FileResponse(buffer, as_attachment=True, filename='hello.pdf')


def proformainvpdf(request,pk):

    template = 'sales/proformainvpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    inv = ProformaInvoice.objects.get(pk=pk)
    items = ProformaInvItems.objects.filter(inv=inv, actual_qty__gt=0)
    total = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.inv_no)+'.pdf', cmd_options=cmd_options)
    # return render(request, 'sales/proformainvpdf.html', context)

def sopdf(request,pk):

    template = 'sales/sopdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    inv = Salesorder.objects.get(pk=pk)
    items = SoItems.objects.filter(so=inv)
    total = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.so_no)+'.pdf', cmd_options=cmd_options)
    # return render(request, 'sales/sopdf.html', context)


@allowed_users(allowed_roles=['Admin', 'Sales Invoice Email'])
def mailinv(request, pk):

    inv = Invoice.objects.get(pk=pk)
    attachname = str(inv.buyer)+'-'+str(inv.inv_no)+'.pdf'
    attach = invpdf(request, pk)
    email = inv.buyer.email_id
    email_cc = inv.buyer.cc_email.split(',')
    send_email(request,email,email_cc,"Sales Invoice",attach, attachname)
    inv.status = '4'
    inv.save()
    return redirect('sales:inv')

@allowed_users(allowed_roles=['Admin', 'Sales Proforma Invoices Email'])
def mailproformainv(request, pk):

    inv = ProformaInvoice.objects.get(pk=pk)
    attachname = str(inv.buyer)+'-'+str(inv.inv_no)+'.pdf'
    attach = proformainvpdf(request, pk)
    email = inv.buyer.email_id
    email_cc = inv.buyer.cc_email.split(',')
    send_email(request,email,email_cc,"Sales Pro forma Invoice",attach, attachname)
    inv.status = '4'
    inv.save()
    return redirect('sales:proformainv')

@allowed_users(allowed_roles=['Admin', 'Sales Order Email'])
def mailso(request, pk):

    inv = Salesorder.objects.get(pk=pk)
    attachname = str(inv.buyer)+'-'+str(inv.so_no)+'.pdf'
    attach = sopdf(request, pk)
    email = inv.buyer.email_id
    email_cc = inv.buyer.cc_email.split(',')
    send_email(request,email,email_cc,"Sales Order",attach, attachname)
    return redirect('sales:so')

def cnpdf(request,pk):

    template = 'sales/cnpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    inv = CreditNote.objects.get(pk=pk)
    items = CreditNoteItems.objects.filter(inv=inv, rate__gt=0)
    total = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.cn_no)+'.pdf', cmd_options=cmd_options)
    # return render(request, 'sales/cnpdf.html', context)

@allowed_users(allowed_roles=['Admin', 'Credit Note Email'])
def mailcn(request, pk):

    cn = CreditNote.objects.get(pk=pk)
    attachname = str(cn.buyer)+'-'+str(cn.cn_no)+'.pdf'
    attach = cnpdf(request, pk)
    email = cn.buyer.email_id
    email_cc = cn.buyer.cc_email.split(',')
    cn.status = '4'
    cn.save()
    send_email(request,email,email_cc,"CREDITNOTE",attach, attachname)
    return redirect('sales:cn')

def qdnpdf(request,pk):


    template = 'sales/qdnpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    inv = Qdn.objects.get(pk=pk)
    items = QdnItems.objects.filter(inv=inv, billed_qty__gt=0)
    total = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.qdn_no)+'.pdf', cmd_options=cmd_options)
    # return render(request, 'sales/qdnpdf.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales QDN Email'])
def mailqdn(request, pk):

    qdn = Qdn.objects.get(pk=pk)
    attachname = str(qdn.buyer)+'-'+str(qdn.qdn_no)+'.pdf'
    attach = qdnpdf(request, pk)
    email = qdn.buyer.email_id
    email_cc = qdn.buyer.cc_email.split(',')
    qdn.status = '4'
    qdn.save()
    send_email(request,email,email_cc,"QDN",attach, attachname)
    return redirect('sales:qdn')

def rsopdf(request,pk):

    inv             = Rso.objects.get(pk=pk)
    if inv.is_cm or inv.is_ivt:
        template        = 'sales/ivtpdf.html'
    else:
        template        = 'sales/rsopdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    items           = RsoItems.objects.filter(inv=inv,billed_qty__gt=0)
    total           = num2words(inv.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': inv,'items':items, 'company': com,'total':total, 'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(inv.buyer)+'-'+str(inv.rso_no)+'.pdf', cmd_options=cmd_options)

@allowed_users(allowed_roles=['Admin', 'Return Sales Order Email', 'Credit Memo Email'])
def mailrso(request, pk):

    rso = Rso.objects.get(pk=pk)
    attachname = str(rso.buyer)+'-'+str(rso.rso_no)+'.pdf'
    attach = rsopdf(request, pk)
    email = rso.buyer.email_id
    email_cc = rso.buyer.cc_email.split(',')
    qdn.status = '4'
    qdn.save()
    send_email(request,email,email_cc,"RETURN SALES ORDER",attach, attachname)


def dnpdf(request,pk):

    template = 'sales/dnpdf.html'
    header_template = 'header.html'
    footer_template = 'footer.html'
    dn = Delivery_note.objects.get(pk=pk)
    items = DnItems.objects.filter(dn=dn)
    totals = items.aggregate(billed_total=Sum('billed_qty'),free_total = Sum('free_qty'))
    total = num2words(dn.total , to="currency",currency="INR", lang="en_IN")
    cmd_options = {
        'page-size': 'A4',
        'margin-top': '0',
        'margin-right': '0',
        'margin-bottom': '0',
        'margin-left': '0',
        'page-height': '297mm',
        'disable-smart-shrinking':True,
        'footer-center': "[page] of [toPage]",
        'encoding': "UTF-8",
        'no-outline': None,
        'quiet': None, 'enable-local-file-access': True, 'disable-javascript': False}

    com = Company.objects.get(pk=1)
    context = {'inv': dn,'items':items, 'company': com,'total':total,'totals':totals ,'date': datetime.now().strftime("%m/%d/%Y, %H:%M:%S")}
    # return PDFTemplateResponse(request=request, context=context, template=template,header_template=header_template,footer_template=footer_template, filename=str(dn.dn_no)+'.pdf', cmd_options=cmd_options)
    return render(request, 'sales/dnpdf.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales Invoice Delete', 'Sales Invoice Create', 'Sales Invoice Update'])
def inv(request):

    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(id=skey)
    series = com.inv_series
    inv = Invoice.objects.filter(company=com, inv_no__contains=series).order_by('inv_no').last()
    if inv:
        sonum = int(inv.inv_no[len(series):]) + 1
        dnnumber = series + (str(sonum)).zfill(5)
    else:
        dnnumber = series + '00001'

    if request.method == 'POST':

        dn_no                   = request.POST.get("dn_no")
        inv = Invoice()
        if 'PI' in dn_no:
            dn                  = ProformaInvoice.objects.get(company=com,inv_no=dn_no)
            dnitems             = ProformaInvItems.objects.filter(inv=dn)
            inv.dn              = dn.dn

        else:
            dn                  = Delivery_note.objects.get(company=com,dn_no=dn_no)
            dnitems             = DnItems.objects.filter(dn=dn)
            inv.dn              = dn

        narration               = request.POST.get("narration")
        inv.company             = dn.company
        inv.inv_no              = dnnumber
        inv.price_list          = dn.price_list

        inv.division            = str(dn.buyer.devision)
        inv.channel             = str(dn.buyer.party_type)

        inv.buyer               = dn.buyer
        inv.buyer_mailingname   = dn.buyer_mailingname
        inv.buyer_address_type  = dn.buyer_address_type
        inv.buyer_address1      = dn.buyer_address1
        inv.buyer_address2      = dn.buyer_address2
        inv.buyer_address3      = dn.buyer_address3
        inv.buyer_gstin         = dn.buyer_gstin
        inv.buyer_state         = dn.buyer_state
        inv.buyer_pincode       = dn.buyer_pincode
        inv.buyer_gst_reg_type  = dn.buyer_gst_reg_type
        inv.buyer_country       = dn.buyer_country
        inv.buyer_city          = dn.buyer_city

        inv.shipto              = dn.shipto
        inv.shipto_mailingname  = dn.shipto_mailingname
        inv.shipto_address_type = dn.shipto_address_type
        inv.shipto_address1     = dn.shipto_address1
        inv.shipto_address2     = dn.shipto_address2
        inv.shipto_address3     = dn.shipto_address3
        inv.shipto_gstin        = dn.shipto_gstin
        inv.shipto_pincode      = dn.shipto_pincode

        inv.shipto_state        = dn.shipto_state
        inv.shipto_country      = dn.shipto_country
        inv.shipto_city         = dn.shipto_city
        inv.mode_of_payment     = dn.mode_of_payment
        inv.other_reference     = dn.other_reference
        inv.terms_of_delivery   = dn.terms_of_delivery
        inv.order_no            = dn.order_no

        inv.dispatch_doc_no     = dn.dispatch_doc_no
        inv.dispatch_through    = dn.dispatch_through
        inv.destination         = dn.destintaion
        inv.carrier_agent       = dn.carrier_agent
        inv.carrier_agent_id    = dn.carrier_agent_id
        inv.lr_no               = dn.lr_no
        inv.lr_date             = dn.lr_date
        inv.vehical_no          = dn.vehical_no
        inv.order_no            = dn.order_no
        inv.ammount             = dn.ammount
        inv.cgst                = dn.cgst
        inv.other               = dn.other
        inv.other_ledger        = dn.other_ledger
        inv.ol_rate             = dn.ol_rate
        inv.igst                = dn.igst
        inv.sgst                = dn.sgst
        inv.tcs                 = dn.tcs
        inv.round_off           = dn.round_off
        inv.total               = dn.total
        inv.discount            = dn.discount

        inv.bill_qty            = dn.bill_qty
        inv.free_qty            = dn.free_qty
        inv.mrpvalue            = 0
        inv.omrpvalue           = 0
        inv.narration           = narration
        inv.save()

        if 'PI' in dn_no:
            for row in dnitems.values():
                row.pop('id')
                row.pop('inv_id')
                InvItems.objects.create(inv=inv,**row)

            ss = Salesorder.objects.get(dn=dn.dn)
            ss.status = '3'
            ss.save()

            dn.status = '3'
            dn.save()

            inv.mrpvalue            = dn.mrpvalue
            inv.omrpvalue           = dn.omrpvalue
            inv.save()

        else:

            mrpvalue                = 0
            omrpvalue               = 0
            for row in dnitems.values():
                row.pop('id')
                row.pop('dn_id')
                row['nb_qty']   = row['billed_qty']
                row['nf_qty']   = row['free_qty']
                row['new_rate'] = row['rate']

                mrpvalue            += Decimal(row['mrp']) * row['billed_qty']
                omrpvalue           += Decimal(row['offer_mrp']) * row['billed_qty']

                InvItems.objects.create(inv=inv,**row)

            ss = Salesorder.objects.get(dn=dn)
            ss.status = '3'
            ss.save()

            dn.status = '3'
            dn.save()

            inv.mrpvalue            = mrpvalue
            inv.omrpvalue           = omrpvalue
            inv.save()


        messages.success(request, "Sales Order Invoice Created Successfully")
        return redirect('sales:inv')

    dn  = Delivery_note.objects.filter(status=1,company=com).order_by('dn_no')
    pi  = ProformaInvoice.objects.filter(status__in=[1,4],company=com).order_by('inv_no')

    context = {'sos': dn, 'dnnumber': dnnumber, 'pi':pi}

    return render(request, 'sales/add_inv.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales Pro Forma Invoice Delete', 'Sales Pro Forma Invoice Create', 'Sales Pro Forma Invoice Update'])
def proformainv(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    series  = com.pinv_series
    inv     = ProformaInvoice.objects.filter(company=com, inv_no__contains=series).order_by('inv_no').last()

    if inv:
        sonum       = int(inv.inv_no[len(series):]) + 1
        dnnumber    = series + (str(sonum)).zfill(5)
    else:
        dnnumber    = series + '00001'

    if request.method == 'POST':

        dn_no                   = request.POST.get("dn_no")
        dn                      = Delivery_note.objects.get(company=com,dn_no=dn_no)
        narration               = request.POST.get("narration")
        dnitems                 = DnItems.objects.filter(dn=dn)

        inv                     = ProformaInvoice()
        inv.dn                  = dn
        inv.company             = dn.company
        inv.inv_no              = dnnumber
        inv.price_list          = dn.price_list

        inv.division            = str(dn.buyer.devision)
        inv.channel             = str(dn.buyer.party_type)

        inv.buyer               = dn.buyer
        inv.buyer_mailingname   = dn.buyer_mailingname
        inv.buyer_address_type  = dn.buyer_address_type
        inv.buyer_address1      = dn.buyer_address1
        inv.buyer_address2      = dn.buyer_address2
        inv.buyer_address3      = dn.buyer_address3
        inv.buyer_gstin         = dn.buyer_gstin
        inv.buyer_state         = dn.buyer_state
        inv.buyer_pincode       = dn.buyer_pincode
        inv.buyer_gst_reg_type  = dn.buyer_gst_reg_type
        inv.buyer_country       = dn.buyer_country
        inv.buyer_city          = dn.buyer_city

        inv.shipto              = dn.shipto
        inv.shipto_mailingname  = dn.shipto_mailingname
        inv.shipto_address_type = dn.shipto_address_type
        inv.shipto_address1     = dn.shipto_address1
        inv.shipto_address2     = dn.shipto_address2
        inv.shipto_address3     = dn.shipto_address3
        inv.shipto_gstin        = dn.shipto_gstin
        inv.shipto_pincode      = dn.shipto_pincode

        inv.shipto_state        = dn.shipto_state
        inv.shipto_country      = dn.shipto_country
        inv.shipto_city         = dn.shipto_city
        inv.mode_of_payment     = dn.mode_of_payment
        inv.other_reference     = dn.other_reference
        inv.terms_of_delivery   = dn.terms_of_delivery
        inv.order_no            = dn.order_no

        inv.dispatch_doc_no     = dn.dispatch_doc_no
        inv.dispatch_through    = dn.dispatch_through
        inv.destintaion         = dn.destintaion
        inv.carrier_agent       = dn.carrier_agent
        inv.carrier_agent_id    = dn.carrier_agent_id
        inv.lr_no               = dn.lr_no
        inv.lr_date             = dn.lr_date
        inv.vehical_no          = dn.vehical_no
        inv.ammount             = dn.ammount
        inv.cgst                = dn.cgst
        inv.other               = dn.other
        inv.other_ledger        = dn.other_ledger
        inv.ol_rate             = dn.ol_rate
        inv.igst                = dn.igst
        inv.sgst                = dn.sgst
        inv.tcs                 = dn.tcs
        inv.round_off           = dn.round_off
        inv.total               = dn.total
        inv.discount            = dn.discount

        inv.bill_qty            = dn.bill_qty
        inv.free_qty            = dn.free_qty
        inv.mrpvalue            = 0
        inv.omrpvalue           = 0
        inv.narration           = narration
        inv.save()

        mrpvalue                = 0
        omrpvalue               = 0
        for row in dnitems.values():
            row.pop('id')
            row.pop('dn_id')
            row['nb_qty'] = row['billed_qty']
            row['nf_qty'] = row['free_qty']
            row['new_rate'] = row['rate']

            mrpvalue            += Decimal(row['mrp']) * row['billed_qty']
            omrpvalue           += Decimal(row['offer_mrp']) * row['billed_qty']

            ProformaInvItems.objects.create(inv=inv,**row)
        ss = Salesorder.objects.get(dn=dn)
        ss.status = '3'
        ss.save()

        inv.mrpvalue            = mrpvalue
        inv.omrpvalue           = omrpvalue
        inv.save()

        dn.status               =  '3'
        dn.save()

        messages.success(request, "Proforma Invoice Created Successfully")
        return redirect('sales:proformainv')

    dn = Delivery_note.objects.filter(company=com,status='1')

    company = Company.objects.all()

    context = {'sos': dn, 'dnnumber': dnnumber, 'company': company}

    return render(request, 'sales/add_proformainv.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales Invoice Delete', 'Sales Invoice Create', 'Sales Invoice Update', 'Sales Invoice View'])
def invshow(request, pk):

    inv = Invoice.objects.get(pk=pk)
    items= InvItems.objects.filter(inv=inv)

    return render(request, 'sales/show_inv.html', {'inv': inv, 'items':items})

@allowed_users(allowed_roles=['Admin', 'Sales Pro Forma Invoice Delete', 'Sales Pro Forma Invoice Create', 'Sales Pro Forma Invoice Update', 'Sales Pro Forma Invoice View'])
def proformainvshow(request, pk):

    inv = ProformaInvoice.objects.get(pk=pk)
    items= ProformaInvItems.objects.filter(inv=inv).order_by('item__product_code')

    return render(request, 'sales/show_proformainv.html', {'inv': inv, 'items':items})


@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Sales Invoice Delete', 'Sales Invoice Create', 'Sales Invoice Update', 'Sales Invoice View']), name='dispatch')
class invlist(ListView):
    model           = Invoice
    template_name   = 'sales/salesinvoice.html'
    context_object_name = 'invs'
    paginate_by     = 10

    def get_queryset(self):
        query       = self.request.GET.get('q', None)
        qs  = Invoice.objects.filter(company=self.request.META['com']).order_by('-inv_date','-inv_no')
        if query is not None:
            qs=qs.filter(
                Q(inv_no__icontains=query) |
                Q(buyer__name__icontains=query) |
                Q(inv_date__icontains=query)
            )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Sales Pro Forma Invoice Delete', 'Sales Pro Forma Invoice Create', 'Sales Pro Forma Invoice Update', 'Sales Pro Forma Invoice View']), name='dispatch')
class proformainvlist(ListView):
    model           = ProformaInvoice
    template_name   = 'sales/salesproformainvoice.html'
    context_object_name = 'invs'
    paginate_by     = 10

    def get_queryset(self):
        query       = self.request.GET.get('q', None)
        qs  = ProformaInvoice.objects.filter(company=self.request.META['com']).order_by('-inv_no')
        if query is not None:
            qs=qs.filter(
                Q(inv_no__icontains=query) |
                Q(buyer__name__icontains=query) |
                Q(inv_date__icontains=query)
            )
        return qs

@allowed_users(allowed_roles=['Admin', 'Sales Invoice Delete'])
def invcancel(request, pk):

    inv = Invoice.objects.get(pk=pk)
    inv.status = "2"
    dn = Delivery_note.objects.get(id=inv.dn.pk)
    dn.status = '1'
    dn.save()
    inv.dn = None
    inv.save()
    messages.success(request, "Sales Order Invoice Cancelled Successfully")
    return redirect('sales:inv')

@allowed_users(allowed_roles=['Admin', 'Sales Pro Forma Invoice Delete'])
def proformainvcancel(request, pk):

    inv = ProformaInvoice.objects.get(pk=pk)
    inv.status = "2"
    dn = Delivery_note.objects.get(id=inv.dn.pk)
    dn.status = '1'
    dn.save()
    inv.dn = None
    inv.save()
    messages.success(request, "Sales Order Proforma Invoice Cancelled Successfully")
    return redirect('sales:proformainv')

@allowed_users(allowed_roles=['Admin', 'Credit Note Delete'])
def cncancel(request, pk):

    pi = CreditNote.objects.get(pk=pk)
    invitems = InvItems.objects.filter(inv=pi.inv)
    pi.status = "2"
    pi.inv = None
    pi.save()
    items = CreditNoteItems.objects.filter(inv=pi)
    for i in invitems:
        for j in items:
            if i.item == j.item:
                i.new_rate += j.rate_diff
        i.save()
    messages.success(request, "Credit Note Cancelled Successfully")
    return redirect('sales:cn')

@allowed_users(allowed_roles=['Admin', 'Sales QDN Delete'])
def qdncancel(request, pk):

    pi = Qdn.objects.get(pk=pk)
    pi.status = "2"
    pi.inv = None
    pi.save()

    invitems = InvItems.objects.filter(inv=pi.inv)
    items = QdnItems.objects.filter(inv=pi)

    for i in invitems:
        for j in items:
            if i.item == j.item:
                i.nb_qty += j.qb_qty
                i.nf_qty += j.qf_qty
        i.save()
    messages.success(request, "QDN Cancelled Successfully")
    return redirect('sales:cn')

@allowed_users(allowed_roles=['Admin', 'RSO Delete'])
def rsocancel(request, pk):

    pi = Rso.objects.get(pk=pk)
    invitems = InvItems.objects.filter(inv=pi.inv)
    pi.status = "2"
    pi.inv = None
    pi.save()
    godown = Godown.objects.get(name="SALES RETURN")
    items = RsoItems.objects.filter(inv=pi)
    for i in invitems:
        for j in items:
            if i.item == j.item:
                i.nb_qty += j.rb_qty
                i.nf_qty += j.rf_qty
            Stock_summary.objects.filter(company=pi.company,godown=godown, product=i.item, rate=j.rate,mrp=i.item.mrp, closing_balance=(j.rb_qty + j.rf_qty)).delete()
        i.save()
    messages.success(request, "RSO Cancelled Successfully")
    return redirect('sales:rso')

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Credit Note Delete', 'Credit Note Create', 'Credit Note Update', 'Credit Note View']), name='dispatch')
class creditnote(ListView):
    model = CreditNote
    template_name = 'sales/list_cn.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs  = CreditNote.objects.filter(company=self.request.META['com']).order_by('-cn_no')
        if query is not None:
            qs=qs.filter( Q(cn_no__icontains=query) | Q(buyer__name__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Sales QDN Delete', 'Sales QDN Create', 'Sales QDN Update', 'Sales QDN View']), name='dispatch')
class qdn(ListView):
    model = Qdn
    template_name = 'sales/list_qdn.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs  = Qdn.objects.filter(company=self.request.META['com']).order_by('-qdn_no')
        if query is not None:
            qs=qs.filter( Q(qdn_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'RSO Delete', 'RSO Create', 'RSO Update', 'RSO View']), name='dispatch')
class rso(ListView):
    model = Rso
    template_name = 'sales/list_rso.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Rso.objects.filter(company=self.request.META['com']).order_by('-rso_date')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(rso_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Credit Memo Delete', 'Credit Memo Create', 'Credit Memo Update', 'Credit Memo View']), name='dispatch')
class creditmemo(ListView):
    model = Rso
    template_name = 'sales/list_creditmemo.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs  = Rso.objects.filter(company=self.request.META['com'], is_cm = True).order_by('-rso_no')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(rso_no__icontains=query) )
        return qs

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Sales Target Delete', 'Sales Target Create', 'Sales Target Update', 'Sales Target View']), name='dispatch')
class targetsat(ListView):
    model = SalesTarget
    template_name = 'sales/list_target.html'
    context_object_name = 'pis'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs  = SalesTarget.objects.all().order_by('-created')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'Credit Note Create', 'Credit Note Update', 'Credit Note Delete'])
def addcn(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com     = Company.objects.get(id=skey)
    series  = com.creditnote_series
    pi      = CreditNote.objects.filter(company=com, cn_no__contains=series).order_by('cn_no').last()
    if pi:
        ponum = int(pi.cn_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'
    if request.method == 'POST':

        grn_no      = request.POST.get("grn_no")
        grn         = Invoice.objects.get(company=com, inv_no=grn_no)
        ol_rate     = Decimal(request.POST.get("ol_rate"))
        narration   = request.POST.get("narration")
        dif_rate    = request.POST.getlist("dif_rate")

        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi                          = CreditNote()
        pi.company                  = grn.company
        pi.inv                      = grn
        pi.cn_no                    = grnnumber

        pi.division                 = grn.division
        pi.channel                  = grn.channel

        pi.buyer                    = grn.buyer
        pi.buyer_mailingname        = grn.buyer_mailingname
        pi.buyer_address_type       = grn.buyer_address_type
        pi.buyer_address1           = grn.buyer_address1
        pi.buyer_address2           = grn.buyer_address2
        pi.buyer_address3           = grn.buyer_address3
        pi.buyer_gstin              = grn.buyer_gstin
        pi.buyer_state              = grn.buyer_state
        pi.buyer_pincode            = grn.buyer_pincode
        pi.buyer_gst_reg_type       = grn.buyer_gst_reg_type
        pi.buyer_country            = grn.buyer_country
        pi.buyer_city               = grn.buyer_city

        pi.ammount                  = 0
        pi.discount                 = grn.discount
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = 0
        pi.other                    = other
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate

        pi.narration                = narration
        pi.save()

        items               = InvItems.objects.filter(inv=grn)

        basicammount        = 0
        totalammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0

        try:
            for j,i in enumerate(items):

                item                = i.item

                billed_qty          = i.nb_qty
                rate                = Decimal(dif_rate[j])
                discount            = i.discount
                amount              = round((rate * billed_qty)* Decimal(1- discount/100),2)
                ammount             = round((amount * Decimal(1- pi.discount/100)),2)

                i.new_rate          -= rate
                i.save()

                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate
                igst                = round(Decimal(igstrate * ammount / 100),2)
                cgst                = round(Decimal(cgstrate * ammount / 100),2)
                sgst                = round(Decimal(sgstrate * ammount / 100),2)

                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                basicammount        = basicammount  + amount
                totalammount        = totalammount  + ammount

                CreditNoteItems.objects.create(inv=pi,amount=amount,item=item,igstrate=igstrate,mrp=i.mrp,
                                                cgstrate=cgstrate, sgstrate=sgstrate,discount=discount,
                                                igst=igst,cgst=cgst,billed_qty=billed_qty,
                                                sgst=sgst,rates=i.rate, rate = rate)

        except BaseException as exp:
            CreditNoteItems.objects.filter(inv=pi).delete()
            pi.delete()
            return redirect("sales:cn")

        pi.ammount                 = round(basicammount,2)
        pi.cgst                    = round(totalcgst + (other * ol_rate / 100),2)
        pi.sgst                    = round(totalsgst + (other * ol_rate / 100),2)
        pi.igst                    = round(totaligst + (other * ol_rate / 100),2)
        pi.other                   = other

        total                      = totalammount + pi.igst + other
        pi.total                   = round(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()

        messages.success(request, "Credit Note Created Successfully")
        return redirect("sales:cn")


    context = {'grnnumber': grnnumber}

    return render(request, 'sales/add_cn.html', context)

@allowed_users(allowed_roles=['Admin', 'Sales QDN Create', 'Sales QDN Update', 'Sales QDN Delete'])
def addqdn(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com     = Company.objects.get(id=skey)

    series  = com.sales_qdn_series
    pi      = Qdn.objects.filter(company=com, qdn_no__contains=series).order_by('qdn_no').last()
    if pi:
        ponum = int(pi.qdn_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'
    company = Company.objects.all()

    if request.method == 'POST':

        grn_no      = request.POST.get("grn_no")
        grn         = Invoice.objects.get(company=com,inv_no=grn_no)
        ol_rate     = Decimal(request.POST.get("ol_rate"))
        narration   = request.POST.get("narration")
        dif_bqty     = request.POST.getlist("dif_bqty")
        dif_fqty     = request.POST.getlist("dif_fqty")

        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi                          = Qdn()
        pi.company                  = grn.company
        pi.inv                      = grn
        pi.qdn_no                   = grnnumber

        pi.division                 = grn.division
        pi.channel                  = grn.channel

        pi.buyer                    = grn.buyer
        pi.buyer_mailingname        = grn.buyer_mailingname
        pi.buyer_address_type       = grn.buyer_address_type
        pi.buyer_address1           = grn.buyer_address1
        pi.buyer_address2           = grn.buyer_address2
        pi.buyer_address3           = grn.buyer_address3
        pi.buyer_gstin              = grn.buyer_gstin
        pi.buyer_state              = grn.buyer_state
        pi.buyer_pincode            = grn.buyer_pincode
        pi.buyer_gst_reg_type       = grn.buyer_gst_reg_type
        pi.buyer_country            = grn.buyer_country
        pi.buyer_city               = grn.buyer_city

        pi.ammount                  = 0
        pi.discount                 = grn.discount
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = 0
        pi.other                    = other
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate
        pi.bill_qty                   = 0
        pi.free_qty                   = 0

        pi.narration                = narration
        pi.save()

        items                       = InvItems.objects.filter(inv=grn)
        mrpvalue                    = 0

        totalammount                = 0
        basicammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        totalqb_qty                    = 0
        totalqf_qty                    = 0
        try:
            for j,i in enumerate(items):
                item                = i.item

                qb_qty             = Decimal(dif_bqty[j])
                qf_qty             = Decimal(dif_fqty[j])
                rate                = i.new_rate
                discount            = i.discount
                amount              = round(((rate * qb_qty)* Decimal(1- discount/100)),2)
                ammount             = round((amount * Decimal(1- pi.discount/100)),2)
                i.nb_qty           -= qb_qty
                i.nf_qty           -= qf_qty
                i.save()

                totalqb_qty        += qb_qty
                totalqf_qty        += qf_qty
                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate

                igst                = Decimal(igstrate * ammount / 100)
                cgst                = Decimal(cgstrate * ammount / 100)
                sgst                = Decimal(sgstrate * ammount / 100)

                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                totalammount        = totalammount  + ammount
                basicammount        = basicammount  + amount
                mrpvalue            += i.mrp * qb_qty

                QdnItems.objects.create(inv=pi,amount=amount,item=item,igstrate=igstrate,mrp=i.mrp,
                                                cgstrate=cgstrate, sgstrate=sgstrate,discount=discount,
                                                igst=igst,cgst=cgst,billed=i.nb_qty,billed_qty=qb_qty,free_qty=qf_qty,
                                                sgst=sgst,rate=rate)

        except BaseException as exp:
            QdnItems.objects.filter(inv=pi).delete()
            pi.delete()
            return redirect("sales:qdn")


        pi.ammount                 = round(basicammount,2)
        pi.cgst                    = round((totalcgst + (other * ol_rate / 100)),2)
        pi.sgst                    = round((totalsgst + (other * ol_rate / 100)),2)
        pi.igst                    = round((totaligst + (other * ol_rate / 100)),2)

        pi.bill_qty                  = totalqb_qty
        pi.free_qty                  = totalqf_qty
        pi.other                   = other
        pi.mrpvalue                = mrpvalue

        total                      = round((totalammount + pi.igst + other),2)
        pi.total                   = round(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()

        messages.success(request, "QDN Created Successfully")
        return redirect("sales:qdn")


    context = { 'grnnumber': grnnumber, 'company': company}

    return render(request, 'sales/add_qdn.html', context)

@allowed_users(allowed_roles=['Admin', 'RSO Create', 'RSO Update', 'RSO Delete'])
def addrso(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com     = Company.objects.get(id=skey)
    series  = com.rso_series
    pi      = Rso.objects.filter(company=com, rso_no__contains=series).order_by('rso_no').last()
    if pi:
        ponum = int(pi.rso_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'

    if request.method == 'POST':

        grn_no      = request.POST.get("grn_no")
        grn         = Invoice.objects.get(inv_no=grn_no,company=com)
        ol_rate     = Decimal(request.POST.get("ol_rate"))
        narration   = request.POST.get("narration")
        dif_bqty     = request.POST.getlist("dif_bqty")
        dif_fqty     = request.POST.getlist("dif_fqty")

        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = 0

        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)

        pi                          = Rso()
        pi.company                  = grn.company
        pi.inv                      = grn
        pi.rso_no                   = grnnumber
        pi.division                 = grn.division
        pi.channel                  = grn.channel
        pi.buyer                    = grn.buyer
        pi.buyer_address_type       = grn.buyer_address_type
        pi.buyer_gst_reg_type       = grn.buyer_gst_reg_type
        pi.buyer_state              = grn.buyer_state
        pi.buyer_country            = grn.buyer_country
        pi.buyer_city               = grn.buyer_city
        pi.buyer_mailingname        = grn.buyer_mailingname
        pi.buyer_address1           = grn.buyer_address1
        pi.buyer_address2           = grn.buyer_address2
        pi.buyer_address3           = grn.buyer_address3
        pi.buyer_pincode            = grn.buyer_pincode
        pi.buyer_gstin              = grn.buyer_gstin

        pi.ammount                  = 0
        pi.discount                 = grn.discount
        pi.cgst                     = 0
        pi.sgst                     = 0
        pi.igst                     = 0
        pi.tcs                      = 0
        pi.other                    = other
        pi.round_off                = 0
        pi.total                    = 0
        pi.ol_rate                  = ol_rate

        pi.bill_qty                  = 0
        pi.free_qty                  = 0

        pi.narration                = narration
        pi.save()

        items               = InvItems.objects.filter(inv=grn)
        mrpvalue            = 0

        totalammount        = 0
        basicammount        = 0
        totalcgst           = 0
        totalsgst           = 0
        totaligst           = 0
        totalrb_qty         = 0
        totalrf_qty         = 0
        try:
            godown                  = Godown.objects.get(name="SALES RETURN")
            today                   = date.today()
            grncount                = Grn.objects.filter(created__date=today).count()
            rsocount                = Rso.objects.filter(created=today).count()
            grnbatch                = today.strftime("%y%m%d") + str(grncount+rsocount+1).zfill(2)

            for j,i in enumerate(items):
                item                = i.item

                rb_qty             = Decimal(dif_bqty[j])
                rf_qty             = Decimal(dif_fqty[j])

                rate                = i.new_rate
                discount            = i.discount
                amount              = round(((rate * rb_qty)* Decimal(1- discount/100)),2)
                ammount             = round((amount * Decimal(1- pi.discount/100)),2)
                batch               = grnbatch + str(j+1).zfill(3)

                i.nb_qty           -= rb_qty
                i.nf_qty           -= rf_qty

                i.save()
                igstrate            = i.igstrate
                cgstrate            = i.cgstrate
                sgstrate            = i.sgstrate
                igst                = round(Decimal(igstrate * ammount / 100),2)
                cgst                = round(Decimal(cgstrate * ammount / 100),2)
                sgst                = round(Decimal(sgstrate * ammount / 100),2)

                totalrb_qty        += rb_qty
                totalrf_qty        += rf_qty

                totalcgst           = totalcgst     + cgst
                totalsgst           = totalsgst     + sgst
                totaligst           = totaligst     + igst
                basicammount        = basicammount  + amount
                totalammount        = totalammount  + ammount
                mrpvalue            += i.mrp * rb_qty

                RsoItems.objects.create(inv=pi,amount=amount,item=item,igstrate=igstrate,mrp=i.mrp,
                                                cgstrate=cgstrate, sgstrate=sgstrate,discount=discount,
                                                igst=igst,cgst=cgst,billed=i.nb_qty,billed_qty=rb_qty,free_qty=rf_qty,
                                                sgst=sgst,rate=rate)

                Stock_summary.objects.create(company=pi.company,godown=godown, product=i.item, rate=rate, batch=batch, mrp=i.item.mrp, closing_balance=rb_qty+rf_qty)

        except BaseException as exp:
            print(exp)
            RsoItems.objects.filter(inv=pi).delete()
            pi.delete()
            return redirect("sales:rso")


        pi.ammount                 = round(basicammount,2)
        pi.cgst                    = round((totalcgst + (other * ol_rate / 100)),2)
        pi.sgst                    = round((totalsgst + (other * ol_rate / 100)),2)
        pi.igst                    = round((totaligst + (other * ol_rate / 100)),2)
        pi.bill_qty                  = totalrb_qty
        pi.free_qty                  = totalrf_qty
        pi.other                   = other
        pi.mrpvalue                = mrpvalue

        total                      = totalammount + pi.igst + other
        pi.total                   = round(total)
        pi.round_off               = Decimal(pi.total - total)
        pi.save()
        messages.success(request, "RSO Created Successfully")
        return redirect("sales:rso")

    context = {'grnnumber': grnnumber}

    return render(request, 'sales/add_rso.html', context)

@allowed_users(allowed_roles=['Admin', 'Credit Memo Create', 'Credit Memo Update', 'Credit Memo Delete'])
def addcreditmemo(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com     = Company.objects.get(id=skey)
    series  = com.rso_series
    pi      = Rso.objects.filter(company=com, rso_no__contains=series).order_by('rso_no').last()
    if pi:
        ponum = int(pi.rso_no[len(series):]) + 1
        grnnumber = series + (str(ponum)).zfill(5)
    else:
        grnnumber = series + '00001'

    if request.method == 'POST':

        ref_no                      = request.POST.get("ref_no")
        ref_date                    = request.POST.get("ref_date")
        party_name                  = request.POST.get("party_name")
        party_address_type          = request.POST.get("party_address_type")
        billqtylist                 = request.POST.getlist('aqty')
        product_codelist            = request.POST.getlist('product_code')
        ratelist                    = request.POST.getlist("rate")
        party                       = Party_master.objects.get(name=party_name, group__name = 'Sundry Debtors')

        so                          = Rso()
        if party_address_type:
            party_add               = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            so.buyer_address_type   = party_add.address_type
        else:
            party_add               = party
            so.buyer_address_type   = "Default"

        ol_rate                     = Decimal(request.POST.get("ol_rate"))
        other_ledger                = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger            = LedgersType.objects.get(id=other_ledger)
            so.other_ledger         = other_ledger
        if request.POST.get("other"):
            other                   = Decimal(request.POST.get("other"))
        else:
            other                   = Decimal(0)

        narration                   = request.POST.get("narration")
        so.company                  = com
        so.rso_no                   = grnnumber
        so.rso_ref                  = ref_no
        so.ref_date                 = ref_date
        so.buyer                    = party
        so.buyer_address1           = party_add.addressline1
        so.buyer_address2           = party_add.addressline2
        so.buyer_address3           = party_add.addressline3
        so.buyer_mailingname        = party_add.mailing_name
        so.buyer_pincode            = party_add.pin_code
        so.buyer_state              = str(party_add.state)
        so.buyer_country            = str(party_add.country)
        so.buyer_city               = str(party_add.city)
        so.buyer_gst_reg_type       = party_add.gst_registration_type
        so.buyer_gstin              = party_add.gstin
        so.division                 = str(party.devision.name)
        so.channel                  = str(party.party_type.name)

        so.ammount                  = 0
        so.bill_qty                   = 0
        so.free_qty                   = 0
        so.discount                 = 0
        so.other                    = 0
        so.ol_rate                  = 0
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.total                    = 0
        so.round_off                = 0
        so.is_cm                    = True
        so.narration                = narration
        so.save()

        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        totalqty                    = 0
        mrpvalue            = 0
        try:
            godown                  = Godown.objects.get(name="SALES RETURN")
            today                   = date.today()
            grncount                = Grn.objects.filter(created__date=today).count()
            rsocount                = Rso.objects.filter(created=today).count()
            grnbatch                = today.strftime("%y%m%d") + str(grncount+rsocount+1).zfill(3)

            for i,j in enumerate(product_codelist):

                product             = Product_master.objects.get(product_code=j)
                mrp                 = product.mrp
                billqty             = Decimal(billqtylist[i])

                rate                = Decimal(ratelist[i])

                ammount             = (billqty * rate )
                batch               = grnbatch + str(i+1).zfill(3)

                igstrate            = product.gst
                cgstrate            = igstrate/2
                sgstrate            = igstrate/2
                igst                = ammount * (igstrate / 100)
                cgst                = ammount * (cgstrate / 100)
                sgst                = ammount * (sgstrate / 100)

                totalammount        = totalammount + ammount
                totalcgst           = totalcgst + cgst
                totalsgst           = totalsgst + sgst
                totaligst           = totaligst + igst
                totalqty            = totalqty + billqty
                mrpvalue            += mrp * billqty

                RsoItems.objects.create(inv=so,amount=ammount,item=product,igstrate=igstrate, cgstrate=cgstrate, sgstrate=sgstrate,discount=0,mrp=mrp,
                                                igst=igst,cgst=cgst,billed=billqty,billed_qty=billqty,free_qty=0, sgst=sgst,rate=rate)
                Stock_summary.objects.create(company=com,godown=godown, product=product, rate=rate, batch=batch, mrp=mrp, closing_balance=billqty)

        except BaseException as exception:
            print(exception)
            # so.delete()
            return HttpResponse(exception)

        so.ammount      = totalammount
        so.bill_qty       = totalqty
        so.free_qty       = 0
        so.mrpvalue                = mrpvalue

        so.cgst         = totalcgst + (other * ol_rate /200)
        so.sgst         = totalsgst + (other * ol_rate /200)
        so.igst         = totaligst + (other * ol_rate /100)
        so.other        = other
        total           = totalammount + so.igst + other
        so.total        = round(total)
        so.round_off    = so.total - total
        so.save()
        messages.success(request, "Credit Memo Created Successfully")
        return redirect('sales:creditmemo')

    items   = Product_master.objects.all()
    parties = Party_master.objects.filter(group__name="Sundry Debtors")
    context = {'parties': parties, 'items': items, 'sonumber': grnnumber}

    return render(request, 'sales/add_creditmemo.html', context)

from dateutil import parser
def addtargetsat(request):

    if request.method == 'POST':
        customerlist = request.POST.getlist('customer')
        targetlist = request.POST.getlist('target')
        targetdatelist = request.POST.getlist('target_date')

        for j,k in enumerate(customerlist):
            customer            = Party_master.objects.get(vendor_code=customerlist[j])
            changeddateformat   = targetdatelist[j]
            DT = parser.parse(changeddateformat)
            month = (DT.year,DT.month,1)
            SalesTarget.objects.create(zone = customer.zone, region = customer.region, se = customer.se, asm = customer.asm, rsm = customer.rsm, zsm = customer.zsm, buyer = customer, target = Decimal(targetlist[j]), months = datetime(*month).date())
        messages.success(request, "Target Seted Successfully")
        return redirect("sales:targetsat")

    customer = Party_master.objects.filter(group__name="Sundry Debtors")
    return render(request, 'sales/add_targetsat.html', { 'customer': customer })

@allowed_users(allowed_roles=['Admin', 'Credit Memo Update', 'Credit Memo Delete'])
def edit_Creditmemo(request, pk):

    if request.method == 'POST':
        so = Rso.objects.get(pk=pk)

        so.ammount = Decimal(request.POST.get("totalammount"))
        so.cgst = Decimal(request.POST.get("totalcgst"))
        so.sgst = Decimal(request.POST.get("totalsgst"))
        so.igst = Decimal(request.POST.get("totaligst"))
        so.tcs = Decimal(request.POST.get("totaltcs"))
        so.total = Decimal(request.POST.get("round_off"))
        so.narration = request.POST.get("narration")

        pcodelist = request.POST.getlist("product_code")
        mrplist = request.POST.getlist("offermrp")
        aqtylist = request.POST.getlist("actualqty")
        bqtylist = request.POST.getlist("billqty")
        fqtylist = request.POST.getlist("freeqty")
        dislist = request.POST.getlist("discount")
        amtlist = request.POST.getlist("ammount")

        for i, j in enumerate(pcodelist):
            item = RsoItems.objects.get(inv=so, product_code=j)
            item.offer_price = mrplist[i]
            item.actual_qty = aqtylist[i]
            item.billed_qty = bqtylist[i]
            item.free_qty = fqtylist[i]
            item.discount = dislist[i]
            item.amount = amtlist[i]
            item.save()
        messages.success(request, "Credit Memo Updated Successfully")
        return redirect('sales:Creditmemo')
    so      = Rso.objects.get(pk=pk)
    items   = RsoItems.objects.filter(inv=so)
    company = Company.objects.all()
    return render(request, 'sales/edit_Creditmemo.html', {'pk': pk, 'pi': so, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'Credit Memo View', 'Credit Memo Create', 'Credit Memo Update', 'Credit Memo Delete'])
def show_Creditmemo(request, pk):

    so = Rso.objects.get(pk=pk)
    items = RsoItems.objects.filter(inv=so)
    company = Company.objects.all()
    return render(request, 'sales/show_Creditmemo.html', {'pk': pk, 'pi': so, 'items': items, 'company': company})


@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'LR Details View', 'LR Details Create', 'LR Details Update', 'LR Details Delete']), name='dispatch')
class addlr(ListView):
    model = Invoice
    template_name = 'sales/add_lr.html'
    context_object_name = 'invs'
    paginate_by = 10
    def get_queryset(self):
        today = datetime.today() - timedelta(days=120)
        query = self.request.GET.get('q', None)
        if query is not None:
            inv = Invoice.objects.filter(Q(company=self.request.META['com'], inv_date__gt = today) & (Q(buyer__name__icontains=query) | Q(inv_no__icontains=query))).order_by('-inv_date').values('id','inv_date','inv_no','dn__dn_no','dn_id','total','buyer__name','lr_date','dn__dn_date','lr_no')
        else:
            inv = list(Invoice.objects.filter(company=self.request.META['com'], inv_date__gt = today).order_by('-inv_date').values('id','inv_date','inv_no','dn__dn_no','dn_id','total','buyer__name','lr_date','dn__dn_date','lr_no'))
        for i in inv:
            i['totalbox'] = PackingSheet.objects.filter(dn=i['dn_id']).aggregate(Sum('total_box'))
        return inv


# @allowed_users(allowed_roles=['Admin', 'LR Details Create', 'LR Details Update', 'LR Details Delete'])
# def addlr(request):
#     inv = list(Invoice.objects.all().order_by('-created').values('id','inv_date','inv_no','dn_id','total','buyer__name','lr_date','dn__dn_date','lr_no'))
#     for i in inv:
#         i['totalbox'] = PackingSheet.objects.filter(dn=i['dn_id']).aggregate(Sum('total_box'))
#     return render(request, 'sales/add_lr.html', {'invs':inv})

@allowed_users(allowed_roles=['Admin', 'LR Details Update', 'LR Details Delete'])
def updatelr(request, pk):

    inv = Invoice.objects.get(id=pk)
    if request.method == 'POST':
        lr_date = request.POST.get('lr_date')
        if lr_date:
            inv.lr_date = lr_date
        else:
            inv.lr_date = None
        inv.lr_no = request.POST.get('lr_no')
        inv.save()
        messages.success(request, "LR Updated Successfully")
        return render(request, 'sales/partials/cancel_lr.html', {'inv':inv})

    return render(request, 'sales/partials/update_lr.html', {'inv':inv})

@allowed_users(allowed_roles=['Admin', 'LR Details Delete'])
def cancellr(request, pk):

    inv = Invoice.objects.get(id=pk)

    return render(request, 'sales/partials/cancel_lr.html', {'inv':inv})

@method_decorator(is_company, name='dispatch')
@method_decorator(allowed_users(allowed_roles=['Admin', 'Transport Details View', 'Transport Details Create', 'Transport Details Update', 'Transport Details Delete']), name='dispatch')
class addtp(ListView):
    model = Delivery_note
    template_name = 'sales/add_tp.html'
    context_object_name = 'dns'
    paginate_by = 15

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Delivery_note.objects.filter(company=self.request.META['com'], status__in=['1','3']).order_by('-dn_date')
        if query is not None:
            qs=qs.filter( Q(buyer__name__icontains=query) | Q(dn_no__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'Transport Details Update', 'Transport Details Delete'])
def updatetp(request, pk):

    dn = Delivery_note.objects.get(id=pk)

    if request.method == 'POST':
        dn.dispatch_doc_no = request.POST.get("dispatch_doc_no")
        dn.dispatch_through = request.POST.get("dispatch_through")
        dn.destintaion = request.POST.get("destintaion")
        trans = request.POST.get("carrier_agent")
        if trans != '0':
            temp_trans = Party_master.objects.get(pk=trans)
            dn.carrier_agent = temp_trans.name
            dn.carrier_agent_id = temp_trans.gstin
        dn.vehical_no = request.POST.get("vehical_no")
        dn.vehical_type = request.POST.get("vehicle_type")
        dn.save()

        return render(request, 'sales/partials/cancel_tp.html', {'dn':dn})

    traspoter = Party_master.objects.filter(is_transporter=True)
    return render(request, 'sales/partials/update_tp.html', {'dn':dn, 'traspoter': traspoter})

@allowed_users(allowed_roles=['Admin', 'Transport Details Delete'])
def canceltp(request, pk):

    dn = Delivery_note.objects.get(id=pk)

    return render(request, 'sales/partials/cancel_tp.html', {'dn':dn})

@allowed_users(allowed_roles=['Admin', 'Credit Note View', 'Credit Note Create', 'Credit Note Update', 'Credit Note Delete'])
def cnshow(request, pk):

    pi = CreditNote.objects.get(pk=pk)
    items = CreditNoteItems.objects.filter(inv=pi)

    return render(request, 'sales/show_cn.html', {'pi': pi,'items':items})

@allowed_users(allowed_roles=['Admin', 'Sales QDN View', 'Sales QDN Create', 'Sales QDN Update', 'Sales QDN Delete'])
def qdnshow(request, pk):

    pi = Qdn.objects.get(pk=pk)
    items = QdnItems.objects.filter(inv=pi)

    return render(request, 'sales/show_qdn.html', {'pi': pi,'items':items})

@allowed_users(allowed_roles=['Admin', 'RSO View', 'RSO Create', 'RSO Update', 'RSO Delete'])
def rsoshow(request, pk):

    pi = Rso.objects.get(pk=pk)
    items = RsoItems.objects.filter(inv=pi)

    return render(request, 'sales/show_ivt.html', {'pi': pi,'items':items})

import xmltodict
def sendinv(request, pk):


    inv = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(inv=inv).values('item_id','item__mrp','item__product_code','rate','billed_qty','actual_qty','discount','amount')

    xml = invcreator(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''

    com = inv.company
    mainxml = mainxml.replace('Company_name',com.tally_name)

    payload = mainxml.replace('xml_creator', xml)
    print(payload)
    req = requests.get(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))
    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('sales:inv')
    return HttpResponse(req)

def sendcn(request, pk):

    inv = CreditNote.objects.get(pk=pk)

    items = CreditNoteItems.objects.filter(inv=inv)

    xml = cncreator(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    payload = mainxml.replace('xml_creator', xml)
    print(payload)
    req = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))
    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('sales:cn')

    return HttpResponse(req)

def sendqdn(request, pk):

    inv = Qdn.objects.get(pk=pk)
    items = QdnItems.objects.filter(inv=inv)

    xml = qdncreator(inv, items)
    mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    mainxml = mainxml.replace('Company_name',com.tally_name)
    payload = mainxml.replace('xml_creator', xml)
    print(payload)
    req = requests.post(url=com.ipaddress, data=payload)
    data_dict = xmltodict.parse(req.text, xml_attribs=True)
    jsondata = json.loads(json.dumps(data_dict))
    result = (jsondata['RESPONSE']).get('CREATED')
    if result == '1':
        inv.status = '3'
        inv.save()
        return redirect('sales:qdn')
    return HttpResponse(req)

def sendrso(request, pk):

    inv = Rso.objects.get(pk=pk)
    items = RsoItems.objects.filter(inv=inv)

    xml = rsocreator(inv, items)
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
        return redirect('sales:rso')

    return HttpResponse(req)

def sendcreditmemo(request, pk):

    inv = Rso.objects.get(pk=pk)
    items = RsoItems.objects.filter(inv=inv)

    xml = creditmemocreator(inv, items)
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
        return redirect('sales:creditmemo')

    return HttpResponse(req)
#ajax
def item(request):

    no = int(request.GET['no'])+1

    context = {'no': no, 'items': Product_master.objects.all() }

    return render(request, 'sales/partials/so-item.html', context)

def targetitem(request):

    no = int(request.GET['no'])+1
    customer = Party_master.objects.filter(group__name="Sundry Debtors")
    context = {'no': no, 'customer': customer}

    return render(request, 'sales/partials/target-item.html', context)


def godownitem(request):

    no = request.GET['no']

    context = {'no': no}

    return render(request, 'sales/partials/godown-item.html', context)


def party_address(request):
    party = Party_master.objects.get(name=request.GET.get('party'), group__name="Sundry Debtors")
    address_type = request.GET.get('address')
    address = Party_contact_details.objects.get(
        party=party, address_type=address_type)
    return render(request, 'sales/partials/party_address.html', {'address': address})


def address(request):
    party = Party_master.objects.get(name=request.GET.get('party'), group__name="Sundry Debtors")
    address_types = Party_contact_details.objects.filter(party=party).order_by('address_type')
    return render(request, 'sales/partials/address.html', {'address': party, 'address_types': address_types})


def product_code(request):
    search_text =request.GET.get('item')
    product     = Product_master.objects.filter(Q(product_code__contains=search_text) | Q(article_code__contains=search_text))
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    stock       = salable(com,product[0]) #SaleQty.objects.get(company = com , product=product[0]).qty
    return render(request, 'sales/partials/product_code.html', {'product': product,'stock':stock})

def ict_product_code(request):
    search_text = request.GET.get('item')
    product     = Product_master.objects.get(product_code=search_text)
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)
    # stock       = SaleQty.objects.get(company = com , product=product).qty
    stock       = salable(com,product) #SaleQty.objects.get(company = com , product=product[0]).qty

    return render(request, 'sales/partials/ict_product_code.html', {'product': product,'stock':stock})


def product_pack(request):
    product = Product_master.objects.get(product_code=request.GET.get('item'))
    return HttpResponse(product.outer_qty)


def product_mrp(request):
    product = Product_master.objects.get(product_code=request.GET.get('item'))
    return HttpResponse(product.mrp)


def product_stock(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)

    product = Product_master.objects.get(product_code=(request.GET.get('item')).upper())

    sq      = SaleQty.objects.get(company=com,product=product)
    return HttpResponse(sq.qty)


def product_rate(request):
    product = Product_master.objects.get(product_code=request.GET.get('item'))
    price_level = Price_level.objects.get(name=request.GET.get('price_list'))
    pl = Price_list.objects.get(product=product, price_level=price_level)
    return HttpResponse(pl.rate)


def product_gst(request):
    product = Product_master.objects.get(product_code=request.GET.get('item'))
    gst = Gst_list.objects.filter(product=product).last()
    context = {'item': {'igst': gst.igstrate, 'cgst': gst.cgstrate, 'sgst': gst.sgstrate}}
    return render(request, 'sales/partials/gst.html', context)


def load_creditmemo_upload(request):
    no              = request.GET.get('no')
    product_code    = request.GET.get('product_code')

    product         = Product_master.objects.get(product_code=product_code)
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    stock           = salable(com,product)

    rate      = request.GET.get('rate')
    actualqty       = Decimal(request.GET.get('actualqty'))
    billqty         = Decimal(request.GET.get('billqty'))
    freeqty         = actualqty-billqty


    amount          = (billqty * Decimal(rate))
    igst            = (product.gst * amount / 100)
    sgst            = (igst / 2)
    cgst            = (igst / 2)
    context = {
        'no': no,
        'product': product,
        'batch': product.mrp,
        'stock': stock,
        'inner': product.outer_qty,
        'billqty': billqty,
        'freeqty': freeqty,
        'igst': igst,
        'cgst': cgst,
        'sgst': sgst,
        'rate': rate,
        'amount': amount,
        'gst':product.gst
    }
    return render(request, 'sales/partials/creditmemo-upload.html', context)

def load_so_upload(request):
    no              = request.GET.get('no')
    product_code    = request.GET.get('product_code')

    product         = Product_master.objects.get(product_code=product_code)
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    stock           = salable(com,product)

    offermrp        = request.GET.get('offermrp')
    manualrate      = request.GET.get('rate')
    actualqty       = Decimal(request.GET.get('actualqty'))
    billqty         = Decimal(request.GET.get('billqty'))
    freeqty         = actualqty-billqty
    discount        = Decimal(request.GET.get('discount'))

    price_level     = Price_level.objects.get(name=request.GET.get('price_level'))

    if price_level.name == 'Manual':
        rate        = manualrate
    else:
        pl          = Price_list.objects.filter(product=product, price_level=price_level).first()
        rate        = pl.rate

    amount          = (billqty * Decimal(rate)) * ((100 - discount)/100)
    igst            = (product.gst * amount / 100)
    sgst            = (igst / 2)
    cgst            = (igst / 2)
    context = {
        'no': no,
        'product': product,
        'offermrp': offermrp,
        'batch': product.mrp,
        'stock': stock,
        'actualqty': actualqty,
        'billqty': billqty,
        'freeqty': freeqty,
        'discount': discount,
        'igst': igst,
        'cgst': cgst,
        'sgst': sgst,
        'rate': rate,
        'amount': amount,
        'igstrate':product.gst,
        'cgstrate':product.gst/2,
        'sgstrate':product.gst/2
    }
    return render(request, 'sales/partials/so-upload.html', context)

def load_target_upload(request):

    no              = request.GET.get('no')
    vendor_code     = request.GET.get('vendor_code')

    product         = Party_master.objects.get(vendor_code=vendor_code)
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)

    target          = request.GET.get('target')
    months          = request.GET.get('months')

    context = {
        'no': no,
        'vendor_code': vendor_code,
        'target': target,
        'months': months,
    }
    return render(request, 'sales/partials/target-upload.html', context)

def load_so(request):
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    so          = Salesorder.objects.get(company=com,so_no=request.GET.get('sono'))
    items       = SoItems.objects.filter(so=so)
    it          = {}
    for item in items:
        qty     = item.actual_qty
        batch   = Stock_summary.objects.filter(product=item.item,company=com, godown__godown_type=True, closing_balance__gt=0).order_by('batch', 'godown__name')
        stk     = []
        for i in batch:
            qty -= i.closing_balance
            if qty <= 0:
                i.closing_balance += qty
                stk.append(i)
                break
            stk.append(i)
        it[item.item.product_code] = stk
        it['qty'] = qty
    context = {'so': so, 'items': items, 'results': it}

    return render(request, 'sales/partials/so.html', context)

def load_dn(request):
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    no = request.GET.get('sono')
    if 'PI' in no:
        dn = ProformaInvoice.objects.get(company=com,inv_no=no)
        items = ProformaInvItems.objects.filter(inv=dn)
    else:
        dn = Delivery_note.objects.get(company=com,dn_no=no)
        items = DnItems.objects.filter(dn=dn)
    context = {'dn': dn, 'items': items}

    return render(request, 'sales/partials/dn.html', context)

def load_dn_items(request):
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    dn = Delivery_note.objects.get(company=com,dn_no=request.GET.get('sono'))
    items = DnItems.objects.filter(dn=dn).order_by('item')
    context = {'dn': dn, 'items': items}

    return render(request, 'sales/partials/dn-items.html', context)

def load_month_inv(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com     = Company.objects.get(id=skey)
    month   = request.GET.get('month').split('-')
    today = date(2022,10,1)
    pos     = Invoice.objects.filter(company=com,is_ict = False,inv_date__month=month[0],inv_date__year=month[1]).order_by('inv_no').values_list('inv_no',flat = True)

    return render(request, 'sales/partials/month_inv.html', {'states': pos})

def load_cn(request):
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    grn         = Invoice.objects.get(company=com,inv_no=request.GET.get('grn'))
    items       = InvItems.objects.filter(inv=grn)

    context = {'grn': grn, 'items': items}

    return render(request, 'sales/partials/cn.html', context)

def load_qdn(request):
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    grn         = Invoice.objects.get(company=com,inv_no=request.GET.get('grn'))
    pitems      = InvItems.objects.filter(inv=grn)

    context = {'grn': grn, 'items': pitems}

    return render(request, 'sales/partials/qdn.html', context)

def load_rso(request):

    inv         = Invoice.objects.get(inv_no=request.GET.get('inv'))
    items      = InvItems.objects.filter(inv=inv)

    context = {'inv': inv, 'items': items}

    return render(request, 'sales/partials/rso.html', context)

def load_ivt(request):

    inv        = Rso.objects.get(id=request.GET.get('sono'))
    items      = RsoItems.objects.filter(inv=inv)

    context = {'items': items}

    return render(request, 'sales/partials/ivt.html', context)