from datetime import date
from decimal import Decimal
from django.shortcuts import render, redirect
from django.http import HttpResponse
import requests
from tablib import Dataset
from inventory.models import Godown, Product_master
from company.models import Company
from production.models import JobCard, RMIndent, RMIndentItems, RMItemGodown
from purchase.models import Grn, PiItems, Purchase, grnItems
from sales.models import Delivery_note, Invoice, PackingSheet, Rso, SaleQty
from warehouse.models import PalletTransferEntry, ShortageDamageEntry, Stock_summary
from django.db.models import Sum
from core.decorators import auth_users, allowed_users, is_company
from django.contrib import messages

# Create your views here.

def warehouse(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    context = {}
    context['grn'] = Grn.objects.filter(company=com).count()
    context['dn'] = Delivery_note.objects.filter(company=com).count()
    context['tr'] = Delivery_note.objects.filter(company=com).count()
    context['ps'] = PackingSheet.objects.filter(company=com).count()
    context['lr'] = Invoice.objects.filter(company=com).count()
    context['pt'] = Invoice.objects.filter(company=com).count()
    return render(request, "warehouse/warehouse.html", context)


def transfers(request):
    context = {}
    context['sd'] =ShortageDamageEntry.objects.count()
    context['ict'] =Invoice.objects.filter(is_ict=True).count()
    context['ivt'] =Rso.objects.filter(is_ivt=True).count()
    return render(request, "warehouse/transfers.html", context)

@allowed_users(allowed_roles=['Admin', 'Pallet Transfer'])
def pt(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    if request.method == 'POST':

        godown      = request.POST.get("godown")
        pk          = request.POST.get("product")
        product     = Product_master.objects.get(product_code=pk)

        qtylist     = request.POST.getlist("qty")
        targetlist  = request.POST.getlist("target")

        godown=Godown.objects.get(name=godown)

        for i,j in enumerate(targetlist):

            qty=Decimal(qtylist[i])
            target=Godown.objects.get(name=j)
            PalletTransferEntry.objects.create(company=com,item=product,fgodown=godown,tgodown=target,qty=qty,createdby = request.user.username)
            st=Stock_summary.objects.filter(company=com,godown=godown, product=product).order_by('batch')
            for st1 in st:
                if qty >= st1.closing_balance:
                    qty -= st1.closing_balance
                    st2=Stock_summary.objects.create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    st2.closing_balance = st1.closing_balance
                    st1.delete()
                    st2.save()
                    if qty == 0:
                        break
                else:
                    st1.closing_balance -= qty
                    st1.save()
                    st2=Stock_summary.objects.create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    st2.closing_balance = qty
                    st2.save()
                    break
    # if request.user.is_staff:
    godown = Godown.objects.all()
    # else:
        # godown = Godown.objects.all().exclude(name__in = ['DAMAGE & SCRAP', 'SHORTAGE'])
    return render(request, 'warehouse/pallettransfer.html',{'godowns':godown})

def pt_upload(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    if request.method == 'POST':

        dataset = Dataset()
        new_products = request.FILES['importData']

        imported_data = dataset.load(new_products.read())
        for j,i in enumerate(imported_data):

            product             = Product_master.objects.get(product_code=i[0])
            godown              = Godown.objects.get(name=(i[1]).upper())
            target              = Godown.objects.get(name=(i[2]).upper())
            qty                 = Decimal(i[3])
            
            PalletTransferEntry.objects.create(company=com,item=product,fgodown=godown,tgodown=target,qty=qty,createdby = request.user.username)

            st=Stock_summary.objects.filter(godown=godown, product=product).order_by('batch')
            for st1 in st:
                if qty >= st1.closing_balance:
                    qty -= st1.closing_balance
                    st2 =Stock_summary.objects.create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    st2.closing_balance = st1.closing_balance
                    st1.delete()
                    st2.save()
                    if qty == 0:
                        break
                else:
                    st1.closing_balance -= qty
                    st1.save()
                    st2=Stock_summary.objects.create(company=com,godown=target,mrp=st1.mrp, rate=st1.rate, product=product, batch=st1.batch)
                    st2.closing_balance = qty
                    st2.save()
                    break

    return render(request, 'warehouse/pt_upload.html',)

@allowed_users(allowed_roles=['Admin', 'Shortage/Damage'])
def shortage(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    if request.method == 'POST':

        godown      = request.POST.get("godown")
        pk          = request.POST.get("product")
        product     = Product_master.objects.get(product_code=pk)

        sqty        = Decimal(request.POST.get("sqty"))
        dqty        = Decimal(request.POST.get("dqty"))
        sremarks    = request.POST.get("s_remark")
        dremarks    = request.POST.get("d_remark")

        godown      = Godown.objects.get(name=godown)

        grn_no      = request.POST.get('purchase')
        
        if grn_no and 'GRN' in grn_no:
            grn         = Grn.objects.get(grn_no=grn_no)
            purchase    = grn.pi

        elif 'JC' in grn_no:
            purchase    = RMIndent.objects.get(no=grn_no)
            items       = RMIndentItems.objects.filter(rmindent=purchase, item = product)
            st          = RMItemGodown.objects.filter(rmitem__in = items, godown=godown)
            
            if sqty > 0:
                Stock_summary.objects.create(company=com,godown=shortage, rate=st[0].rate, mrp=st[0].mrp, product=product, batch=st[0].batch,closing_balance=sqty)
            if dqty > 0:
                Stock_summary.objects.create(company=com,godown=damage, rate=st[0].rate, mrp=st[0].mrp, product=product, batch=st[0].batch,closing_balance=dqty)
            ShortageDamageEntry.objects.create(company=com,purchase = purchase,item = product,godown = godown,sqty=sqty,dqty = dqty,rate = st[0].rate, sremarks = sremarks,dremarks= dremarks, createdby = request.user.username)
            qty = sqty + dqty
            if qty > 0:
                for st1 in st:
                    if qty >= st1.qty:
                        qty -= st1.qty
                        st1.delete()
                        if qty == 0:
                            break
                    else:
                        st1.qty -= qty
                        st1.save()
                        break
            return redirect("warehouse:shortage")
        else:
            purchase    = None

        shortage    = Godown.objects.get(name='SHORTAGE')
        damage      = Godown.objects.get(name='DAMAGE & SCRAP')


        st          = Stock_summary.objects.filter(company=com, godown=godown, product=product).order_by('batch')
        ShortageDamageEntry.objects.create(company=com,purchase = purchase,item = product,godown = godown,sqty=sqty,dqty = dqty,rate = st[0].rate, sremarks = sremarks,dremarks= dremarks, createdby = request.user.username)
        if sqty > 0:
            Stock_summary.objects.create(company=com,godown=shortage, rate=st[0].rate, mrp=st[0].mrp, product=product, batch=st[0].batch,closing_balance=sqty)
        if dqty > 0:
            Stock_summary.objects.create(company=com,godown=damage, rate=st[0].rate, mrp=st[0].mrp, product=product, batch=st[0].batch,closing_balance=dqty)
        
        qty = sqty + dqty
        if qty > 0:
            for st1 in st:
                if qty >= st1.closing_balance:
                    qty -= st1.closing_balance
                    st1.delete()
                    if qty == 0:
                        break
                else:
                    st1.closing_balance -= qty
                    st1.save()
                    break

        return redirect("warehouse:shortage")

    godown          = Godown.objects.all().exclude(name__in = ['DAMAGE & SCRAP', 'SHORTAGE'])
    purchase        = Grn.objects.filter(company=com)
    jobs            = RMIndent.objects.filter(company=com)
    return render(request, 'warehouse/shortagetransfer.html',{'godowns':godown,'purchase':purchase, 'jobs':jobs})

def load_products(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    name = request.GET.get('godown')
    godown = Godown.objects.get(name=name)

    grn_no = request.GET.get('purchase', None)
    if grn_no == '':
        grn_no=None

    if (grn_no == 'Warehouse' or grn_no == None):
        products = Stock_summary.objects.filter(company=com,godown=godown)
        return render(request, 'warehouse/partials/products.html',{'products':products})
    if 'JC' in grn_no:
        purchase    = RMIndent.objects.get(no=grn_no)
        items       = RMIndentItems.objects.filter(rmindent=purchase)
        godowns     = RMItemGodown.objects.filter(rmitem__in = items, godown=name).values_list('rmitem', flat=True)
        products    = RMIndentItems.objects.filter(id__in = godowns)
    else:
        grn         = Grn.objects.get(grn_no=grn_no)
        batch       = grnItems.objects.filter(grn=grn).last().batch
        products    = Stock_summary.objects.filter(company=com,godown=godown,batch__icontains=batch[:-3])

    return render(request, 'warehouse/partials/products.html',{'products':products})

def load_godowns(request):

    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com         = Company.objects.get(id=skey)

    name        = request.GET.get('puchase')
    if 'JC' in name:
        purchase    = RMIndent.objects.get(no=name)
        items       = RMIndentItems.objects.filter(rmindent=purchase)
        godowns = RMItemGodown.objects.filter(rmitem__in = items).values_list('godown', flat=True)
    else:
        purchase    = Grn.objects.get(grn_no=name)
        items       = grnItems.objects.filter(grn=purchase).values('batch', 'item')
        godowns     = set()
        for i in items:
            for j in Stock_summary.objects.filter(company=com,product=i.get('item'),batch=i.get('batch')):
                godowns.add(j.godown)

    return render(request, 'warehouse/partials/godowns.html',{'products':godowns})

def load_qty(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    name = request.GET.get('godown')
    pd = request.GET.get('product')
    grn_no = request.GET.get('purchase' or None)
    godown = Godown.objects.get(name=name)
    product=Product_master.objects.get(product_code=pd)
    if grn_no == '':
        grn_no=None

    if grn_no == 'Warehouse' or grn_no == None:
        qs = Stock_summary.objects.filter(company=com,godown=godown, product=product).aggregate(Sum('closing_balance'))
        qty= qs.values()
    
    if 'JC' in grn_no:
        purchase    = RMIndent.objects.get(no=grn_no)
        items       = RMIndentItems.objects.filter(rmindent=purchase, item = product)
        qty     = RMItemGodown.objects.filter(rmitem__in = items, godown=name).aggregate(Sum('qty')).values()

    if 'GRN' in grn_no:
        grn = Grn.objects.get(grn_no=grn_no)
        batch = grnItems.objects.filter(grn=grn).last().batch
        qty = Stock_summary.objects.get(godown=godown, product=product,batch__icontains=batch[:-3]).closing_balance
    
    return HttpResponse(qty)

def load_pt_qty(request):
    try:
        skey = (request.session.get('skey').get('company').get('id'))
    except:
        return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
    com = Company.objects.get(id=skey)

    name = request.GET.get('godown')
    pd = request.GET.get('product')
    godown = Godown.objects.get(name=name)
    product=Product_master.objects.get(product_code=pd)
    qty = Stock_summary.objects.filter(company=com,godown=godown, product=product).aggregate(Sum('closing_balance')).values()
    
    return HttpResponse(qty)
def tgt(request):

    godowns = Godown.objects.all()
    return render(request, 'warehouse/partials/tgt.html',{'godowns':godowns})


def mt(request):

    if request.method == 'POST':

        godown  = request.POST.get("godown")
        pk = request.POST.get("product")
        product=Product_master.objects.get(pk=pk)

        qtylist     = request.POST.getlist("qty")
        targetlist  = request.POST.getlist("target")

        try:
            skey = (request.session.get('skey').get('company').get('id'))
        except:
            return render(request, 'errorcompany.html', {'message': 'Please Select Company First'})
        com = Company.objects.get(id=skey)
        godown=Godown.objects.get(name=godown)

        for i,j in enumerate(targetlist):

            qty=Decimal(qtylist[i])
            target=Godown.objects.get(name=j)

            st1=Stock_summary.objects.get(godown=godown, name=product)
            st1.closing_balance -= qty
            if st1.closing_balance >= 0:
                st1.save()
            else:
                qty = qty+st1.closing_balance
                st1.closing_balance = 0
                st1.save()
                break
            try :
                st2=Stock_summary.objects.get(company=com,godown=target, name=product)
                st2.closing_balance += qty
                st2.save()
            except Stock_summary.DoesNotExist:
                Stock_summary.objects.create(company=com,godown=target,batch=st1.batch ,name=product,mrp=st1.mrp, closing_balance=qty)

    godown = Godown.objects.all()
    return render(request, 'warehouse/pallettransfer.html',{'godowns':godown})
