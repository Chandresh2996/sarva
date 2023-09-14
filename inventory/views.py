from datetime import date
from decimal import Decimal
from django.db.models import Sum
from django.core.exceptions import *
from django.db import IntegrityError
from purchase.models import PiItems, Purchase
from sales.models import InvItems, Invoice, RsoItems, SaleQty
from sales.views import salable
from tablib import Dataset
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.views.generic import ListView
from django.views.generic.edit import CreateView, UpdateView
import requests
from django.contrib.messages.views import SuccessMessageMixin
from django.utils import six
from company.models import Company
from sales.models import Rso
from inventory.xmlcreator import brandxml, categoryxml, editcategoryxml, godownxml, pmxml, uomxml
from django.db.models import Q
from ledgers.models import LedgersType, Party_contact_details, Party_master, Price_level, Price_list, State
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from core.decorators import auth_users, allowed_users, is_company
from warehouse.models import Stock_summary
from .models import  Brand, Category, Class, Godown, Gst_list, Product_master, ProductType, Std_rate, SubBrand, SubClass, UnitOfMeasure, Uqc, Currency
from django.utils.decorators import method_decorator
from django.http import JsonResponse
from django.db.models import F
from .forms import BrandForm, SubBrandForm, CategoryForm, ClassForm, SubClassForm, ProductTypeForm, GodownForm, UnitOfMeasureForm, CurrencyForm, Price_levelForm

def inventory(request):

    products        = Product_master.objects.count()
    brands          = Brand.objects.count()
    subbrands       = SubBrand.objects.count()
    categories      = Category.objects.count()
    p_classes       = Class.objects.count()
    subcalsses      = SubClass.objects.count()
    producttypes    = ProductType.objects.count()
    godowns         = Godown.objects.count()
    uoms            = UnitOfMeasure.objects.count()
    currency        = Currency.objects.count()

    context = {
        "products": products,
        "brands": brands,
        "subbrands": subbrands,
        "categories": categories,
        "p_classes": p_classes,
        "subcalsses": subcalsses,
        "producttypes": producttypes,
        "godowns": godowns,
        "uoms": uoms,
        "currency":currency
    }

    return render(request, 'inventory/inventory.html', context)

def search(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return HttpResponse ('Please Select Company First')
    com         = Company.objects.get(id=skey)

    query           = request.GET.get("q", None)

    if query is not None:
        product     = Product_master.objects.get(product_code= query)

        stock       = Stock_summary.objects.filter(company=com,product=product).aggregate(Sum('closing_balance'))
        purchase    = PiItems.objects.filter(item = product).order_by('-created')

    return render(request, 'inventory/search.html', {'product':product, 'stock':stock, 'purchase':purchase})


@method_decorator(allowed_users(allowed_roles=['Admin','Article View']), name='dispatch')
class product(ListView):
    model           = Product_master
    template_name   = 'inventory/product.html'
    context_object_name = 'products'
    paginate_by = 10
    def get_queryset(self):
        query       = self.request.GET.get('q', None)
        qs          = Product_master.objects.all().order_by("-created")
        if query is not None:
            qs=qs.filter(
                Q(product_code__icontains=query) |
                Q(product_name__icontains=query) |
                Q(article_code__icontains=query) |
                Q(brand__name__icontains=query)
            )
        return qs

@allowed_users(allowed_roles=['Admin', 'Article Create'])
def add_product(request):

    if request.method == 'POST':

        if request.POST.get("product_name"):
            pro_name = request.POST.get("product_name")
        else:
            messages.error(request, "Please Enter the Product Name")
        if request.POST.get("part_no"):
            pro_code = request.POST.get("part_no")
        else:
            messages.error(request, "Please Enter the Product Code")

        description = request.POST.get("description")
        note = request.POST.get("note")

        if request.POST.get("maintain_batch"):
            maintain_batch = True
            if request.POST.get("track_mfd"):
                track_mfd = True
            else:
                track_mfd = False
            if request.POST.get("track_expiry"):
                track_expiry = True
            else:
                track_expiry = False
        else:
            maintain_batch = False
            track_expiry = False
            track_mfd = False

        if request.POST.get("article_code"):
            article_code = request.POST.get("article_code")
        else:
            messages.error(request, "Please Enter the Article Code")

        ean_code = request.POST.get("ean_code")


        if request.POST.get("old_sku"):
            old_sku_code = request.POST.get("old_sku")
        else:
            old_sku_code = None
        if request.POST.get("uom"):
            unit = request.POST.get("uom")
        else:
            messages.error(request, "Please Enter the Unit")
        if request.POST.get("costingmethod"):
            costingmethod = request.POST.get("costingmethod")

        if request.POST.get("mvm"):
            mvm = request.POST.get("mvm")

        if request.POST.get("set_behavior_options"):
            set_behavior_options = True
            if request.POST.get("ipd"):
                ipd = True
            else:
                ipd = False
            if request.POST.get("ins"):
                ins = True
            else:
                ins = False
            if request.POST.get("tsm"):
                tsm = True
            else:
                tsm = False
            if request.POST.get("tpc"):
                tpc = True
            else:
                tpc = False
            if request.POST.get("trs"):
                trs = True
            else:
                trs = False
        else:
            set_behavior_options = False
            ipd = False
            ins = False
            tsm = False
            tpc = False
            trs = False

        shape_code = request.POST.get("shape_code")
        size = request.POST.get("size")
        style = request.POST.get("style")
        series = request.POST.get("series")
        pattern = request.POST.get("pattern")
        coi = request.POST.get("coi")
        colour = request.POST.get("colour")
        if request.POST.get("inner"):
            inner = Decimal(request.POST.get("inner"))
        else:
            inner = None
        if request.POST.get("outer"):
            outer = Decimal(request.POST.get("outer"))
        else:
            outer = None
        importedby = request.POST.get("importedby")
        mfdby = request.POST.get("mfdby")
        mktby = request.POST.get("mktby")
        portfolio = request.POST.get("portfolio")

        unit = UnitOfMeasure.objects.get(symbol=unit)
        brand = Brand.objects.get(name=request.POST.get("brand"))

        if request.POST.get("categorys"):
            category = Category.objects.get(name=request.POST.get("categorys"))
        else:
            category = Category.objects.get(name="NA")

        if request.POST.get("class"):
            product_class = Class.objects.get(name=request.POST.get("class"))
        else:
            product_class = Class.objects.get(name="NA")

        if request.POST.get("subclass"):
            subclass = SubClass.objects.get(name=request.POST.get("subclass"))
        else:
            subclass = SubClass.objects.get(name="NA")

        if request.POST.get("subbrand"):
            subbrand = SubBrand.objects.get(name=request.POST.get("subbrand"))
        else:
            subbrand = SubBrand.objects.get(name="NA")

        productyype = ProductType.objects.get(
            name=request.POST.get("product_type"))

        if request.POST.get("set_bom"):
            set_bom = True
        else:
            set_bom = False

        if request.POST.get("set_std_rate"):
            set_std_rate = True
        else:
            set_std_rate = False

        if request.POST.get("salesledger") != '':
            sled = request.POST.get("salesledger")
            dl_sales = LedgersType.objects.get(name=sled)
        else:
            messages.error(request, "Please Select the Sales Ledger")
        if request.POST.get('mrp'):
            mrp = request.POST.get('mrp')
        else:
            mrp=0
        if request.POST.get('igst'):
            gst = request.POST.get('igst')
        else:
            gst=0
        if request.POST.get("purchaseledger") != '':
            pled = request.POST.get("purchaseledger")
            dl_purchase = LedgersType.objects.get(name=pled)
        else:
            messages.error(request, "Please Select the Purchase Ledger")

        # try:
        pm = Product_master.objects.create(product_name=pro_name, product_code=pro_code, description=description, notes=note, dl_sales=dl_sales, dl_purchase=dl_purchase,
                                                brand=brand, category=category, product_class=product_class, sub_class=subclass, sub_brand=subbrand,
                                                product_type=productyype, units_of_measure=unit, is_batch=maintain_batch,
                                                track_dom=track_mfd, exp_date=track_expiry, bill_of_material=set_bom, set_std_rate=set_std_rate,
                                                article_code=article_code, ean_code=ean_code, old_product_code=old_sku_code, costing_method=costingmethod,
                                                valuation_method=mvm, behaviour=set_behavior_options, ipd=ipd, ins=ins, tsm=tsm, tpc=tpc, trs=trs, shape_code=shape_code,
                                                size=size, style_shape=style, series=series, pattern=pattern, country_of_origin=coi, color_shade_theme=colour, inner_qty=inner,
                                                outer_qty=outer, imported_by=importedby, mfd_by=mfdby, mkt_by=mktby, product_portfolio=portfolio,mrp=Decimal(mrp),gst=Decimal(gst))
        messages.success(request, "Product: {} Added Successfully".format(pro_name))
        # except BaseException as err:
        #     print(err)
        #     messages.error(request, "Product with same product code Exist")

        if request.POST.get("altuom"):
            altunit = UnitOfMeasure.objects.get( symbol=request.POST.get("altuom"))
            pm.additional_units = altunit
            pm.save()
        # try:
        if request.POST.get("gstapplicable") != "Not Applicable":
            suply_type = request.POST.get("suply_type")
            if request.POST.get("is_set_gst"):

                applicable_from = date.today()
                hsnmastername = request.POST.get("hsnmastername")
                hsncode = request.POST.get("hsncode")
                if request.POST.get("is_Non_gst"):
                    is_Non_gst = True
                else:
                    is_Non_gst = False
                calc_type = request.POST.get("calc_type")
                taxability = request.POST.get("taxability")

                if request.POST.get("reverse_charge"):
                    reverse_charge = True
                else:
                    reverse_charge = True

                if request.POST.get("input_credit_ineligible"):
                    input_credit_ineligible = True
                else:
                    input_credit_ineligible = True

                cgst = request.POST.get("cgst")
                sgst = request.POST.get("sgst")
                igst = request.POST.get("igst")
                suply_type = request.POST.get("suply_type")

                Gst_list.objects.create(product=pm, applicable_from=applicable_from, discription=hsnmastername,
                                                    hsncode=hsncode, is_Non_gst=is_Non_gst, calc_type=calc_type, taxability=taxability, reverse_charge=reverse_charge,
                                                    input_credit_ineligible=input_credit_ineligible, cgstrate=cgst, sgstrate=sgst, igstrate=igst, suply_type=suply_type)

                messages.success = "Product Created Successfully"

            # except BaseException as err:
            #     print(err)
            #     # pm.delete()
        com = Company.objects.all()
        gstdetail = Gst_list.objects.filter(product = pm)
        for i  in com:
            xml = pmxml(pm, gstdetail)
            mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
            mainxml = mainxml.replace('Company_name',i.tally_name)
            mainxml = mainxml.replace('xml_creator', xml)
            mainxml = mainxml.replace('<STATENAME>', "<STATENAME>&#4; ")
            mainxml = mainxml.replace('<ISUPDATINGTARGETID>No</ISUPDATINGTARGETID>', '<ISUPDATINGTARGETID>Yes</ISUPDATINGTARGETID>')
            payload = mainxml.replace('<GSTAPPLICABLE>', '<GSTAPPLICABLE>&#4;')
            req = requests.post(url=i.ipaddress, data=payload)
        return HttpResponse(req)
        return redirect('inventory:product')    

    brand = Brand.objects.all()
    category = Category.objects.all()
    class_ = Class.objects.all()
    subclass = SubClass.objects.all()
    subbrand = SubBrand.objects.all()
    units = UnitOfMeasure.objects.all()
    product_type = ProductType.objects.all()
    states = State.objects.all()
    items = Product_master.objects.all()
    ledgers = LedgersType.objects.all()

    context = {'states': states, 'brands': brand, 'category': category, 'classes': class_, 'subclasses': subclass,
               'subbrands': subbrand, 'uoms': units, 'product_types': product_type, 'items': items, 'ledgers': ledgers}

    return render(request, 'inventory/add_product.html', context)

@allowed_users(allowed_roles=['Admin', 'Article Update'])
def edit_product(request, pk):

    if request.method == 'POST':
        pm = Product_master.objects.get(pk=pk)

        if request.POST.get("product_name"):
            pro_name = request.POST.get("product_name")
        else:
            return HttpResponse("Please Enter The Product Name")
        if request.POST.get("part_no"):
            pro_code = request.POST.get("part_no")
        else:
            return HttpResponse("Please Enter The Product Code")

        description = request.POST.get("description")
        note = request.POST.get("note")

        if request.POST.get("maintain_batch"):
            maintain_batch = True
            if request.POST.get("track_mfd"):
                track_mfd = True
            else:
                track_mfd = False
            if request.POST.get("track_expiry"):
                track_expiry = True
            else:
                track_expiry = False
        else:
            maintain_batch = False
            track_expiry = False
            track_mfd = False

        if request.POST.get("article_code"):
            article_code = request.POST.get("article_code")
        else:
            return HttpResponse("Please Enter The Article Code")

        ean_code = request.POST.get("ean_code")

        if request.POST.get("old_sku"):
            old_sku_code = request.POST.get("old_sku")
        else:
            old_sku_code = None
        if request.POST.get("uom"):
            unit = request.POST.get("uom")
        else:
            return HttpResponse("Please Enter The Unit Of Measure")

        if request.POST.get("costingmethod"):
            costingmethod = request.POST.get("costingmethod")

        if request.POST.get("mvm"):
            mvm = request.POST.get("mvm")

        if request.POST.get("set_behavior_options"):
            set_behavior_options = True
            if request.POST.get("ipd"):
                ipd = True
            else:
                ipd = False
            if request.POST.get("ins"):
                ins = True
            else:
                ins = False
            if request.POST.get("tsm"):
                tsm = True
            else:
                tsm = False
            if request.POST.get("tpc"):
                tpc = True
            else:
                tpc = False
            if request.POST.get("trs"):
                trs = True
            else:
                trs = False
        else:
            set_behavior_options = False
            ipd = False
            ins = False
            tsm = False
            tpc = False
            trs = False

        shape_code = request.POST.get("shape_code")
        size = request.POST.get("size")
        style = request.POST.get("style")
        series = request.POST.get("series")
        pattern = request.POST.get("pattern")
        coi = request.POST.get("coi")
        colour = request.POST.get("colour")
        if request.POST.get("inner"):
            inner = Decimal(request.POST.get("inner"))
        else:
            inner = None
        if request.POST.get("outer"):
            outer = Decimal(request.POST.get("outer"))
        else:
            outer = None
        importedby = request.POST.get("importedby")
        mfdby = request.POST.get("mfdby")
        mktby = request.POST.get("mktby")
        portfolio = request.POST.get("portfolio")

        unit = UnitOfMeasure.objects.get(symbol=unit)
        brand = Brand.objects.get(name=request.POST.get("brand"))
        if request.POST.get("categorys"):
            category = Category.objects.get(name=request.POST.get("categorys"))
        else:
            category = Category.objects.get(name="NA")

        if request.POST.get("class"):
            product_class = Class.objects.get(name=request.POST.get("class"))
        else:
            product_class = Class.objects.get(name="NA")

        if request.POST.get("subclass"):
            subclass = SubClass.objects.get(name=request.POST.get("subclass"))
        else:
            subclass = SubClass.objects.get(name="NA")

        if request.POST.get("subbrand"):
            subbrand = SubBrand.objects.get(name=request.POST.get("subbrand"))
        else:
            subbrand = SubBrand.objects.get(name="NA")
        productyype = ProductType.objects.get( name=request.POST.get("product_type"))

        if request.POST.get("set_bom"):
            set_bom = True
        else:
            set_bom = False

        if request.POST.get("set_std_rate"):
            set_std_rate = True
        else:
            set_std_rate = False

        if request.POST.get("salesledger"):
            sled = request.POST.get("salesledger")
            dl_sales = LedgersType.objects.get(name=sled)
        else:
            return HttpResponse("Please Select The Sales Ledger")

        if request.POST.get("purchaseledger"):
            pled = request.POST.get("purchaseledger")
            dl_purchase = LedgersType.objects.get(name=pled)
        else:
            return HttpResponse("Please Select The Purchase Ledger")
        if request.POST.get("is_set_gst"):
            pm.gst = Decimal(request.POST.get("igst"))
        pm.mrp = request.POST.get('mrp')
        pm.product_name=pro_name
        pm.product_code=pro_code
        pm.description=description
        pm.notes=note
        pm.dl_sales=dl_sales
        pm.dl_purchase=dl_purchase
        pm.brand=brand
        pm.category=category
        pm.product_class=product_class
        pm.sub_class=subclass
        pm.sub_brand=subbrand
        pm.product_type=productyype
        pm.units_of_measure=unit
        pm.is_batch=maintain_batch
        pm.track_dom=track_mfd
        pm.exp_date=track_expiry
        pm.bill_of_material=set_bom
        pm.set_std_rate=set_std_rate
        pm.article_code=article_code
        pm.ean_code=ean_code
        pm.old_product_code=old_sku_code
        pm.costing_method=costingmethod
        pm.valuation_method=mvm
        pm.behaviour=set_behavior_options
        pm.ipd=ipd
        pm.ins=ins
        pm.tsm=tsm
        pm.tpc=tpc
        pm.trs=trs
        pm.shape_code=shape_code
        pm.size=size
        pm.style_shape=style
        pm.series=series
        pm.pattern=pattern
        pm.country_of_origin=coi
        pm.color_shade_theme=colour
        pm.inner_qty=inner
        pm.outer_qty=outer
        pm.imported_by=importedby
        pm.mfd_by=mfdby
        pm.mkt_by=mktby
        pm.product_portfolio=portfolio

        if request.POST.get("altuom"):
            altunit = UnitOfMeasure.objects.get(symbol=request.POST.get("altuom"))
            pm.additional_units = altunit

        pm.save()

        try:

            if set_std_rate:
                pd = request.POST.get("purchase_date")
                pr = request.POST.get("purchase_rate")
                if pd & pr:
                    Std_rate.objects.update_or_create( product=pm, rate_type=1, defaults={'applicable_from':applicable_from, 'rate':pr, 'uom':pm.units_of_measure})
                sd = request.POST.get("selling_date")
                sr = request.POST.get("selling_rate")
                if sd & sr:
                    Std_rate.objects.update_or_create( product=pm, rate_type=2, defaults={'applicable_from':applicable_from, 'rate':sr, 'uom':pm.units_of_measure})

            if request.POST.get("gstapplicable") != "Not Applicable":
                suply_type = request.POST.get("suply_type")
                if request.POST.get("is_set_gst"):

                    applicable_from = date.today()
                    hsnmastername = request.POST.get("hsnmastername")
                    hsncode = request.POST.get("hsncode")
                    if request.POST.get("is_Non_gst"):
                        is_Non_gst = True
                    else:
                        is_Non_gst = False
                    calc_type = request.POST.get("calc_type")
                    taxability = request.POST.get("taxability")

                    if request.POST.get("reverse_charge"):
                        reverse_charge = True
                    else:
                        reverse_charge = True

                    if request.POST.get("input_credit_ineligible"):
                        input_credit_ineligible = True
                    else:
                        input_credit_ineligible = True

                    cgst = request.POST.get("cgst")
                    sgst = request.POST.get("sgst")
                    igst = request.POST.get("igst")
                    suply_type = request.POST.get("suply_type")

                    Gst_list.objects.update_or_create(product=pm, applicable_from=applicable_from,defaults= {'discription':hsnmastername,
                                                      'hsncode':hsncode, 'is_Non_gst':is_Non_gst, 'calc_type':calc_type, 'taxability':taxability,
                                                      'reverse_charge':reverse_charge,'input_credit_ineligible':input_credit_ineligible,
                                                        'cgstrate':cgst, 'sgstrate':sgst, 'igstrate':igst, 'suply_type':suply_type})

        except BaseException as err:
            print(err)
        gstdetail = Gst_list.objects.filter(product = pm)
        com = Company.objects.all()
        for i  in com:
            xml = pmxml(pm, gstdetail)
            mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
            mainxml = mainxml.replace('Company_name',i.tally_name)
            mainxml = mainxml.replace('xml_creator', xml)
            mainxml = mainxml.replace('<STATENAME>', "<STATENAME>&#4; ")
            payload = mainxml.replace('<ISUPDATINGTARGETID>No</ISUPDATINGTARGETID>', '<ISUPDATINGTARGETID>Yes</ISUPDATINGTARGETID>')
            payload = mainxml.replace('<GSTAPPLICABLE>', '<GSTAPPLICABLE>&#4;')
            print(payload)
            req = requests.post(url=i.ipaddress, data=payload)
        return HttpResponse(req)
        return redirect('inventory:product')

    product = Product_master.objects.get(pk=pk)
    gst = Gst_list.objects.filter(product=product)
    brand = Brand.objects.all()
    category = Category.objects.all()
    class_ = Class.objects.all()
    subclass = SubClass.objects.all()
    subbrand = SubBrand.objects.all()
    units = UnitOfMeasure.objects.all()
    product_type = ProductType.objects.all()
    states = State.objects.all()
    ledgers = LedgersType.objects.all()
    return render(request, 'inventory/edit_product.html', {'product': product,'states': states, 'brands': brand, 'category': category, 'classes': class_, 'subclasses': subclass,
               'subbrands': subbrand, 'uoms': units, 'product_types': product_type, 'gst': gst, 'ledgers': ledgers})

@allowed_users(allowed_roles=['Admin','Article View'])
def show_product(request, pk):

    product = Product_master.objects.get(pk=pk)
    gst = Gst_list.objects.filter(product=product)
    return render(request, 'inventory/show_product.html', {'product': product,'gst':gst})

@allowed_users(allowed_roles=['Admin', 'Article Delete'])
def delete_product(request, pk):

    product = Product_master.objects.get(pk=pk)

    return render(request, 'inventory/show_product.html', {'product': product})


@method_decorator(allowed_users(allowed_roles=['Admin', 'Brand View']),name='dispatch')
class ProductBrandView(ListView):
    model = Brand
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
       data = super().get_context_data(**kwargs)
       data['title'] = 'brand/create'
       data['edit'] = 'brand/edit/'
       data['tag'] = 'Brand'
       return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Brand.objects.values('under', 'code', 'name', 'id').order_by("-created") #Brand.objects.all().order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Brand Create']), name='dispatch')
class add_brand(SuccessMessageMixin,    CreateView):
    model = Brand
    template_name = 'inventory/common.html'
    success_url = "/ivt/brand"
    form_class = BrandForm
    success_message = "Form Successfully Submited"

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Brand'
        data['url'] = 'Brand'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Brand Update']), name='dispatch')
class edit_brand(UpdateView):
    model = Brand
    template_name = 'inventory/common.html'
    success_url = "/ivt/brand"
    form_class = BrandForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Brand'
        data['url'] = 'Brand'
        data['action'] = 'Edit'
        data['div']=4
        return data 

@method_decorator(allowed_users(allowed_roles=['Admin', 'Category View']), name='dispatch')
class ProductCategoryView(ListView):
    model = Category
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
       data = super().get_context_data(**kwargs)
       data['title'] = 'category/create'
       data['edit'] = 'category/edit/'
       data['tag'] = 'Category'
       return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Category.objects.values('under', 'name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Category Create']), name='dispatch')
class add_category(CreateView):
    model = Category
    template_name = 'inventory/common.html'
    success_url = "/ivt/category"
    form_class = CategoryForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Category'
        data['url'] = 'Category'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Category Update']), name='dispatch')
class edit_category(UpdateView):
    model = Category
    template_name = 'inventory/common.html'
    success_url = "/ivt/category"
    form_class = CategoryForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Category'
        data['url'] = 'Category'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Product Class View']), name='dispatch')
class ProductClassView(ListView):
    model = Class
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
       data = super().get_context_data(**kwargs)
       data['title'] = 'class/create'
       data['edit'] = 'class/edit/'
       data['tag'] = 'Class'
       return data
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Class.objects.values('name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Product Class Create']), name='dispatch')
class add_class(CreateView):
    model = Class
    template_name = 'inventory/common.html'
    success_url = "/ivt/class"
    form_class = ClassForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Class'
        data['url'] = 'Class'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Product Class Update']), name='dispatch')
class edit_class(UpdateView):
    model = Class
    template_name = 'inventory/common.html'
    success_url = "/ivt/class"
    form_class = ClassForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Class'
        data['url'] = 'Class'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Godown View']), name='dispatch')
class GodownView(ListView):
    model = Godown
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'godown/create'
        data['edit'] = 'godown/edit/'
        data['tag'] = 'Godown'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Godown.objects.values(under=F('parent__name'), Name=F('name'), Type=F('godown_type')).annotate(id=F('id'))
        if query is not None:
            qs=qs.filter(name__icontains=query)
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Godown Create']), name='dispatch')
class add_godown(CreateView):
    model = Godown
    template_name = 'inventory/common.html'
    success_url = "/ivt/godown"
    form_class = GodownForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Godown'
        data['url'] = 'Godown'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Godown Update']), name='dispatch')
class edit_godown(UpdateView):
    model = Godown
    template_name = 'inventory/common.html'
    success_url = "/ivt/godown"
    form_class = GodownForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Godown'
        data['url'] = 'Godown'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Subbrand View']), name='dispatch')
class ProductSubBrandView(ListView):
    model = SubBrand
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
       data = super().get_context_data(**kwargs)
       data['title'] = 'subbrand/create'
       data['edit'] = 'subbrand/edit/'
       data['tag'] = 'Sub Brand'
       return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = SubBrand.objects.values('name', 'id').order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query)
        return qs

# Class view to save form data in database.
@method_decorator(allowed_users(allowed_roles=['Admin', 'Subbrand Create']), name='dispatch')
class add_subbrand(CreateView):
    model = SubBrand
    template_name = 'inventory/common.html'
    success_url = "/ivt/subbrand"
    form_class = SubBrandForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'SubBrand'
        data['url'] = 'SubBrand'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Subbrand Update']), name='dispatch')
class edit_subbrand(UpdateView):
    model = SubBrand
    template_name = 'inventory/common.html'
    success_url = "/ivt/subbrand"
    form_class = SubBrandForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'SubBrand'
        data['url'] = 'SubBrand'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin','Subclass View']), name='dispatch')
class ProductSubClassView(ListView):
    model = SubClass
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'subclass/create'
        data['edit'] = 'subclass/edit/'
        data['tag'] = 'Sub Class'
        return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = SubClass.objects.values('name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Subclass Create']), name='dispatch')
class add_subclass(CreateView):
    model = SubClass
    template_name = 'inventory/common.html'
    success_url = "/ivt/subclass"
    form_class = SubClassForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Sub Class'
        data['url'] = 'SubClass'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Subclass Update']), name='dispatch')
class edit_subclass(UpdateView):
    model = SubClass
    template_name = 'inventory/common.html'
    success_url = "/ivt/subclass"
    form_class = SubClassForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Sub Class'
        data['url'] = 'SubClass'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin','Product Type View']), name='dispatch')
class ProductTypeView(ListView):
    model = ProductType
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10
    
    def get_context_data(self, **kwargs):
       data = super().get_context_data(**kwargs)
       data['title'] = 'product_type/create'
       data['edit'] = 'product_type/edit/'
       data['tag'] = 'Product Type'
       return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = ProductType.objects.values('name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Product Type Create']), name='dispatch')
class add_product_type(CreateView):
    model = ProductType
    template_name = 'inventory/common.html'
    success_url = "/ivt/product_type"
    form_class = ProductTypeForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Product Type'
        data['url'] = 'product_type'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Product Type Update']), name='dispatch')
class edit_product_type(UpdateView):
    model = ProductType
    template_name = 'inventory/common.html'
    success_url = "/ivt/product_type"
    form_class = ProductTypeForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Product Type'
        data['url'] = 'product_type'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Customer Margin View']), name='dispatch')
class PricelevelView(ListView):

    model               = Price_level
    template_name       = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by         = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'pricelevel/add'
        data['edit'] = 'pricelevel/edit/'
        data['tag'] = 'Price Level'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Price_level.objects.values('name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Customer Margin Create']), name='dispatch')
class add_pricelevel(CreateView):
    model = Price_level
    template_name = 'inventory/common.html'
    success_url = "/ivt/pricelevel"
    form_class = Price_levelForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Price Level'
        data['url'] = 'pricelevel'
        data['div']=6
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Channel Update', 'Channel Delete']), name='dispatch')
class edit_pricelevel(UpdateView):
    model = Price_level
    template_name = 'inventory/common.html'
    success_url = "/ivt/pricelevel"
    form_class = Price_levelForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Price Level'
        data['url'] = 'pricelevel'
        data['action'] = 'Edit'
        data['div']=6
        return data

@allowed_users(allowed_roles=['Admin','Customer Margin Delete'])
def edit_pricelevel1(request,pk):

    pl=Price_level.objects.get(pk=pk)

    if request.method == "POST":
        pl.name = request.POST.get("name")
        pl.save()

        return redirect(request)

    context = { 'pl' : pl }
    return render(request, 'inventory/edit_pricelevel.html', context)


def pricelistheader(request):

    fixed_header = list(Price_level.objects.values_list('name', flat=True))
    return JsonResponse({'fixed_header':fixed_header})

from operator import itemgetter
from itertools import groupby

def pricelistdata(request):

    pl          = Price_list.objects.values('product__product_code','price_level_id','rate')
    rows        = groupby(pl, itemgetter('product__product_code'))
    data        = {c_title: list(items) for c_title, items in rows}
    result = []
    for  i,j in data.items():
        line = {'code':i}
        for k in j:
            line[k['price_level_id']] = k['rate']
        result.append(line)

    return JsonResponse({'data':result})

@allowed_users(allowed_roles=['Admin', 'Pricelist View', 'Pricelist Create', 'Pricelist Update', 'Pricelist Delete'])
def pricelist(request):

    if request.method == "POST":
        under = request.POST.get("under")
        pricelevel = Price_level.objects.get(name=under)
        item = request.POST.get("item")
        product = Product_master.objects.get(product_code=item)
        rate = request.POST.get("rate")
        date_ = request.POST.get("date")
        Price_list.objects.get_or_create(price_level=pricelevel, product=product, rate=rate, applicable_from=date_)


    pricelevels = Price_level.objects.all()
    pricelists = Price_list.objects.all()
    items = Product_master.objects.all()

    context = {'pricelevels': pricelevels,
               'pricelists': pricelists, 'items': items}

    return render(request, 'inventory/pricelist.html', context)

from datetime import date
@allowed_users(allowed_roles=['Admin', 'Pricelist Create', 'Pricelist Update', 'Pricelist Delete'])
def add_pricelist(request):

    if request.method == "POST":
        under = request.POST.get("under")
        pricelevel = Price_level.objects.get(name=under)
        item = request.POST.get("item")
        product = Product_master.objects.get(product_code=item)
        rate = request.POST.get("rate")
        date_ = date.today()
        Price_list.objects.update_or_create(price_level=pricelevel, product=product, defaults={'rate': Decimal(rate) , 'applicable_from':date_})

        with open('static/src/pricelist.json', 'r') as f:
            my_json_obj = f.read()
        data = json.loads(my_json_obj)
        for i in data['data']:
            if i['code'] == item:
                i[pricelevel.id] = rate
        with open('static/src/pricelist.json', 'w') as fp:
            json.dump(data, fp)
        messages.success(request, "Price Level Added Successfully")

        return redirect('inventory:pricelist')


    pricelevels = Price_level.objects.all()
    pricelists = Price_list.objects.all()
    items = Product_master.objects.all()

    context = {'pricelevels': pricelevels,
               'pricelists': pricelists, 'items': items}

    return render(request, 'inventory/add_pricelist.html', context)

@allowed_users(allowed_roles=['Admin', 'Pricelist Update', 'Pricelist Delete'])
def edit_pricelist(request, pk):

    pl= Price_list.objects.get(id=pk)

    if request.method == "POST":
        under               = request.POST.get("under")
        pricelevel          = Price_level.objects.get(name=under)
        item                = request.POST.get("item")
        product             = Product_master.objects.get(product_code=item)
        rate                = request.POST.get("rate")
        date_               = request.POST.get("date")
        pl.price_level      = pricelevel
        pl.product          = product
        pl.rate             = rate
        pl.applicable_from  = date_
        pl.save()
        messages.success(request, "Price Level Updated Successfully".format(name))
        return redirect('inventory:pricelist')

    pricelevels = Price_level.objects.all()
    items = Product_master.objects.all()

    context = {'pricelevels': pricelevels, 'pricelists': pl, 'items': items}
    return render(request, 'inventory/edit_pricelist.html', context)

@allowed_users(allowed_roles=['Admin', 'Scheme View', 'Scheme Create', 'Scheme Update', 'Scheme Delete'])
def scheme(request):

    context = {'data': ''}

    return render(request, 'inventory/scheme.html', context)

@allowed_users(allowed_roles=['Admin', 'Scheme Create', 'Scheme Update', 'Scheme Delete'])
def add_scheme(request):

    context = {'data': ''}

    return render(request, 'inventory/add_scheme.html', context)

@allowed_users(allowed_roles=['Admin', 'Scheme Update', 'Scheme Delete'])
def edit_scheme(request):

    context = {'data': ''}

    return render(request, 'inventory/edit_scheme.html', context)


@method_decorator(allowed_users(allowed_roles=['Admin', 'Units Of Measure Create', 'Units Of Measure Update', 'Units Of Measure Delete', 'Units Of Measure View']), name='dispatch')
class UomView(ListView):
    model = UnitOfMeasure
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'uom/create'
        data['edit'] = 'uom/edit/'
        data['tag'] = 'Units Of Measure'
        return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = UnitOfMeasure.objects.values(UQC=F('uqc__name'), Name=F('name'), Symbol=F('symbol'), Decimal_Places=F('decimal_places')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(symbol__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Units Of Measure Create', 'Units Of Measure Update', 'Units Of Measure Delete']), name='dispatch')
class add_uom(CreateView):
    model = UnitOfMeasure
    template_name = 'inventory/common.html' 
    success_url = "/ivt/uom"
    form_class = UnitOfMeasureForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Units Of Measure'
        data['url'] = 'uom'
        data['action'] = 'Create'
        data['div']=3
        return data
    
@method_decorator(allowed_users(allowed_roles=['Admin', 'Units Of Measure Update', 'Units Of Measure Delete']), name='dispatch')
class edit_uom(UpdateView):
    model = UnitOfMeasure
    template_name = 'inventory/common.html'
    success_url = "/ivt/uom"
    form_class = UnitOfMeasureForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Units Of Measure'
        data['url'] = 'uom'
        data['action'] = 'Edit'
        data['div']=3
        return data
    
#_________________________________________________________________  ajax  _______________________________________________________________________


def article(request):

    brand = request.GET.get('brand')
    itembrand = Brand.objects.get(name=brand)
    p = Product_master.objects.filter(brand=itembrand).count()
    article_code = '5' + str(itembrand.code) + str(p+10001)

    return HttpResponse(article_code)

def ajax_load_ledgers(request):
    product_type = request.GET.get('product_type')
    product = ProductType.objects.get(name=product_type)
    productdetails = str(product.dl_sales) + ',' + str(product.dl_purchase)
    return HttpResponse(productdetails)


def load_pm_upload(request):
    brand = request.GET.get('brand')
    return render(request, 'inventory/partials/pm-upload.html',)



def pm_import_data(request):

    if request.method == 'POST':
        file_format = request.POST.get('file-format1','Excel')
        dataset = Dataset()
        new_products = request.FILES['importData']
        com = Company.objects.all()

        if file_format == 'Excel':
            imported_data = dataset.load(new_products.read())

            for j,i in enumerate(imported_data):
                #try:
                    pd = Product_master.objects.filter(product_code=i[1]).exists()
                    if pd:
                        continue
                    pm = Product_master()
                    pm.product_name     =   i[0]
                    pm.product_code     =   i[1]
                    pm.description      =   i[2]
                    pm.notes            =   i[3]

                    br = Brand.objects.get(name=i[4].upper())
                    pm.brand            =   br

                    if i[5]:
                        ct = Category.objects.get(name=i[5].upper())
                    else:
                        ct = Category.objects.get(name="Primary")

                    pm.category         =   ct
                    if i[6]:
                        pc = Class.objects.get(name=i[6].upper())
                        pm.product_class    =   pc

                    if i[7]:
                        sc = SubClass.objects.get(name=i[7].upper())
                        pm.sub_class        =   sc

                    if i[8]:
                        sb = SubBrand.objects.get(name=i[8].upper())
                        pm.sub_brand        =   sb

                    pt = ProductType.objects.get(name=i[9].upper())
                    pm.product_type     =   pt

                    p  = Product_master.objects.filter(brand=br).count()
                    article_code        = '5' + str(br.code) + str(p+10001)
                    pm.article_code     =   article_code

                    pm.ean_code         =   i[11]
                    uom = UnitOfMeasure.objects.get(symbol=i[12].upper())
                    pm.units_of_measure =   uom

                    if i[13]:
                        auom = UnitOfMeasure.objects.get(symbol=i[13].upper())
                        pm.additional_units =   auom

                    if i[14].lower() == "yes" or 'y':
                        pm.is_batch         =   True
                    else:
                        pm.is_batch         =   False
                    if i[15].lower() == "yes" or 'y':
                        pm.track_dom        =   True
                    else:
                        pm.track_dom        =   False
                    if i[16].lower() == "yes" or 'y':
                        pm.exp_date         =   True
                    else:
                        pm.exp_date         =   False

                    pm.costing_method   =   i[17]
                    pm.valuation_method =   i[18]

                    if i[19].lower() == "yes" or 'y':
                        pm.ipd          =   True
                    else:
                        pm.ipd          =   False
                    if i[20].lower() == "yes" or 'y':
                        pm.ins          =   True
                    else:
                        pm.ins          =   False
                    if i[21].lower() == "yes" or 'y':
                        pm.tsm          =   True
                    else:
                        pm.tsm          =   False
                    if i[22].lower() == "yes" or 'y':
                        pm.tpc          =   True
                    else:
                        pm.tpc          =   False
                    if i[23].lower() == "yes" or 'y':
                        pm.trs          =   True
                    else:
                        pm.trs          =   False

                    if i[24].lower() == "yes" or 'y':
                        pm.isgstapplicable  =   True
                    else:
                        pm.isgstapplicable  =   False

                    pm.shape_code       =   i[37]
                    pm.size             =   i[38]
                    pm.style_shape      =   i[39]
                    pm.series           =   i[40]
                    pm.pattern          =   i[41]
                    pm.country_of_origin=   i[42]
                    pm.color_shade_theme=   i[43]

                    pm.inner_qty        =   i[44]
                    pm.outer_qty        =   i[45]
                    pm.imported_by      =   i[46]
                    pm.mfd_by           =   i[47]
                    pm.mkt_by           =   i[48]

                    dl_sales            =   LedgersType.objects.get(under__name='Sales Accounts', name=i[49])
                    pm.dl_sales         =   dl_sales

                    dl_purchase         =   LedgersType.objects.get(under__name='Purchase Accounts', name=i[50])

                    pm.dl_purchase      =   dl_purchase
                    pm.mrp              =   i[51]
                    pm.hsn              =   i[27]
                    pm.gst              =   i[33]

                    if i[52].lower() == "yes" or 'y':
                        pm.is_saleable  =   True
                    else:
                        pm.is_saleable  =   False

                    pm.save()

                    gst = Gst_list()
                    gst.product          =   pm
                    gst.applicable_from  =   i[25]
                    gst.calc_type        =   i[26]
                    gst.hsncode          =   i[27]
                    gst.discription      =   i[28]
                    gst.taxability       =   i[29]
                    if i[30]:
                        gst.reverse_charge  =   True
                    else:
                        gst.reverse_charge  =   False
                    if i[31]:
                        gst.is_Non_gst      =   True
                    else:
                        gst.is_Non_gst      =   False
                    if i[32]:
                        gst.input_credit_ineligible  =   True
                    else:
                        gst.input_credit_ineligible  =   False
                    gst.igstrate         =   i[33]
                    gst.cgstrate         =   i[34]
                    gst.sgstrate         =   i[35]
                    gst.suply_type       =   i[36]
                    gst.save()

                    for i  in com:
                        xml = pmxml(pm[0])
                        mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
                        mainxml = mainxml.replace('Company_name',i.tally_name)
                        mainxml = mainxml.replace('xml_creator', xml)
                        mainxml = mainxml.replace('<STATENAME>', "<STATENAME>&#4; ")
                        mainxml = mainxml.replace('<ISUPDATINGTARGETID>No</ISUPDATINGTARGETID>', '<ISUPDATINGTARGETID>Yes</ISUPDATINGTARGETID>')
                        payload = mainxml.replace('<GSTAPPLICABLE>', '<GSTAPPLICABLE>&#4;')
                        print(payload)
                        req = requests.post(url=i.ipaddress, data=payload)

                # except Exception as exp:
                #    return HttpResponse("There is a error in :" + str(exp) + " in row :" + str(j+1))

    return redirect('inventory:product')

def load_pl_upload(request):

    return render(request, 'inventory/partials/pl-upload.html',)

import xlsxwriter
import io
def load_pl_download(request):

    output = io.BytesIO()

    wb = xlsxwriter.Workbook(output, {'in_memory': True})

    ws = wb.add_worksheet("PriceList")
    row_num = 0

    bold = wb.add_format({'bold': True})

    pl = list(Price_level.objects.all().order_by('name').values_list('name',flat=True))

    columns = pl
    ws.write(0, 0, "code",bold)

    for col_num in range(len(columns)):
        ws.write(row_num, col_num+1, columns[col_num],bold)

    response = HttpResponse(output.read(), content_type="application/vnd.ms-excel")
    response['Content-Disposition'] = "attachment; filename=PriceListDemo.xlsx"

    output.close()

    return response

def load_ict_upload(request):

    no = request.GET.get('no')
    product_code = request.GET.get('product_code')

    product = Product_master.objects.get(product_code=product_code)
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)
    stock = Stock_summary.objects.filter(company=com,product=product, godown__godown_type=True).aggregate(Sum('closing_balance'))

    offermrp   = request.GET.get('offermrp')
    manualrate = request.GET.get('rate')
    actualqty = Decimal(request.GET.get('actualqty'))
    billqty = Decimal(request.GET.get('billqty'))
    freeqty = actualqty-billqty
    discount = Decimal(request.GET.get('discount'))

    price_level = Price_level.objects.get(name=request.GET.get('price_level'))

    if price_level.name == 'Manual':
        rate=manualrate
    else:
        pl = Price_list.objects.filter(product=product, price_level=price_level).first()
        rate=pl.rate

    amount = (billqty * Decimal(rate)) * ((100 - discount)/100)
    igst = (product.gst * amount / 100)
    sgst = (igst / 2)
    cgst = (igst / 2)
    context = {
        'no': no,
        'product': product,
        'offermrp': offermrp,
        'batch': product.mrp,
        'stock': stock["closing_balance__sum"],
        'actualqty': actualqty,
        'billqty': billqty,
        'freeqty': freeqty,
        'discount': discount,
        'igst': igst,
        'cgst': cgst,
        'sgst': sgst,
        'rate': rate,
        'amount': amount,
        'gst':product.gst
    }
    return render(request, 'sales/partials/so-upload.html', context)
import os
import json
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile

def pl_import_data(request):
    if request.method == 'POST':

        dataset = Dataset()
        new_products = request.FILES['importData']
        os.remove('static/src/PriceList.xlsx')
        default_storage.save('static/src/PriceList.xlsx', ContentFile(new_products.read()))

        dataset.xlsx = open('static/src/PriceList.xlsx', 'rb').read()

        for i in dataset:
            pc      = i[0]
            pd      = Product_master.objects.get(product_code=pc)
            for j,k in enumerate(dataset.headers[1:]):
                prc_l   = Price_level.objects.get(name=k)
                prc     = Decimal(i[j+1])
                Price_list.objects.update_or_create(price_level=prc_l, product=pd, defaults={'applicable_from':date.today(), 'rate':prc})

        return redirect('inventory:pricelist')

    return render(request, 'inventory/partials/pl-upload.html',)


def load_sc_upload(request):

    std = Std_rate.objects.all()

    return render(request, 'inventory/std_rate.html',{'std':std})


def edit_sc_upload(request, pk):

    std = Std_rate.objects.all()

    return render(request, 'inventory/std_rate.html',{'std':std})

def sc_import_data(request):
    if request.method == 'POST':

        dataset = Dataset()
        new_products = request.FILES['importData']

        imported_data = dataset.load(new_products.read())

        for i in imported_data:

            pc              = i[0]
            pd              = Product_master.objects.get(product_code=pc)
            rate            = i[1]
            applicable_from = date.today()

            Std_rate.objects.create(product = pd, rate_type = '1', applicable_from=applicable_from, rate=rate)

    return redirect(request, 'inventory:std_cost',)

def load_ict_upload(request):

    no = request.GET.get('no')
    product_code = request.GET.get('product_code')

    product         = Product_master.objects.get(product_code=product_code)
    try:
        skey        = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com             = Company.objects.get(id=skey)
    # stock           = SaleQty.objects.get(company=com,product=product)
    stock           = salable(com,product) #SaleQty.objects.get(company = com , product=product[0]).qty

    offermrp            = request.GET.get('offermrp')
    manualrate          = request.GET.get('rate')
    actualqty           = Decimal(request.GET.get('actualqty'))
    billqty             = Decimal(request.GET.get('billqty'))
    freeqty             = actualqty-billqty
    discount            = Decimal(request.GET.get('discount'))

    rate=manualrate
    gst = Gst_list.objects.filter(product=product).last()

    amount = (billqty * Decimal(rate)) * ((100 - discount)/100)
    igst = (gst.igstrate * amount / 100)
    sgst = (gst.sgstrate * amount / 100)
    cgst = (gst.cgstrate * amount / 100)
    context = {
        'no': no,
        'product': product,
        'offermrp': offermrp,
        'batch': product.mrp,
        'stock': stock,
        'billqty': billqty,
        'igst': igst,
        'cgst': cgst,
        'sgst': sgst,
        'rate': rate,
        'amount': amount,
        'gst':gst
    }
    return render(request, 'inventory/partials/ict-upload.html', context)

#------------------------------------------------------------------------       itc

@allowed_users(allowed_roles=['Admin', 'ICT View', 'ICT Create', 'ICT Update', 'ICT Delete'])
def ict(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})

    com = Company.objects.get(pk=skey)
    
    so = Invoice.objects.filter(company=com, is_ict=True)

    context = {'sos': so,}

    return render(request, 'inventory/ict.html', context)

@allowed_users(allowed_roles=['Admin', 'ICT Create', 'ICT Update', 'ICT Delete'])
def add_ict(request):

    skey    = (request.session.get('skey').get('company').get('id'))
    com     = Company.objects.get(id=skey)
    series  = com.ict_series
    so = Invoice.objects.filter(inv_no__contains=series).order_by('inv_no').last()
    if so:
        sonum = int(so.inv_no[len(series):]) + 1
        sonumber = series + (str(sonum)).zfill(5)
    else:
        sonumber = series + '00001'

    parties = Company.objects.exclude(id=com.id)

    seller                      = Party_master.objects.get(name=com.ledger_name, group__name='Sundry Creditors')
    party                       = Party_master.objects.get(name=parties[0].ledger_name, group__name='Sundry Debtors')
    
    if request.method == 'POST':

        # print(request.POST)

        product_codelist            = request.POST.getlist('product_code')
        billqtylist                 = request.POST.getlist("billqty")
        ratelist                    = request.POST.getlist("rate")
        available_qty               = request.POST.getlist("stock")

        narration                   = request.POST.get("narration")

        if request.POST.get("totaltcs"):
            totaltcs = Decimal(request.POST.get("totaltcs"))
        else:
            totaltcs = 0
        so                          = Invoice()
        pi                          = Purchase()
        so.company                  = com
        pi.company                  = parties[0]

        pi.pi_no                    = sonumber

        pi.seller_address_type      = "Default"
        pi.seller                   = seller
        pi.seller_mailingname       = seller.mailing_name
        pi.seller_address1          = seller.addressline1
        pi.seller_address2          = seller.addressline2
        pi.seller_address3          = seller.addressline3
        pi.seller_country           = str(seller.country)
        pi.seller_state             = str(seller.state)
        pi.seller_city              = str(seller.city)
        pi.seller_pincode           = seller.pin_code
        pi.seller_gstin             = seller.gstin
        pi.seller_gst_reg_type      = seller.gst_registration_type

        pi.shipto = com
        pi.shipto_address_type = com.dis_addtype
        pi.shipto_mailingname = com.dis_name
        pi.shipto_address1 = com.dis_add1
        pi.shipto_address2 = com.dis_add2
        pi.shipto_address3 = com.dis_add3
        pi.shipto_city = com.dis_city
        pi.shipto_state = com.dis_state
        pi.shipto_country = com.dis_country
        pi.shipto_pincode = com.dis_pincode
        pi.shipto_gstin = com.dis_gstin

        pi.supplier_invoice         = sonumber
        pi.supplier_date            = date.today()

        so.buyer_address_type       = "Default"
        so.shipto_address_type      = "Default"

        so.inv_no                   = sonumber

        so.buyer                    = party
        so.buyer_mailingname        = party.mailing_name
        so.buyer_address1           = party.addressline1
        so.buyer_address2           = party.addressline2
        so.buyer_address3           = party.addressline3
        so.buyer_country            = str(party.country)
        so.buyer_state              = str(party.state)
        so.buyer_city               = str(party.city)
        so.buyer_pincode            = party.pin_code
        so.buyer_gstin              = party.gstin
        so.buyer_gst_reg_type       = party.gst_registration_type

        so.shipto                   = party
        so.shipto_mailingname       = party.mailing_name
        so.shipto_address1          = party.addressline1
        so.shipto_address2          = party.addressline2
        so.shipto_address3          = party.addressline3
        so.shipto_country           = str(party.country)
        so.shipto_state             = str(party.state)
        so.shipto_city              = str(party.city)
        so.shipto_pincode           = party.pin_code
        so.shipto_gstin             = party.gstin
        so.shipto_pan_no            = party.pan_no
        so.division                 = party.devision.name
        so.channel                  = party.party_type.name

        so.mrpvalue                 = 0
        so.omrpvalue                = 0
        so.ammount                  = 0
        so.discount                 = 0
        so.other                    = 0
        so.ol_rate                  = 0
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.total                    = 0
        so.bill_qty                 = 0
        so.free_qty                 = 0
        so.round_off                = 0
        so.is_ict                   = True
        so.narration                = narration
        so.save()

        pi.ammount                  = 0
        pi.discount                 = 0
        pi.other                    = 0
        pi.ol_rate                  = 0
        pi.cgst                     = 0
        pi.igst                     = 0
        pi.sgst                     = 0
        pi.tcs                      = 0
        pi.total                    = 0
        pi.round_off                = 0
        pi.bill_qty                 = 0
        pi.free_qty                 = 0
        pi.is_ict                   = True
        pi.narration                = narration
        pi.save()

        totalbill_qty               = 0
        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        # try:
        for i,j in enumerate(product_codelist):
            product         = Product_master.objects.get(product_code=j)
            mrp             = product.mrp
            pack            = product.outer_qty
            offermrp        = mrp
            billqty         = Decimal(billqtylist[i])
            actualqty       = billqty

            freeqty         = 0
            rate            = Decimal(ratelist[i])

            discount        = 0
            ammount         = billqty * rate

            igstrate        = product.gst
            cgstrate        = product.gst/2
            sgstrate        = product.gst/2

            igst            = ammount * (igstrate / 100)
            cgst            = ammount * (cgstrate / 100)
            sgst            = ammount * (sgstrate / 100)

            totalbill_qty  += billqty
            totalammount    = totalammount + ammount
            totalcgst       = totalcgst + cgst
            totalsgst       = totalsgst + sgst
            totaligst       = totaligst + igst
            stock           = Stock_summary.objects.filter(company=so.company, product=product,godown__godown_type = 1).order_by('batch')
            InvItems.objects.create(inv=so, item=product, prate=stock[0].rate, available_qty=Decimal(available_qty[i]), pack=pack, mrp=mrp, offer_mrp=(offermrp), igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate), actual_qty=(actualqty), billed_qty=(billqty), free_qty=(freeqty), rate=(rate), discount=(discount), amount=(ammount))
            batch           = ''
            for st1 in stock:
                if actualqty >= st1.closing_balance:
                    actualqty       -= st1.closing_balance
                    st1.company     = parties[0]
                    st1.rate        = rate
                    batch           =st1.batch
                    st1.save()
                    if actualqty == 0:
                        break
                else:
                    st1.closing_balance -= actualqty
                    batch           = st1.batch
                    st1.save()
                    st2, new=Stock_summary.objects.get_or_create(company=parties[0],mrp=product.mrp, godown=st1.godown ,batch=batch,rate=st1.rate, product=product)
                    if new:
                        st2.closing_balance = actualqty
                    else:
                        st2.closing_balance += actualqty
                    st2.rate        =   rate
                    st2.save()
                    break

            PiItems.objects.create(pi=pi, item=product,mrp=product.mrp,batch=batch, product_code=product.product_code, pack=pack,recd_qty=billqty, basic_qty=billqty,igstrate=igstrate ,sgstrate=sgstrate ,cgstrate=cgstrate, rate=rate, amount=ammount,igst=igst ,sgst=sgst ,cgst=cgst)

        # except BaseException as exception:
        #     print(exception)
        #     so.delete()

        so.bill_qty                = totalbill_qty
        so.ammount                 = totalammount
        so.cgst                    = totalcgst
        so.sgst                    = totalsgst
        so.igst                    = totaligst
        so.tcs                     = totaltcs
        total                      = totalammount + so.igst + so.tcs
        so.total                   = round(total)
        so.round_off               = so.total - total
        so.save()

        pi.bill_qty                = totalbill_qty
        pi.ammount                 = so.ammount
        pi.cgst                    = so.cgst
        pi.sgst                    = so.sgst
        pi.igst                    = so.igst
        pi.tcs                     = so.tcs
        pi.total                   = so.total
        pi.round_off               = so.round_off
        pi.save()
        messages.success(request, "ICT Data Added Successfully")

        return redirect('inventory:ict')

    items = Product_master.objects.all()

    context = {'party': party, 'items': items, 'sonumber': sonumber}

    return render(request, 'inventory/add_ict.html', context)

@allowed_users(allowed_roles=['Admin', 'ICT Update', 'ICT Delete'])
def edit_ict(request, pk):

    if request.method == 'POST':
        so = Invoice.objects.get(pk=pk)
        print(request.POST)

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
            item = InvItems.objects.get(so=so, product_code=j)
            item.offer_price = mrplist[i]
            item.actual_qty = aqtylist[i]
            item.billed_qty = bqtylist[i]
            item.free_qty = fqtylist[i]
            item.discount = dislist[i]
            item.amount = amtlist[i]
            item.save()
        messages.success(request, "ICT Data Updated Successfully")
    so = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(inv=so)
    company = Company.objects.all()
    return render(request, 'inventory/edit_ict.html', {'pk': pk, 'inv': so, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'ICT View', 'ICT Create', 'ICT Update', 'ICT Delete'])
def show_ict(request, pk):

    so = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(inv=so)

    return render(request, 'inventory/edit_ict.html', {'pk': pk, 'inv': so, 'items': items,})
#------------------------------------------------------------------------       ivt

@allowed_users(allowed_roles=['Admin', 'IVT View', 'IVT Create', 'IVT Update', 'IVT Delete'])
def ivt(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(pk=skey)

    so = Rso.objects.filter(company=com, is_ivt=True)

    context = {'sos': so,}

    return render(request, 'inventory/ivt.html', context)

@allowed_users(allowed_roles=['Admin', 'IVT Create', 'IVT Update', 'IVT Delete'])
def add_ivt(request):

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
        # print(request.POST)
        party_name                  = request.POST.get("party_name")
        party_address_type          = request.POST.get("party_address_type")
        billqtylist                 = request.POST.getlist('aqty')
        product_codelist            = request.POST.getlist('product_code')
        ratelist                    = request.POST.getlist("rate")
        party                       = Party_master.objects.get(name=party_name, group__name = 'Sundry Debtors')

        so                          = Rso()
        if party_address_type:
            party_add = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            so.buyer_address_type = party_add.address_type
        else:
            party_add = party
            so.buyer_address_type = "Default"

        ol_rate = Decimal(request.POST.get("ol_rate"))
        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)
            so.other_ledger = other_ledger
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)

        narration                   = request.POST.get("narration")
        so.company                  = com
        so.rso_no                   = grnnumber
        so.buyer                    = party
        so.buyer_address1           = party_add.addressline1
        so.buyer_address2           = party_add.addressline2
        so.buyer_address3           = party_add.addressline3
        so.buyer_mailingname        = party_add.mailing_name
        so.buyer_pincode            = party_add.pin_code
        so.buyer_state              = str(party_add.state)
        so.buyer_country            = str(party_add.country)
        so.buyer_city               = str(party_add.city)
        so.division                 = str(party_add.devision.name)
        so.channel                  = str(party_add.party_type.name)
        so.buyer_gst_reg_type       = party_add.gst_registration_type
        so.buyer_gstin              = party_add.gstin

        so.ammount                  = 0
        so.bill_qty                   = 0
        so.free_qty                   = 0
        so.discount                 = 0
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.total                    = 0
        so.round_off                = 0
        so.is_ivt                   = True
        so.narration                = narration
        so.save()

        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        totalqty                    = 0
        mrpvalue                    = 0
        try:
            for i,j in enumerate(product_codelist):

                product         = Product_master.objects.get(product_code=j)
                mrp             = product.mrp
                pack            = product.outer_qty
                billqty         = Decimal(billqtylist[i])

                rate            = Decimal(ratelist[i])

                ammount         = (billqty * rate )

                igstrate        = product.gst
                cgstrate        = product.gst/2
                sgstrate        = product.gst/2
                igst            = ammount * (igstrate / 100)
                cgst            = ammount * (cgstrate / 100)
                sgst            = ammount * (sgstrate / 100)

                mrpvalue            += mrp * billqty
                totalammount    = totalammount + ammount
                totalcgst       = totalcgst + cgst
                totalsgst       = totalsgst + sgst
                totaligst       = totaligst + igst
                totalqty        = totalqty + billqty
                RsoItems.objects.create(inv=so,amount=ammount,item=product,igstrate=igstrate,mrp=mrp,
                                                cgstrate=cgstrate, sgstrate=sgstrate,discount=0,
                                                igst=igst,cgst=cgst,billed=billqty,billed_qty=billqty,free_qty=0,
                                                sgst=sgst,rate=rate)
        except BaseException as exception:
            print(exception)
            so.delete()
            return redirect('inventory:ivt')

        so.ammount      = totalammount
        so.mrpvalue      = mrpvalue
        so.bill_qty       = totalqty
        so.cgst         = totalcgst + (other * ol_rate /200)
        so.sgst         = totalsgst + (other * ol_rate /200)
        so.igst         = totaligst + (other * ol_rate /100)
        so.other        = other
        total           = totalammount + so.igst + other
        so.total        = round(total)
        so.round_off    = so.total - total
        so.save()
        messages.success(request, "IVT Data Added Successfully")

        return redirect('inventory:ivt')

    items   = Product_master.objects.all()
    parties = Party_master.objects.filter(group__name="Sundry Debtors")
    context = {'parties': parties, 'items': items, 'sonumber': grnnumber}

    return render(request, 'inventory/add_ivt.html', context)

@allowed_users(allowed_roles=['Admin', 'IVT Update', 'IVT Delete'])
def edit_ivt(request, pk):

    if request.method == 'POST':
        so = Invoice.objects.get(pk=pk)

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
            item = InvItems.objects.get(so=so, product_code=j)
            item.offer_price = mrplist[i]
            item.actual_qty = aqtylist[i]
            item.billed_qty = bqtylist[i]
            item.free_qty = fqtylist[i]
            item.discount = dislist[i]
            item.amount = amtlist[i]
            item.save()
        messages.success(request, "IVT Data Updated Successfully")
        return redirect('inventory:ivt')
    so      = Rso.objects.get(pk=pk)
    items   = RsoItems.objects.filter(inv=so)
    company = Company.objects.all()
    return render(request, 'inventory/edit_ivt.html', {'pk': pk, 'pi': so, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'IVT View', 'IVT Create', 'IVT Update', 'IVT Delete'])
def show_ivt(request, pk):

    so = Rso.objects.get(pk=pk)
    items = RsoItems.objects.filter(inv=so)
    company = Company.objects.all()
    return render(request, 'sales/show_ivt.html', {'pk': pk, 'pi': so, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'IVT Sale Create', 'IVT Sale Update', 'IVT Sale Delete'])
def add_ivt_sale(request):

    skey = (request.session.get('skey').get('company').get('id'))
    com = Company.objects.get(id=skey)
    series = com.inv_series
    so = Invoice.objects.filter(company=com, inv_no__contains=series).order_by('inv_no').last()
    if so:
        sonum = int(so.inv_no[len(series):]) + 1
        sonumber = series + (str(sonum)).zfill(5)
    else:
        sonumber = series + '00001'

    if request.method == 'POST':

        dn_no                       = request.POST.get('dn_no')
        party_name                  = request.POST.get("party_name")
        party_address_type          = request.POST.get("party_address_type")
        ratelist                    = request.POST.getlist("rate")

        so                          = Invoice()
        so.company                  = com

        party                       = Party_master.objects.get(name=party_name, group__name = 'Sundry Debtors')

        if party_address_type:
            party_add = Party_contact_details.objects.get(party=party, address_type=party_address_type )
            so.buyer_address_type = party_add.address_type
        else:
            party_add = party
            so.buyer_address_type = "Default"

        ol_rate = Decimal(request.POST.get("ol_rate"))
        other_ledger = request.POST.get("other_ledger")
        if other_ledger:
            other_ledger = LedgersType.objects.get(id=other_ledger)
            so.other_ledger = other_ledger
        if request.POST.get("other"):
            other = Decimal(request.POST.get("other"))
        else:
            other = Decimal(0)
        so.inv_no                   = sonumber

        so.buyer                    = party
        so.buyer_mailingname        = party.mailing_name
        so.buyer_address1           = party.addressline1
        so.buyer_address2           = party.addressline2
        so.buyer_address3           = party.addressline3
        so.buyer_country            = str(party.country)
        so.buyer_state              = str(party.state)
        so.buyer_city               = str(party.city)
        so.division                 = str(party.devision.name)
        so.channel                  = str(party.party_type.name)
        so.buyer_pincode            = party.pin_code
        so.buyer_gstin              = party.gstin
        so.buyer_gst_reg_type       = party.gst_registration_type

        so.shipto                   = party
        so.shipto_mailingname       = party.mailing_name
        so.shipto_address1          = party.addressline1
        so.shipto_address2          = party.addressline2
        so.shipto_address3          = party.addressline3
        so.shipto_country           = str(party.country)
        so.shipto_state             = str(party.state)
        so.shipto_city              = str(party.city)
        so.shipto_pincode           = party.pin_code
        so.shipto_gstin             = party.gstin
        so.shipto_pan_no            = party.pan_no

        so.bill_qty                 = 0
        so.free_qty                 = 0
        so.mrpvalue                 = 0
        so.omrpvalue                = 0
        so.ammount                  = 0
        so.discount                 = 0
        so.other                    = 0
        so.ol_rate                  = 0
        so.cgst                     = 0
        so.igst                     = 0
        so.sgst                     = 0
        so.tcs                      = 0
        so.total                    = 0
        so.round_off                = 0
        so.is_ivt                   = True
        so.save()
        items                       = RsoItems.objects.filter(inv__company=com,inv=dn_no)

        totalammount                = 0
        totalcgst                   = 0
        totalsgst                   = 0
        totaligst                   = 0
        mrpvalue                = 0
        omrpvalue               = 0
        try:
            for j,i in enumerate(items):

                freeqty         = 0
                rate            = Decimal(ratelist[j])

                discount        = 0
                ammount         = i.billed_qty * rate

                igstrate        = i.item.gst
                cgstrate        = i.item.gst/2
                sgstrate        = i.item.gst/2

                igst            = ammount * (igstrate / 100)
                cgst            = ammount * (cgstrate / 100)
                sgst            = ammount * (sgstrate / 100)

                totalammount    = totalammount + ammount
                totalcgst       = totalcgst + cgst
                totalsgst       = totalsgst + sgst
                totaligst       = totaligst + igst
                mrpvalue        += i.mrp * i.billed_qty

                InvItems.objects.create(inv=so, item=i.item, prate=i.rate, available_qty=i.billed_qty, pack=i.item.outer_qty, mrp=i.item.mrp, offer_mrp=i.item.mrp, igst=(igst), cgst=(cgst), sgst=(sgst), igstrate=(igstrate), cgstrate=(cgstrate), sgstrate=(sgstrate),nb_qty=i.billed_qty, actual_qty=(i.billed_qty), billed_qty=(i.billed_qty), free_qty=(0),nf_qty=(0),new_rate=rate ,rate=(rate), discount=(discount), amount=(ammount))

        except BaseException as exception:
            print(exception)
            so.delete()

        so.ammount      = totalammount
        so.mrpvalue                = mrpvalue

        so.cgst         = totalcgst + (other * ol_rate /200)
        so.sgst         = totalsgst + (other * ol_rate /200)
        so.igst         = totaligst + (other * ol_rate /100)
        so.other        = other
        total           = totalammount + so.igst + other
        if party.istcsapplicable:
            so.tcs = total * Decimal(0.001)
            total = total + so.tcs

        so.total        = round(total)
        so.round_off    = so.total - total
        so.save()

        messages.success(request, "Product IVT Sale Added Successfully")
        return redirect('inventory:ivt')

    rso = Rso.objects.filter(company=com,is_ivt = True)
    parties = Party_master.objects.all()

    context = {'sos': rso, 'sonumber': sonumber, 'parties':parties}

    return render(request, 'inventory/add_ivt_sale.html', context)

@allowed_users(allowed_roles=['Admin', 'IVT Sale Update', 'IVT Sale Delete'])
def edit_ivt_sale(request, pk):

    if request.method == 'POST':
        so = Invoice.objects.get(pk=pk)
        print(request.POST)

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
            item = InvItems.objects.get(so=so, product_code=j)
            item.offer_mrp = mrplist[i]
            item.actual_qty = aqtylist[i]
            item.billed_qty = bqtylist[i]
            item.free_qty = fqtylist[i]
            item.discount = dislist[i]
            item.amount = amtlist[i]
            item.save()
        messages.success(request, "Product IVT Sale Updated Successfully")
        return redirect('inventory:ivt')
    so = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(so=so)
    company = Company.objects.all()
    return render(request, 'sales/edit_ivt_sale.html', {'pk': pk, 'so': so, 'items': items, 'company': company})

@allowed_users(allowed_roles=['Admin', 'IVT Sale View', 'IVT Sale Create', 'IVT Sale Update', 'IVT Sale Delete'])
def show_ivt_sale(request, pk):

    so = Invoice.objects.get(pk=pk)
    items = InvItems.objects.filter(so=so)
    company = Company.objects.all()
    return render(request, 'sales/show_ivt_sale.html', {'pk': pk, 'so': so, 'items': items, 'company': company})

#------------------------------------------------------------------------       partials

def bom(request):

    no = int(request.GET['no'])+1

    context = {'no': no}

    return render(request, 'inventory/partials/bom.html', context)


def mrp(request):

    states = State.objects.all()

    context = {'states': states}

    return render(request, 'inventory/partials/mrp.html', context)

def ict_item(request):

    no = int(request.GET['no'])+1

    context = {'no': no, 'items': Product_master.objects.all()}

    return render(request, 'inventory/partials/ict-item.html', context)

def std(request):

    context = {'form': ''}

    return render(request, 'inventory/partials/std.html', context)


def bom_item(request):

    no = int(request.GET['no'])+1

    context = {'no': no, 'items':Product_master.objects.all()}

    return render(request, 'inventory/partials/bom-item.html', context)

@method_decorator(allowed_users(allowed_roles=['Admin', 'Currency Create', 'Currency Update', 'Currency Delete', 'Currency View']), name='dispatch')
class currencyView(ListView):
    model = Currency
    template_name = 'inventory/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'currency/create'
        data['edit'] = 'currency/edit/'
        data['tag'] = 'Currency'
        data['title2'] = 'currency/show/'
        return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Currency.objects.values('name', 'id').order_by("-created")
        if query is not None:
            qs=qs.filter(symbol__icontains=query )
        return qs
    
@method_decorator(allowed_users(allowed_roles=['Admin', 'Currency Create', 'Currency Update', 'Currency Delete']), name='dispatch')
class add_currency(CreateView):
    model = Currency
    template_name = 'inventory/common.html'
    success_url = "/ivt/currency"
    form_class = CurrencyForm
    
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Currency'
        data['url'] = 'currency'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Currency Update', 'Currency Delete']), name='dispatch')
class edit_currency(UpdateView):
    model = Currency
    template_name = 'inventory/common.html'
    success_url = "/ivt/currency"
    form_class = CurrencyForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Currency'
        data['url'] = 'currency'
        data['action'] = 'Edit'
        data['div'] = 4
        return data

@allowed_users(allowed_roles=['Admin', 'Currency Update', 'Currency Delete', 'Currency View'])
def show_currency(request, pk):
    curre = Currency.objects.get(id=pk)
    return render(request,'inventory/show_currency.html', {'curre': curre})
