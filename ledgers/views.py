from django.shortcuts import render, redirect
from django.views.generic import ListView
from django.http import HttpResponse
import requests
from .models import Country
from django.utils import six
from company.models import Company
from django.db.models import Q
from django.contrib import messages
from django.db import IntegrityError
from django.utils.decorators import method_decorator
from core.decorators import auth_users, allowed_users, is_company
from django.views.generic.edit import CreateView, UpdateView
from django.db.models import F
from ledgers.models import Asm, City, Country, Division, Group, LedgersType, Party_contact_details, Party_master, PartyType, Price_level, Region, Rsm, Se, State, Zone, Zsm
from ledgers.xmlcreator import cmxml
from .forms import CountryForm, ZoneForm, RegionForm, StateForm, CityForm, ZsmForm, DivisionForm, PartyTypeForm, RsmForm, AsmForm, SeForm, CustomerForm
from django.core.exceptions import ObjectDoesNotExist
# Create your views here.
def ledgers(request):
    customer = Party_master.objects.filter(group__name="Sundry Debtors").count()
    vendor = Party_master.objects.filter(group__name="Sundry Creditors").count()
    asm = Asm.objects.count()
    zsm = Zsm.objects.count()
    rsm = Rsm.objects.count()
    se  = Se.objects.count()
    zone = Zone.objects.count()
    region = Region.objects.count()
    state = State.objects.count()
    country = Country.objects.count()
    city = City.objects.count()
    division = Division.objects.count()
    channel = PartyType.objects.count()
    pricelevel = Price_level.objects.count()

    context = {
            'asm':asm, 'zsm':zsm, 'rsm':rsm, 'se':se, 'customer':customer, 'vendor':vendor, 'zone':zone, 'region':region, 'state':state, 'country':country, 'city':city, 'division':division, 'channel':channel, 'pricelevel':pricelevel,
     }

    return render(request, 'ledgers/ledgers.html',context)


@method_decorator(allowed_users(allowed_roles=['Admin', 'Customer View', 'Customer Create', 'Customer Update', 'Customer Delete']), name='dispatch')
class Cm(ListView):

    model = Party_master
    template_name = 'ledgers/cm.html'  # Default: <app_label>/<model_name>_list.html
    context_object_name = 'ledgers'  # Default: object_list
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Party_master.objects.all().filter(group__name="Sundry Debtors").order_by("name")
        if query is not None:
            qs=qs.filter( Q(name__icontains=query) | Q(vendor_code__icontains=query) )
        return qs

# @method_decorator(allowed_users(allowed_roles=['Admin', 'Customer Create', 'Customer Update', 'Customer Delete']), name='dispatch')
# class addcm(CreateView):
#     model = Party_master
#     template_name = 'ledgers/add_customer.html'
#     success_url = "/led"
#     form_class = CustomerForm
 
#     def get_initial(self):
#         initial = super().get_initial()
#         qs = Party_master.objects.filter(group__name="Sundry Debtors").count()
#         if qs:
#             code = 200002 + int(qs)
#         else:
#             code = 200001
#         initial['vendor_code'] = code
#         return initial
    
@allowed_users(allowed_roles=['Admin', 'Customer Create', 'Customer Update', 'Customer Delete'])
def addcm(request):
    qs = Party_master.objects.filter(group__name="Sundry Debtors").count()
    if qs:
        code = 200002 + int(qs)
    else:
        code = 200001

    pricelevels = Price_level.objects.all()
    countries = Country.objects.all()
    zones = Zone.objects.all()
    party_types = PartyType.objects.all()
    divisions = Division.objects.all()
    context = {'code':code,'divisions':divisions,'countries': countries, 'zones': zones, 'party_types': party_types, 'pricelevels':pricelevels}

    if request.method == "POST":
        try:
            customer_name = request.POST.get("customer_name")
            group = Group.objects.get(name='Sundry Debtors')

            if request.POST.get("maintain_bbb"):
                maintain_bbb = True
            else:
                maintain_bbb = False

            dafault_credit_period = request.POST.get("dafault_credit_period")

            if request.POST.get("check_credit_days"):
                check_credit_days = True
            else:
                check_credit_days = False

            pricelevel = Price_level(id=request.POST.get("pricelevel"))
            payment_terms = request.POST.get("payment_terms")
            credit_limit = request.POST.get("credit_limit")

            if request.POST.get("override_credit_limit"):
                override_credit_limit = True
            else:
                override_credit_limit = False

            if request.POST.get("zone"):
                zone = Zone.objects.get(id=request.POST.get("zone"))
            else:
                zone = None

            if request.POST.get("region"):
                region = Region.objects.get(id=request.POST.get("region"))
            else:
                region = None

            if request.POST.get("zsm_name"):
                zsm_name = Zsm.objects.get(id=request.POST.get("zsm_name"))
            else:
                zsm_name = None

            if request.POST.get("rsm_name"):
                rsm_name = Rsm.objects.get(id=request.POST.get("rsm_name"))
            else:
                rsm_name = None

            if request.POST.get("asm_name"):
                asm_name = Asm.objects.get(id=request.POST.get("asm_name"))
            else:
                asm_name = None

            if request.POST.get("se_name"):
                se_name = Se.objects.get(id=request.POST.get("se_name"))
            else:
                se_name = None

            if request.POST.get("party_type"):
                party_type = PartyType.objects.get(id=request.POST.get("party_type"))
            else:
                party_type = None

            mailing_name = customer_name.upper()

            vendor_code = code
            addressline1 = request.POST.get("addressline1")
            addressline2 = request.POST.get("addressline2")
            addressline3 = request.POST.get("addressline3")

            if request.POST.get("country"):
                country = Country.objects.get(id=request.POST.get("country"))
            else:
                return HttpResponse("please enter Country")

            if request.POST.get("state"):
                state = State.objects.get(id=request.POST.get("state"))
            else:
                return HttpResponse("please enter State")

            if request.POST.get("city"):
                city = City.objects.get(id=request.POST.get("city"))
            else:
                return HttpResponse("please enter City")

            if request.POST.get("pin_code"):
                pin_code = (request.POST.get("pin_code"))
            else:
                return HttpResponse("please enter PinCode")

            if request.POST.get("mobile_no"):
                mobile_no = (request.POST.get("mobile_no"))
            else:
                return HttpResponse("please enter Mobile No")

            if request.POST.get("provide_contact_details"):
                contact_details = True
            else:
                contact_details = False

            contact_person = request.POST.get("contact_person")
            if request.POST.get("phone_no"):
                phone_no = (request.POST.get("phone_no"))
            else:
                phone_no = None

            if request.POST.get("fax_no"):
                fax_no = (request.POST.get("fax_no"))
            else:
                fax_no = None

            email_id = request.POST.get("email_id")
            cc_email = request.POST.get("cc_email")
            website = request.POST.get("website")

            if request.POST.get("multiple_address_list"):
                multiple_address_list = True
            else:
                multiple_address_list = False

            registration_type = request.POST.get("registration_type")

            gstin = request.POST.get("gstin")
            pan_no = request.POST.get("pan_no")
            if request.POST.get("tcs"):
                tcs = True
            else:
                tcs = False

            transation_type = request.POST.get("transation_type")
            bank = request.POST.get("bank")
            ifsc_code = request.POST.get("ifsc_code")
            account_no = request.POST.get("account_no")
            account_name = request.POST.get("account_name")
            division = Division.objects.get(id=request.POST.get("divisions"))

            cm = Party_master.objects.get_or_create(name=customer_name, group=group, devision=division,price_level=pricelevel,istcsapplicable=tcs,
                                                    maintain_bill_by_bill=maintain_bbb, dafault_credit_period=dafault_credit_period,
                                                    check_credit_days=check_credit_days, payment_terms=payment_terms, credit_limit=credit_limit,
                                                    override_credit_limit=override_credit_limit, zone=zone, region=region, zsm=zsm_name, contact_details=contact_details,
                                                    asm=asm_name, se=se_name, party_type=party_type, vendor_code=vendor_code, rsm=rsm_name,
                                                    mailing_name=mailing_name, addressline1=addressline1, addressline2=addressline2,addressline3=addressline3,
                                                    country=country, state=state, pin_code=pin_code, city=city, mobile_no=mobile_no,
                                                    contact_person=contact_person, phone_no=phone_no, fax_no=fax_no, email_id=email_id,
                                                    cc_email=cc_email, website=website, multiple_address_list=multiple_address_list, pan_no=pan_no, gstin=gstin,
                                                    gst_registration_type=registration_type, transation_type=transation_type,
                                                    bank=bank, ifsc_code=ifsc_code, account_no=account_no, account_name=account_name)

            address_type1 = request.POST.getlist("address_type1")
            mailing_name1 = request.POST.getlist("mailing_name1")
            pcd_addressline1 = request.POST.getlist("pcd_addressline11")
            pcd_addressline2 = request.POST.getlist("pcd_addressline21")
            pcd_addressline3 = request.POST.getlist("pcd_addressline31")
            pcd_country = request.POST.getlist("pcd_country")
            pcd_state = request.POST.getlist("pcd_state")
            pcd_city = request.POST.getlist("pcd_city")
            pcd_pincode = request.POST.getlist("pcd_pincode1")
            pcd_contact_person = request.POST.getlist("pcd_contact_person1")
            pcd_phone_no = request.POST.getlist("pcd_phone_no1")
            pcd_mobile_no = request.POST.getlist("pcd_mobile_no1")
            pcd_fax_no = request.POST.getlist("pcd_fax_no1")
            pcd_email_id = request.POST.getlist("pcd_email_id1")
            pcd_pan_no = request.POST.getlist("pcd_pan_no1")
            pcd_gst_registration_type = request.POST.getlist(
                "pcd_gst_registration_type1")
            pcd_gstin = request.POST.getlist("pcd_gstin1")
            check_addresstype = request.POST.get("address_type1")
            if check_addresstype and len(check_addresstype):
                for i, j in enumerate(address_type1):
                    if pcd_state[i]:
                        state = State.objects.get(id=pcd_state[i])
                    else:
                        state = ''
                    if pcd_city[i]:
                        city = City.objects.get(id=pcd_city[i])
                    else:
                        city = ''
                    if pcd_country[i]:
                        country = Country.objects.get(id=pcd_country[i])
                    else:
                        country = ''
                    pincode = pcd_pincode[i] if len(pcd_pincode) else ''
                    phone_no = pcd_phone_no[i] if len(pcd_phone_no) else ''
                    contact_person = pcd_contact_person[i] if len(pcd_contact_person) else ''
                    mobile_no = pcd_mobile_no[i] if len(pcd_mobile_no) else ''
                    fax_no = pcd_fax_no[i] if len(pcd_fax_no) else ''
                    cc_email = pcd_email_id[i] if len(pcd_email_id) else ''
                    pan_no = pcd_pan_no[i] if len(pcd_pan_no) else ''
                    gstin = pcd_gstin[i] if len(pcd_gstin) else ''

                    Party_contact_details.objects.update_or_create(party=cm[0], address_type=j, defaults={'mailing_name':mailing_name1[i],
                                                                'addressline1':pcd_addressline1[i], 'addressline2':pcd_addressline2[i],'addressline3':pcd_addressline3[i],
                                                               'country':country, 'state':state, 'city':city,'email_id':cc_email,
                                                               'pin_code':pincode, 'contact_person':contact_person,
                                                               'phone_no':phone_no, 'mobile_no':mobile_no, 'fax_no':fax_no,
                                                               'pan_no':pan_no, 'gst_registration_type':pcd_gst_registration_type[i],
                                                               'gstin':gstin})
            addresses=Party_contact_details.objects.filter(party=cm[0])
            xml = cmxml(cm[0], request,vendor_code, group, addresses)
            com = Company.objects.all()
            for i  in com:
                mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
                mainxml = mainxml.replace('Company_name',i.tally_name)
                payload = mainxml.replace('xml_creator', xml)
                req = requests.post(url=i.ipaddress, data=payload)
                messages.info(request, "{}".format(req))
                messages.success(request, "Customer: {} Created Successfully".format(customer_name))
            return redirect('ledgers:cm')
        except IntegrityError as e:
            if 'ledgers_party_master_name_key' in e.args[0]:
                messages.error(request, "Customer: {} already exist".format(customer_name))
            return render(request, 'ledgers/add_customer.html', context)

    return render(request, 'ledgers/add_customer.html', context)

@allowed_users(allowed_roles=['Admin', 'Customer Update', 'Customer Delete'])
def editcm(request, pk):
    cm = Party_master.objects.get(pk=pk)

    if request.method == "POST":

        customer_name = request.POST.get("customer_name")
        group = Group.objects.get(name='Sundry Debtors')
        division = Division.objects.get(id=request.POST.get("divisions"))

        if request.POST.get("maintain_bbb"):
            maintain_bbb = True
        else:
            maintain_bbb = False

        dafault_credit_period = request.POST.get("dafault_credit_period")

        if request.POST.get("check_credit_days"):
            check_credit_days = True
        else:
            check_credit_days = False

        payment_terms = request.POST.get("payment_terms")
        credit_limit = request.POST.get("credit_limit")

        if request.POST.get("override_credit_limit"):
            override_credit_limit = True
        else:
            override_credit_limit = False

        if request.POST.get("zone"):
            zone = Zone.objects.get(id=request.POST.get("zone"))
        else:
            zone = None

        if request.POST.get("region"):
            region = Region.objects.get(id=request.POST.get("region"))
        else:
            region = None

        if request.POST.get("zsm"):
            zsm = Zsm.objects.get(id=request.POST.get("zsm"))
        else:
            zsm = None

        if request.POST.get("rsm"):
            rsm = Rsm.objects.get(id=request.POST.get("rsm"))
        else:
            rsm = None

        if request.POST.get("asm"):
            asm = Asm.objects.get(id=request.POST.get("asm"))
        else:
            asm = None

        if request.POST.get("se"):
            se = Se.objects.get(id=request.POST.get("se"))
        else:
            se = None

        if request.POST.get("party_type"):
            party_type = PartyType.objects.get(id=request.POST.get("party_type"))
        else:
            party_type = None

        if request.POST.get("mailing_name"):
            mailing_name = request.POST.get("mailing_name")
        else:
            mailing_name = customer_name

        addressline1 = request.POST.get("addressline1")
        addressline2 = request.POST.get("addressline2")
        addressline3 = request.POST.get("addressline3")

        if request.POST.get("country"):
            country = Country.objects.get(id=request.POST.get("country"))
        else:
            return HttpResponse("please enter Country")

        if request.POST.get("state"):
            state = State.objects.get(id=request.POST.get("state"))
        else:
            return HttpResponse("please enter State")

        if request.POST.get("city"):
            city = City.objects.get(id=request.POST.get("city"))
        else:
            return HttpResponse("please enter City")

        if request.POST.get("pin_code"):
            pin_code = (request.POST.get("pin_code"))
        else:
            return HttpResponse("please enter PinCode")

        if request.POST.get("mobile_no"):
            mobile_no = (request.POST.get("mobile_no"))
        else:
            return HttpResponse("please enter Mobile No")

        if request.POST.get("provide_contact_details"):
            contact_details = True
        else:
            contact_details = False

        contact_person = request.POST.get("contact_person")
        if request.POST.get("phone_no"):
            phone_no = (request.POST.get("phone_no"))
        else:
            phone_no = None

        if request.POST.get("fax_no"):
            fax_no = (request.POST.get("fax_no"))
        else:
            fax_no = None

        email_id = request.POST.get("email_id")
        cc_email = request.POST.get("cc_email")
        website = request.POST.get("website")

        if request.POST.get("multiple_address_list"):
            multiple_address_list = True
        else:
            multiple_address_list = False

        registration_type = request.POST.get("registration_type")
        pricelevel = Price_level(id=request.POST.get("pricelevel"))

        gstin = request.POST.get("gstin")
        pan_no = request.POST.get("pan_no")

        transation_type = request.POST.get("transation_type")
        bank = request.POST.get("bank")
        ifsc_code = request.POST.get("ifsc_code")
        account_no = request.POST.get("account_no")
        account_name = request.POST.get("account_name")
        if request.POST.get("tcs"):
            tcs = True
        else:
            tcs = False
        Party_master.objects.filter(id=pk).update(name=customer_name, group=group,istcsapplicable=tcs, devision = division,
                                                maintain_bill_by_bill=maintain_bbb, dafault_credit_period=dafault_credit_period,
                                                check_credit_days=check_credit_days, payment_terms=payment_terms, credit_limit=credit_limit,
                                                override_credit_limit=override_credit_limit, zone=zone, region=region, zsm=zsm,rsm=rsm, contact_details=contact_details,
                                                asm=asm, se=se, party_type=party_type, price_level=pricelevel,
                                                mailing_name=mailing_name, addressline1=addressline1, addressline2=addressline2,addressline3=addressline3,
                                                country=country, state=state, pin_code=pin_code, city=city, mobile_no=mobile_no,
                                                contact_person=contact_person, phone_no=phone_no, fax_no=fax_no, email_id=email_id,
                                                cc_email=cc_email, website=website, multiple_address_list=multiple_address_list, pan_no=pan_no, gstin=gstin,
                                                gst_registration_type=registration_type, transation_type=transation_type,
                                                bank=bank, ifsc_code=ifsc_code, account_no=account_no, account_name=account_name)

        address_type1 = request.POST.getlist("address_type1")
        mailing_name1 = request.POST.getlist("mailing_name1")
        pcd_addressline1 = request.POST.getlist("pcd_addressline11")
        pcd_addressline2 = request.POST.getlist("pcd_addressline21")
        pcd_addressline3 = request.POST.getlist("pcd_addressline31")
        pcd_country = request.POST.getlist("pcd_country")
        pcd_state = request.POST.getlist("pcd_state")
        pcd_city = request.POST.getlist("pcd_city")
        pcd_pincode = request.POST.getlist("pcd_pincode")
        pcd_contact_person = request.POST.getlist("pcd_contact_person1")
        pcd_phone_no = request.POST.getlist("pcd_phone_no")
        pcd_mobile_no = request.POST.getlist("pcd_mobile_no")
        pcd_fax_no = request.POST.getlist("pcd_fax_no")
        pcd_cc_email = request.POST.getlist("pcd_email_id")
        pcd_pan_no = request.POST.getlist("pcd_pan_no")
        pcd_gst_registration_type = request.POST.getlist("pcd_gst_registration_type1")
        pcd_gstin = request.POST.getlist("pcd_gstin")

        Party_contact_details.objects.filter(party=cm).delete()
        check_addresstype = request.POST.get("address_type1")
        if check_addresstype and len(check_addresstype):
            for i, j in enumerate(address_type1):
                if len(j) > 0:
                    if pcd_state[i]:
                        state = State.objects.get(id=pcd_state[i])
                    else:
                        state = None
                    if pcd_city[i]:
                        city = City.objects.get(id=pcd_city[i])
                    else:
                        city = None
                    if pcd_country[i]:
                        country = Country.objects.get(id=pcd_country[i])
                    else:
                        country = None
                    pincode = pcd_pincode[i] if len(pcd_pincode) else ''
                    phone_no = pcd_phone_no[i] if len(pcd_phone_no) else ''
                    mobile_no = pcd_mobile_no[i] if len(pcd_mobile_no) else ''
                    fax_no = pcd_fax_no[i] if len(pcd_fax_no) else ''
                    cc_email = pcd_cc_email[i] if len(pcd_cc_email) else ''
                    pan_no = pcd_pan_no[i] if len(pcd_pan_no) else ''
                    gstin = pcd_gstin[i] if len(pcd_gstin) else ''
                    contact_person = pcd_contact_person[i] if len(pcd_contact_person) else ''
                    Party_contact_details.objects.get_or_create(party=cm, address_type=j, mailing_name=mailing_name1[i],
                                                            addressline1=pcd_addressline1[i],addressline2=pcd_addressline2[i],addressline3=pcd_addressline3[i],
                                                            country=country,state=state,city=city,email_id=cc_email,
                                                            pin_code=pincode,contact_person=contact_person,
                                                            phone_no=phone_no,mobile_no=mobile_no,fax_no=fax_no,
                                                            pan_no=pan_no,gst_registration_type=pcd_gst_registration_type[i],
                                                            gstin=gstin)

        cm = Party_master.objects.get(id=pk)
        addresses=Party_contact_details.objects.filter(party=cm)
        xml = cmxml(cm, request, cm.vendor_code, group, addresses)
        com = Company.objects.all()
        for i  in com:
            mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
            mainxml = mainxml.replace('Company_name',i.tally_name)
            payload = mainxml.replace('xml_creator', xml)
            req = requests.post(url=i.ipaddress, data=payload)
            messages.info(request, "{}".format(req))
        messages.success(request, "Customer: {} Updated Successfully".format(customer_name))
        return redirect('ledgers:cm')

    countries = Country.objects.all()
    zones = Zone.objects.all()
    groups = Group.objects.all()
    party_types = PartyType.objects.all()
    divisions = Division.objects.all()
    pricelevels = Price_level.objects.all()
    addresses=Party_contact_details.objects.filter(party=cm).order_by('address_type')
    context = {'cm':cm,'countries': countries, 'zones': zones, 'divisions':divisions,'addresses':addresses,
               'groups': groups, 'party_types': party_types, 'pricelevels':pricelevels}

    return render(request, 'ledgers/edit_customer.html', context)

@allowed_users(allowed_roles=['Admin', 'Customer View', 'Customer Create', 'Customer Update', 'Customer Delete'])
def showcm(request, pk):

    cm = Party_master.objects.get(pk=pk)
    addresses=Party_contact_details.objects.filter(party=cm)
    divisions = Division.objects.all()

    return render(request,"ledgers/show_customer.html",{'cm' : cm,'addresses':addresses, 'divisions':divisions})

@allowed_users(allowed_roles=['Admin', 'Customer Delete'])
def deletecm(request, pk):

    cm = Party_master.objects.get(pk=pk)
    cm.status = False
    cm.save()

    return HttpResponse("Party Deactivated")


@method_decorator(allowed_users(allowed_roles=['Admin', 'Vendor View', 'Vendor Create', 'Vendor Update', 'Vendor Delete']), name='dispatch')
class Vm(ListView):

    model = Party_master
    template_name = 'ledgers/vm.html'  # Default: <app_label>/<model_name>_list.html
    context_object_name = 'ledgers'  # Default: object_list
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Party_master.objects.all().filter(group__name="Sundry Creditors").order_by("name")
        if query is not None:
            qs=qs.filter( Q(name__icontains=query) | Q(vendor_code__icontains=query) )
        return qs

@allowed_users(allowed_roles=['Admin', 'Vendor Create', 'Vendor Update', 'Vendor Delete'])
def addvm(request):

    qs = Party_master.objects.filter(group__name="Sundry Creditors").count()
    if qs:
        code = 400001 + int(qs)
    else:
        code = 400001

    if request.method == "POST":
        customer_name = request.POST.get("customer_name")
        group = Group.objects.get(name='Sundry Creditors')

        maintain_bbb = True

        dafault_credit_period = request.POST.get("dafault_credit_period")

        check_credit_days = True

        if request.POST.get("override_credit_limit"):
            override_credit_limit = True
        else:
            override_credit_limit = False

        if request.POST.get("zone"):
            zone = Zone.objects.get(id=request.POST.get("zone"))
        else:
            zone = None

        if request.POST.get("region"):
            region = Region.objects.get(id=request.POST.get("region"))
        else:
            region = None

        if request.POST.get("zsm_name"):
            zsm_name = Zsm.objects.get(id=request.POST.get("zsm_name"))
        else:
            zsm_name = None

        if request.POST.get("asm_name"):
            asm_name = Asm.objects.get(id=request.POST.get("asm_name"))
        else:
            asm_name = None

        if request.POST.get("se_name"):
            se_name = Se.objects.get(id=request.POST.get("se_name"))
        else:
            se_name = None

        party_type = PartyType.objects.get(name="IB")

        mailing_name = customer_name

        addressline1 = request.POST.get("addressline1")
        addressline2 = request.POST.get("addressline2")
        addressline3 = request.POST.get("addressline3")

        if request.POST.get("country"):
            country = Country.objects.get(id=request.POST.get("country"))
        else:
            return HttpResponse("please enter Country")

        if request.POST.get("state"):
            state = State.objects.get(id=request.POST.get("state"))
        else:
            return HttpResponse("please enter State")

        if request.POST.get("city"):
            city = City.objects.get(id=request.POST.get("city"))
        else:
            return HttpResponse("please enter City")

        if request.POST.get("pin_code"):
            pin_code = request.POST.get("pin_code")
        else:
            return HttpResponse("please enter PinCode")

        if request.POST.get("mobile_no"):
            mobile_no = request.POST.get("mobile_no")
        else:
            return HttpResponse("please enter Mobile No")

        if request.POST.get("provide_contact_details"):
            contact_details = True
        else:
            contact_details = False

        contact_person = request.POST.get("contact_person")
        if request.POST.get("phone_no"):
            phone_no = request.POST.get("phone_no")
        else:
            phone_no = None

        if request.POST.get("fax_no"):
            fax_no = request.POST.get("fax_no")
        else:
            fax_no = None

        email_id = request.POST.get("email_id")
        cc_email = request.POST.get("cc_email")
        website = request.POST.get("website")

        if request.POST.get("multiple_address_list"):
            multiple_address_list = True
        else:
            multiple_address_list = False

        registration_type = request.POST.get("registration_type")

        gstin = request.POST.get("gstin")
        pan_no = request.POST.get("pan_no")

        pricelevel = Price_level.objects.get(name='Manual')

        transation_type = request.POST.get("transation_type")
        bank = request.POST.get("bank")
        ifsc_code = request.POST.get("ifsc_code")
        account_no = request.POST.get("account_no")
        account_name = request.POST.get("account_name")
        division = Division.objects.get(id=request.POST.get("divisions"))

        cm = Party_master.objects.get_or_create(name=customer_name, group=group, devision=division,price_level=pricelevel,
                                                maintain_bill_by_bill=maintain_bbb, dafault_credit_period=dafault_credit_period,
                                                check_credit_days=check_credit_days,
                                                override_credit_limit=override_credit_limit, zone=zone, region=region, zsm=zsm_name, contact_details=contact_details,
                                                asm=asm_name, se=se_name, party_type=party_type, vendor_code=code,
                                                mailing_name=mailing_name, addressline1=addressline1, addressline2=addressline2,addressline3=addressline3,
                                                country=country, state=state, pin_code=pin_code, city=city, mobile_no=mobile_no,
                                                contact_person=contact_person, phone_no=phone_no, fax_no=fax_no, email_id=email_id,
                                                cc_email=cc_email, website=website, multiple_address_list=multiple_address_list, pan_no=pan_no, gstin=gstin,
                                                gst_registration_type=registration_type, transation_type=transation_type,
                                                bank=bank, ifsc_code=ifsc_code, account_no=account_no, account_name=account_name)

        address_type1 = request.POST.getlist("address_type1")
        mailing_name1 = request.POST.getlist("mailing_name1")
        pcd_addressline1 = request.POST.getlist("pcd_addressline11")
        pcd_addressline2 = request.POST.getlist("pcd_addressline21")
        pcd_addressline3 = request.POST.getlist("pcd_addressline31")
        pcd_country = request.POST.getlist("pcd_country")
        pcd_state = request.POST.getlist("pcd_state")
        pcd_city = request.POST.getlist("pcd_city")
        pcd_pincode = request.POST.getlist("pcd_pincode1")
        pcd_contact_person = request.POST.getlist("pcd_contact_person1")
        pcd_phone_no = request.POST.getlist("pcd_phone_no1")
        pcd_mobile_no = request.POST.getlist("pcd_mobile_no1")
        pcd_fax_no = request.POST.getlist("pcd_fax_no1")
        pcd_cc_email = request.POST.getlist("pcd_email_id1")
        pcd_pan_no = request.POST.getlist("pcd_pan_no1")
        pcd_gst_registration_type = request.POST.getlist("pcd_gst_registration_type1")
        pcd_gstin = request.POST.getlist("pcd_gstin1")

        check_addresstype = request.POST.get("address_type1")
        if check_addresstype and len(check_addresstype):
            for i, j in enumerate(address_type1):
                if pcd_state[i]:
                    state = State.objects.get(id=pcd_state[i])
                else:
                    state = ''
                if pcd_city[i]:
                    city = City.objects.get(id=pcd_city[i])
                else:
                    city = ''
                if pcd_country[i]:
                    country = Country.objects.get(id=pcd_country[i])
                else:
                    country = ''
                pincode = pcd_pincode[i] if len(pcd_pincode) else ''
                phone_no = pcd_phone_no[i] if len(pcd_phone_no) else ''
                mobile_no = pcd_mobile_no[i] if len(pcd_mobile_no) else ''
                fax_no = pcd_fax_no[i] if len(pcd_fax_no) else ''
                cc_email = pcd_cc_email[i] if len(pcd_cc_email) else ''
                pan_no = pcd_pan_no[i] if len(pcd_pan_no) else ''
                gstin = pcd_gstin[i] if len(pcd_gstin) else ''

                Party_contact_details.objects.update_or_create(party=cm[0], address_type=j, mailing_name=mailing_name1[i],
                                                           addressline1=pcd_addressline1[i], addressline2=pcd_addressline2[i],
                                                           addressline3=pcd_addressline3[i],
                                                           country=country, state=state, city=city,
                                                           pin_code=pincode, contact_person=pcd_contact_person[i],
                                                           phone_no=phone_no, mobile_no=mobile_no, fax_no=fax_no,
                                                           email_id=cc_email, pan_no=pan_no, gst_registration_type=pcd_gst_registration_type[i],
                                                           gstin=gstin)
        addresses=Party_contact_details.objects.filter(party=cm[0])
        xml = cmxml(cm[0], request, code, group, addresses)
        com = Company.objects.all()
        for i  in com:
            mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
            mainxml = mainxml.replace('Company_name',i.tally_name)
            payload = mainxml.replace('xml_creator', xml)
            req = requests.post(url=i.ipaddress, data=payload)
        messages.success(request, "Vendor: {} Created Successfully".format(customer_name))
        return redirect('ledgers:vm')

    countries = Country.objects.all()
    zones = Zone.objects.all()
    party_types = PartyType.objects.all()
    divisions = Division.objects.all()
    context = {'code':code,'divisions':divisions,'countries': countries, 'zones': zones, 'party_types': party_types}
    return render(request, 'ledgers/add_vendor.html', context)

@allowed_users(allowed_roles=['Admin', 'Vendor Update', 'Vendor Delete'])
def editvm(request, pk):
    cm = Party_master.objects.get(pk=pk)

    if request.method == "POST":
        customer_name = request.POST.get("customer_name")
        group = Group.objects.get(name='Sundry Creditors')

        if request.POST.get("maintain_bbb"):
            maintain_bbb = True
        else:
            maintain_bbb = False

        dafault_credit_period = request.POST.get("dafault_credit_period")

        if request.POST.get("check_credit_days"):
            check_credit_days = True
        else:
            check_credit_days = False

        payment_terms = request.POST.get("payment_terms")
        credit_limit = request.POST.get("credit_limit")

        if request.POST.get("override_credit_limit"):
            override_credit_limit = True
        else:
            override_credit_limit = False

        if request.POST.get("zone"):
            zone = Zone.objects.get(id=request.POST.get("zone"))
        else:
            zone = None

        if request.POST.get("region"):
            region = Region.objects.get(id=request.POST.get("region"))
        else:
            region = None

        if request.POST.get("zsm_name"):
            zsm_name = Zsm.objects.get(id=request.POST.get("zsm_name"))
        else:
            zsm_name = None

        if request.POST.get("asm_name"):
            asm_name = Asm.objects.get(id=request.POST.get("asm_name"))
        else:
            asm_name = None

        if request.POST.get("se_name"):
            se_name = Se.objects.get(id=request.POST.get("se_name"))
        else:
            se_name = None

        if request.POST.get("mailing_name"):
            mailing_name = request.POST.get("mailing_name")
        else:
            mailing_name = customer_name

        addressline1 = request.POST.get("addressline1")
        addressline2 = request.POST.get("addressline2")
        addressline3 = request.POST.get("addressline3")

        if request.POST.get("country"):
            country = Country.objects.get(id=request.POST.get("country"))
        else:
            return HttpResponse("please enter Country")

        if request.POST.get("state"):
            state = State.objects.get(id=request.POST.get("state"))
        else:
            return HttpResponse("please enter State")

        if request.POST.get("city"):
            city = City.objects.get(id=request.POST.get("city"))
        else:
            return HttpResponse("please enter City")

        if request.POST.get("pin_code"):
            pin_code = request.POST.get("pin_code")
        else:
            return HttpResponse("please enter PinCode")

        if request.POST.get("mobile_no"):
            mobile_no = request.POST.get("mobile_no")
        else:
            return HttpResponse("please enter Mobile No")

        if request.POST.get("provide_contact_details"):
            contact_details = True
        else:
            contact_details = False

        contact_person = request.POST.get("contact_person")
        if request.POST.get("phone_no"):
            phone_no = request.POST.get("phone_no")
        else:
            phone_no = None

        if request.POST.get("fax_no"):
            fax_no = request.POST.get("fax_no")
        else:
            fax_no = None

        email_id = request.POST.get("email_id")
        cc_email = request.POST.get("cc_email")
        website = request.POST.get("website")

        if request.POST.get("multiple_address_list"):
            multiple_address_list = True
        else:
            multiple_address_list = False

        registration_type = request.POST.get("registration_type")

        gstin = request.POST.get("gstin")
        pan_no = request.POST.get("pan_no")
        division = Division.objects.get(id=request.POST.get("divisions"))

        transation_type = request.POST.get("transation_type")
        bank = request.POST.get("bank")
        ifsc_code = request.POST.get("ifsc_code")
        account_no = request.POST.get("account_no")
        account_name = request.POST.get("account_name")
        cm.name=customer_name
        cm.devision=division
        cm.maintain_bill_by_bill=maintain_bbb
        cm.dafault_credit_period=dafault_credit_period
        cm.check_credit_days=check_credit_days
        cm.payment_terms=payment_terms
        cm.credit_limit=credit_limit
        cm.override_credit_limit=override_credit_limit
        cm.zone=zone
        cm.region=region
        cm.zsm=zsm_name
        cm.contact_details=contact_details
        cm.asm=asm_name
        cm.se=se_name
        cm.mailing_name=mailing_name
        cm.addressline1=addressline1
        cm.addressline2=addressline2
        cm.addressline3=addressline3
        cm.country=country
        cm.state=state
        cm.pin_code=pin_code
        cm.city=city
        cm.mobile_no=mobile_no
        cm.contact_person=contact_person
        cm.phone_no=phone_no
        cm.fax_no=fax_no
        cm.email_id=email_id
        cm.cc_email=cc_email
        cm.website=website
        cm.multiple_address_list=multiple_address_list
        cm.pan_no=pan_no
        cm.gstin=gstin
        cm.gst_registration_type=registration_type
        cm.transation_type=transation_type
        cm.bank=bank
        cm.ifsc_code=ifsc_code
        cm.account_no=account_no
        cm.account_name=account_name
        cm.save()

        address_type1 = request.POST.getlist("address_type1")
        mailing_name1 = request.POST.getlist("mailing_name1")
        pcd_addressline1 = request.POST.getlist("pcd_addressline11")
        pcd_addressline2 = request.POST.getlist("pcd_addressline21")
        pcd_addressline3 = request.POST.getlist("pcd_addressline31")
        pcd_country = request.POST.getlist("pcd_country")
        pcd_state = request.POST.getlist("pcd_state")
        pcd_city = request.POST.getlist("pcd_city")
        pcd_pincode = request.POST.getlist("pcd_pincode1")
        pcd_contact_person = request.POST.getlist("pcd_contact_person1")
        pcd_phone_no = request.POST.getlist("pcd_phone_no1")
        pcd_mobile_no = request.POST.getlist("pcd_mobile_no1")
        pcd_fax_no = request.POST.getlist("pcd_fax_no1")
        pcd_cc_email = request.POST.getlist("pcd_email_id1")
        pcd_pan_no = request.POST.getlist("pcd_pan_no1")
        pcd_gst_registration_type = request.POST.getlist(
            "pcd_gst_registration_type1")
        pcd_gstin = request.POST.getlist("pcd_gstin1")
        Party_contact_details.objects.filter(party=cm).delete()

        check_addresstype = request.POST.get("address_type1")
        if check_addresstype and len(check_addresstype):
            for i, j in enumerate(address_type1):
                if pcd_state[i]:
                    state = State.objects.get(id=pcd_state[i])
                else:
                    state = None
                if pcd_city[i]:
                    city = City.objects.get(id=pcd_city[i])
                else:
                    city = None
                if pcd_country[i]:
                    country = Country.objects.get(id=pcd_country[i])
                else:
                    country = None
                pincode = pcd_pincode[i] if len(pcd_pincode) else ''
                phone_no = pcd_phone_no[i] if len(pcd_phone_no) else ''
                mobile_no = pcd_mobile_no[i] if len(pcd_mobile_no) else ''
                fax_no = pcd_fax_no[i] if len(pcd_fax_no) else ''
                cc_email = pcd_cc_email[i] if len(pcd_cc_email) else ''
                pan_no = pcd_pan_no[i] if len(pcd_pan_no) else ''
                gstin = pcd_gstin[i] if len(pcd_gstin) else ''
                contact_person = pcd_contact_person[i] if len(pcd_contact_person) else ''
                Party_contact_details.objects.create(party=cm, address_type=j, mailing_name=mailing_name1[i],
                                                            addressline1=pcd_addressline1[i], addressline2=pcd_addressline2[i],addressline3=pcd_addressline3[i],
                                                           country=country, state=state, city=city,email_id=cc_email,
                                                           pin_code=pincode, contact_person=pcd_contact_person[i],
                                                           phone_no=phone_no, mobile_no=mobile_no, fax_no=fax_no,
                                                           pan_no=pan_no, gst_registration_type=pcd_gst_registration_type[i],
                                                           gstin=gstin)
        cm = Party_master.objects.get(id=pk)
        addresses=Party_contact_details.objects.filter(party=cm)
        xml = cmxml(cm, request, cm.vendor_code, group, addresses)
        com = Company.objects.all()
        for i  in com:
            mainxml = '''<ENVELOPE><HEADER><TALLYREQUEST>Import Data</TALLYREQUEST></HEADER><BODY><IMPORTDATA><REQUESTDESC><REPORTNAME>All Masters</REPORTNAME><STATICVARIABLES><SVCURRENTCOMPANY>Company_name</SVCURRENTCOMPANY></STATICVARIABLES></REQUESTDESC><REQUESTDATA><TALLYMESSAGE xmlns:UDF="TallyUDF">xml_creator</TALLYMESSAGE></REQUESTDATA></IMPORTDATA></BODY></ENVELOPE>'''
            mainxml = mainxml.replace('Company_name',i.tally_name)
            payload = mainxml.replace('xml_creator', xml)
            req = requests.post(url=i.ipaddress, data=payload)
        messages.success(request, "Vendor: {} Updated Successfully".format(customer_name))
        return redirect('ledgers:vm')
    countries = Country.objects.all()
    zones = Zone.objects.all()
    groups = Group.objects.all()
    party_types = PartyType.objects.all()
    cm = Party_master.objects.get(pk=pk)
    divisions = Division.objects.all()
    addresses=Party_contact_details.objects.filter(party=cm)
    context = {'cm':cm,'countries': countries, 'zones': zones,'divisions':divisions,'addresses':addresses,
               'groups': groups, 'party_types': party_types}

    return render(request, 'ledgers/edit_vendor.html', context)


@allowed_users(allowed_roles=['Admin', 'Vendor View', 'Vendor Create', 'Vendor Update', 'Vendor Delete'])
def showvm(request, pk):

    cm = Party_master.objects.get(pk=pk)
    addresses=Party_contact_details.objects.filter(party=cm)

    return render(request,"ledgers/show_vendor.html",{'cm' : cm,'addresses':addresses})

@allowed_users(allowed_roles=['Admin', 'Vendor Delete'])
def deletevm(request, pk):

    cm = Party_master.objects.get(pk=pk)
    cm.status = False
    cm.save()

    return HttpResponse("Party Deactivated")


@method_decorator(allowed_users(allowed_roles=['Admin', 'Ledger View', 'Ledger Create', 'Ledger Update', 'Ledger Delete']), name='dispatch')
class LedgersView(ListView):
    model = LedgersType
    template_name = 'ledgers/ledger.html'
    context_object_name = 'ledgers'
    paginate_by = 10

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = LedgersType.objects.all().order_by("name")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@allowed_users(allowed_roles=['Admin', 'Ledger Create', 'Ledger Update', 'Ledger Delete'])
def add_ledger(request):

    if request.method == 'POST':

        parent = request.POST.get("group")
        under = Group.objects.get(name=parent)
        name = request.POST.get("ledger_name")
        gst_applicable = request.POST.get("gstapplicable")
        suply_type = request.POST.get("suply_type")

        LedgersType.objects.get_or_create( name=name, under=under, gst_applicable=gst_applicable, type_of_supply=suply_type)

    groups = Group.objects.all()
    ledgers = LedgersType.objects.all()
    context = {'groups': groups, 'ledgers': ledgers}

    return render(request, 'ledgers/ledger.html', context)

@allowed_users(allowed_roles=['Admin', 'Ledger Update', 'Ledger Delete'])
def edit_ledger(request, pk):

    ledgers = LedgersType.objects.get(id=pk)

    if request.method == 'POST':
        parent = request.POST.get("group")
        under = Group.objects.get(name=parent)
        name = request.POST.get("ledger_name")
        gst_applicable = request.POST.get("gstapplicable")
        suply_type = request.POST.get("suply_type")

        LedgersType.objects.get_or_create(
            name=name, under=under, gst_applicable=gst_applicable, type_of_supply=suply_type)

    groups = Group.objects.all()
    context = {'groups': groups, 'ledgers': ledgers}

    return render(request, 'ledgers/ledger.html', context)


@method_decorator(allowed_users(allowed_roles=['Admin', 'ASM View', 'ASM Create', 'ASM Update', 'ASM Delete']), name='dispatch')
class AsmView(ListView):
    model = Asm
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'asm/add'
        data['edit'] = 'asm/edit/'
        data['tag'] = 'Area Sales Manager'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Asm.objects.values(Zone=F('zone__name'), Region=F('region__name'), ZSM=F('zsm__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'ASM Create', 'ASM Update', 'ASM Delete']), name='dispatch')
class add_asm(CreateView):
    model = Asm
    template_name = 'ledgers/common.html'
    success_url = "/led/asm"
    form_class = AsmForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'ASM'
        data['url'] = 'asm'
        data['action'] = 'Create'
        data['div']=3
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'ASM Update', 'ASM Delete']), name='dispatch')
class edit_asm(UpdateView):
    model = Asm
    template_name = 'ledgers/common.html'
    success_url = "/led/asm"
    form_class = AsmForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'ASM'
        data['url'] = 'asm'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'ZSM View', 'ZSM Create', 'ZSM Update', 'ZSM Delete']), name='dispatch')
class ZsmView(ListView):
    model = Zsm
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'zsm/add'
        data['edit'] = 'zsm/edit/'
        data['tag'] = 'Zonal Sales Manager'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Zsm.objects.values(Country=F('zone__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'ZSM Create', 'ZSM Update', 'ZSM Delete']), name='dispatch')
class add_zsm(CreateView):
    model = Zsm
    template_name = 'ledgers/common.html'
    success_url = "/led/zsm"
    form_class = ZsmForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Zonal Sales Manager'
        data['url'] = 'zsm'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'ZSM Update', 'ZSM Delete']), name='dispatch')
class edit_zsm(UpdateView):
    model = Zsm
    template_name = 'ledgers/common.html'
    success_url = "/led/zsm"
    form_class = ZsmForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Zonal Sales Manager'
        data['url'] = 'zsm'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'RSM View', 'RSM Create', 'RSM Update', 'RSM Delete']), name='dispatch')
class RsmView(ListView):
    model = Rsm
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'rsm/add'
        data['edit'] = 'rsm/edit/'
        data['tag'] = 'Regional Sales Manager'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Rsm.objects.values(Zone=F('zone__name'), Region=F('region__name'), ZSM=F('zsm__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'RSM Create', 'RSM Update', 'RSM Delete']), name='dispatch')
class add_rsm(CreateView):
    model = Rsm
    template_name = 'ledgers/common.html'
    success_url = "/led/rsm"
    form_class = RsmForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'RSM'
        data['url'] = 'rsm'
        data['action'] = 'Create'
        data['div']=3
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'RSM Update', 'RSM Delete']), name='dispatch')
class edit_rsm(UpdateView):
    model = Rsm
    template_name = 'ledgers/common.html'
    success_url = "/led/rsm"
    form_class = RsmForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'RSM'
        data['url'] = 'rsm'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Country View', 'Country Create', 'Country Update', 'Country Delete']), name='dispatch')
class CountryView(ListView):
    model = Country
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'country/add'
        data['edit'] = 'country/edit/'
        data['tag'] = 'Country'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Country.objects.values('name', 'id').order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Country Create', 'Country Update', 'Country Delete']), name='dispatch')
class add_country(CreateView):
    model = Country
    template_name = 'ledgers/common.html'
    success_url = "/led/country"
    form_class = CountryForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Country'
        data['url'] = 'country'
        data['action'] = 'Create'
        data['div']=8
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Country Update', 'Country Delete']), name='dispatch')
class edit_country(UpdateView):
    model = Country
    template_name = 'ledgers/common.html'
    success_url = "/led/country"
    form_class = CountryForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Country'
        data['url'] = 'country'
        data['action'] = 'Edit'
        data['div']=8
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'State View', 'State Create', 'State Update', 'State Delete']), name='dispatch')
class StateView(ListView):
    model = State
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'state/add'
        data['edit'] = 'state/edit/'
        data['tag'] = 'State'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = State.objects.values(Country=F('country__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'State Create', 'State Update', 'State Delete']), name='dispatch')
class add_state(CreateView):
    model = State
    template_name = 'ledgers/common.html'
    success_url = "/led/state"
    form_class = StateForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'State'
        data['url'] = 'State'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'State Update', 'State Delete']), name='dispatch')
class edit_state(UpdateView):
    model = State
    template_name = 'ledgers/common.html'
    success_url = "/led/state"
    form_class = StateForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'State'
        data['url'] = 'State'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'City View', 'City Create', 'City Update', 'City Delete']), name='dispatch')
class CityView(ListView):
    model = City
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'city/add'
        data['edit'] = 'city/edit/'
        data['tag'] = 'City'
        return data
 
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = City.objects.select_related('state', 'state__country').values(Country=F('state__country__name'), State=F('state__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'City Create', 'City Update', 'City Delete']), name='dispatch')
class add_city(CreateView):
    model = City
    template_name = 'ledgers/common.html'
    success_url = "/led/city"
    form_class = CityForm
 
    def get_queryset(self):
        return City.objects.select_related('state', 'state__country')

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'City'
        data['url'] = 'City'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'City Update', 'City Delete']), name='dispatch')
class edit_city(UpdateView):
    model = City
    template_name = 'ledgers/common.html'
    success_url = "/led/city"
    form_class = CityForm
        
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'City'
        data['url'] = 'City'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Channel View', 'Channel Create', 'Channel Update', 'Channel Delete']), name='dispatch')
class PartyTypeView(ListView):
    model = PartyType
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'party_type/add'
        data['edit'] = 'party_type/edit/'
        data['tag'] = 'Channels'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = PartyType.objects.values('name', 'id').order_by("-created") 
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Channel Create', 'Channel Update', 'Channel Delete']), name='dispatch')
class add_party_type(CreateView):
    model = PartyType
    template_name = 'ledgers/common.html'
    success_url = "/led/party_type"
    form_class = PartyTypeForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Channels'
        data['url'] = 'party_type'
        data['action'] = 'Create'
        data['div']=8
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Channel Update', 'Channel Delete']), name='dispatch')
class edit_party_type(UpdateView):
    model = PartyType
    template_name = 'ledgers/common.html'
    success_url = "/led/party_type"
    form_class = PartyTypeForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Channels'
        data['url'] = 'party_type'
        data['action'] = 'Edit'
        data['div']=8
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Zone View', 'Zone Create', 'Zone Update', 'Zone Delete']), name='dispatch')
class ZoneView(ListView):
    model = Zone
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'zone/add'
        data['edit'] = 'zone/edit/'
        data['tag'] = 'Zone'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Zone.objects.values('name', 'id').order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Zone Create', 'Zone Update', 'Zone Delete']), name='dispatch')
class add_zone(CreateView):
    model = Zone
    template_name = 'ledgers/common.html'
    success_url = "/led/zone"
    form_class = ZoneForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Zone'
        data['url'] = 'Zone'
        data['action'] = 'Create'
        data['div']=6
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Zone Update', 'Zone Delete']), name='dispatch')
class edit_zone(UpdateView):
    model = Zone
    template_name = 'ledgers/common.html'
    success_url = "/led/zone"
    form_class = ZoneForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Zone'
        data['url'] = 'Zone'
        data['action'] = 'Edit'
        data['div']=6
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Division View', 'Division Create', 'Division Update', 'Division Delete']), name='dispatch')
class DivisionView(ListView):
    model = Division
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'division/add'
        data['edit'] = 'division/edit/'
        data['tag'] = 'Division'
        return data

    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Division.objects.values('name', 'id').order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs


@method_decorator(allowed_users(allowed_roles=['Admin', 'Division Create', 'Division Update', 'Division Delete']), name='dispatch')
class add_division(CreateView):
    model = Division
    template_name = 'ledgers/common.html'
    success_url = "/led/division"
    form_class = DivisionForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Division'
        data['url'] = 'Division'
        data['action'] = 'Create'
        data['div']=6
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Division Update', 'Division Delete']), name='dispatch')
class edit_division(UpdateView):
    model = Division
    template_name = 'ledgers/common.html'
    success_url = "/led/division"
    form_class = DivisionForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Division'
        data['url'] = 'Division'
        data['action'] = 'Edit'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'SE View', 'SE Create', 'SE Update', 'SE Delete']), name='dispatch')
class SeView(ListView):
    model = Se
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'se/add'
        data['edit'] = 'se/edit/'
        data['tag'] = 'Sales Executive'
        return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Se.objects.values(Zone=F('zone__name'), Region=F('region__name'), ZSM=F('zsm__name'), RSM=F('rsm__name'),ASM=F('asm__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs


@method_decorator(allowed_users(allowed_roles=['Admin', 'SE Create', 'SE Update', 'SE Delete']), name='dispatch')
class add_se(CreateView):
    model = Se
    template_name = 'ledgers/common.html'
    success_url = "/led/se"
    form_class = SeForm
 
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Sales Executive'
        data['url'] = 'se'
        data['action'] = 'Create'
        data['div']=3
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'SE Update', 'SE Delete']), name='dispatch')
class edit_se(UpdateView):
    model = Se
    template_name = 'ledgers/common.html'
    success_url = "/led/se"
    form_class = SeForm
    

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Sales Executive'
        data['url'] = 'se'
        data['action'] = 'Edit'
        data['div']=3
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Region View', 'Region Create', 'Region Update', 'Region Delete']), name='dispatch')
class RegionView(ListView):
    model = Region
    template_name = 'ledgers/commonlistview.html'
    context_object_name = 'brands'
    paginate_by = 10

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'region/add'
        data['edit'] = 'region/edit/'
        data['tag'] = 'Region'
        return data
    
    def get_queryset(self):
        query = self.request.GET.get('q', None)
        qs = Region.objects.values(Zone=F('zone__name'), Name=F('name')).annotate(id=F('id')).order_by("-created")
        if query is not None:
            qs=qs.filter(name__icontains=query )
        return qs

@method_decorator(allowed_users(allowed_roles=['Admin', 'Region Create', 'Region Update', 'Region Delete']), name='dispatch')
class add_region(CreateView):
    model = Region
    template_name = 'ledgers/common.html'
    success_url = "/led/region"
    form_class = RegionForm
    
    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Region'
        data['url'] = 'Region'
        data['action'] = 'Create'
        data['div']=4
        return data

@method_decorator(allowed_users(allowed_roles=['Admin', 'Region Create', 'Region Update', 'Region Delete']), name='dispatch')
class edit_region(UpdateView):
    model = Region
    template_name = 'ledgers/common.html'
    success_url = "/led/region"
    form_class = RegionForm

    def get_context_data(self, **kwargs):
        data = super().get_context_data(**kwargs)
        data['title'] = 'Region'
        data['url'] = 'Region'
        data['action'] = 'Edit'
        data['div']=4
        return data

#---------------------------------------------------------------------------- ajax requests


def load_states(request):
    country_id = request.GET.get('country')
    states = State.objects.filter(country=country_id).order_by('name')
    return render(request, 'ledgers/partials/state.html', {'states': states})


def load_cities(request):
    state_id = request.GET.get('state')
    cities = City.objects.filter(state=state_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})


def load_zones(request):
    state_id = request.GET.get('region')
    cities = Region.objects.filter(zone=state_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})

def zones(request):
    state_id = request.GET.get('region')
    cities = Region.objects.filter(zone=state_id).order_by('name')
    return render(request, 'ledgers/partials/region.html', {'cities': cities})

def zsms(request):
    state_id = request.GET.get('region')
    cities = Zsm.objects.filter(zone=state_id).order_by('name')
    return render(request, 'ledgers/partials/region.html', {'cities': cities})

def load_zsms(request):
    state_id = request.GET.get('zone')
    cities = Zsm.objects.filter(zone=state_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})

def rsms(request):
    zone_id = request.GET.get('zone')
    region_id = request.GET.get('region')
    zsm_id = request.GET.get('zsm')
    cities = Rsm.objects.filter(zone=zone_id, region=region_id, zsm=zsm_id).order_by('name')
    return render(request, 'ledgers/partials/region.html', {'cities': cities})

def asms(request):
    zone_id = request.GET.get('zone')
    region_id = request.GET.get('region')
    zsm_id = request.GET.get('zsm')
    rsm_id = request.GET.get('rsm')
    cities = Asm.objects.filter(zone=zone_id, region=region_id, zsm=zsm_id, rsm=rsm_id).order_by('name')
    return render(request, 'ledgers/partials/region.html', {'cities': cities})

def load_rsms(request):
    zone_id = request.GET.get('zone')
    region_id = request.GET.get('region')
    zsm_id = request.GET.get('zsm')
    cities = Rsm.objects.filter(zone=zone_id, region=region_id, zsm=zsm_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})


def load_asms(request):
    zone_id = request.GET.get('zone')
    region_id = request.GET.get('region')
    zsm_id = request.GET.get('zsm')
    rsm_id = request.GET.get('rsm')
    cities = Asm.objects.filter(zone=zone_id, region=region_id, zsm=zsm_id, rsm=rsm_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})


def load_ses(request):
    zone_id = request.GET.get('zone')
    region_id = request.GET.get('region')
    zsm_id = request.GET.get('zsm')
    rsm_id = request.GET.get('rsm')
    state_id = request.GET.get('asm')
    cities = Se.objects.filter(zone=zone_id, region=region_id, zsm=zsm_id, rsm=rsm_id,asm=state_id).order_by('name')
    return render(request, 'ledgers/partials/city.html', {'cities': cities})


#ledgers/partials
def cmmultiadd(request):

    no = int(request.GET['no'])+1
    countries = Country.objects.all()

    context = {'countries': countries, 'no': no}

    return render(request, 'ledgers/partials/cmmultiadd.html', context)