from decimal import Decimal
import xml.etree.ElementTree as Et


def invcreator(data, items):
#Invoice
    root=Et.Element("VOUCHER",{"VCHTYPE":"Sales","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    m1=Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append(m1)

    b1=Et.SubElement(m1,"ADDRESS")
    b1.text=str(data.buyer_address1)

    b2=Et.SubElement(m1,"ADDRESS")
    b2.text=str(data.buyer_address2)

    b3=Et.SubElement(m1,"ADDRESS")
    b3.text=str(data.buyer_address3)

    m2=Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append(m2)

    b5=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b5.text=str(data.company.dis_add1)

    b6=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b6.text=str(data.company.dis_add2)

    b7=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b7.text=str(data.company.dis_add3)

    m3=Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append(m3)

    b8=Et.SubElement(m3,"BASICBUYERADDRESS")
    b8.text=str(data.shipto_address1)

    b9=Et.SubElement(m3,"BASICBUYERADDRESS")
    b9.text=str(data.shipto_address2)

    b10=Et.SubElement(m3,"BASICBUYERADDRESS")
    b10.text=str(data.shipto_address3)

    m4=Et.Element("BASICORDERTERMS.LIST ",{"TYPE":"String"})
    root.append(m4)

    b11=Et.SubElement(m4,"BASICORDERTERMS")
    b11.text=data.terms_of_delivery

    m5=Et.Element("OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})
    root.append(m5)

    b12=Et.SubElement(m5,"OLDAUDITENTRYIDS")
    b12.text="-1"

    m6=Et.Element("DATE")
    m6.text=data.inv_date.strftime('%Y%m%d')
    root.append(m6)

    m7=Et.Element("BILLOFLADINGDATE")
    if data.lr_date:
        m7.text=data.lr_date.strftime('%Y%m%d')
    root.append(m7)

    m9=Et.Element("GSTREGISTRATIONTYPE")
    m9.text=data.buyer.gst_registration_type
    root.append(m9)

    m10=Et.Element("STATENAME")
    m10.text=data.buyer_state
    root.append(m10)

    m11=Et.Element("VOUCHERTYPENAME")
    m11.text="Sales"
    root.append(m11)

    m13=Et.Element("COUNTRYOFRESIDENCE")
    m13.text=data.buyer_country
    root.append(m13)

    m14=Et.Element("PARTYGSTIN")
    m14.text=data.buyer_gstin
    root.append(m14)

    m15=Et.Element("PLACEOFSUPPLY")
    m15.text=data.shipto_state
    root.append(m15)

    m16=Et.Element("PARTYNAME")
    m16.text=str(data.buyer.name)
    root.append(m16)

    m17=Et.Element("PARTYLEDGERNAME")
    m17.text=str(data.buyer.name)
    root.append(m17)

    m18=Et.Element("BUYERADDRESSTYPE")
    if data.shipto_address_type == 'Default':
        m18.text='Primary'
    else:
        m18.text=data.shipto_address_type
    root.append(m18)

    m19=Et.Element("PARTYMAILINGNAME")
    m19.text=str(data.buyer_mailingname)
    root.append(m19)

    m20=Et.Element("PARTYPINCODE")
    m20.text=data.buyer_pincode
    root.append(m20)

    m21=Et.Element("BILLTOPLACE")
    m21.text=data.buyer_city
    root.append(m21)

    m22=Et.Element("DISPATCHFROMNAME")
    m22.text=data.company.dis_name
    root.append(m22)

    m23=Et.Element("DISPATCHFROMSTATENAME")
    m23.text=data.company.dis_state
    root.append(m23)

    m24=Et.Element("DISPATCHFROMPINCODE")
    m24.text=data.company.dis_pincode
    root.append(m24)

    m25=Et.Element("DISPATCHFROMPLACE")
    m25.text=data.company.dis_city
    root.append(m25)

    m26=Et.Element("SHIPTOPLACE")
    m26.text=data.shipto_city
    root.append(m26)

    m27=Et.Element("CONSIGNEEGSTIN")
    m27.text=data.shipto_gstin
    root.append(m27)

    m28=Et.Element("CONSIGNEEMAILINGNAME")
    m28.text=str(data.shipto_mailingname)
    root.append(m28)

    m29=Et.Element("CONSIGNEEPINCODE")
    m29.text=data.shipto_pincode
    root.append(m29)

    m30=Et.Element("CONSIGNEESTATENAME")
    m30.text=data.shipto_state
    root.append(m30)

    m31=Et.Element("VOUCHERNUMBER")
    m31.text=data.inv_no
    root.append(m31)

    m32=Et.Element("BASICBASEPARTYNAME")
    m32.text=(data.buyer.name)
    root.append(m32)

    m33=Et.Element("PERSISTEDVIEW")
    m33.text="Invoice Voucher View"
    root.append(m33)

    m34=Et.Element("BILLOFLADINGNO")
    m34.text=data.lr_no
    root.append(m34)

    m35=Et.Element("EICHECKPOST")
    m35.text=data.carrier_agent
    root.append(m35)

    m36=Et.Element("BASICSHIPPEDBY")
    m36.text=data.dispatch_through
    root.append(m36)

    m37=Et.Element("BASICBUYERNAME")
    m37.text= str(data.shipto.name)
    root.append(m37)

    m38=Et.Element("BASICSHIPDOCUMENTNO")
    m38.text=data.dispatch_doc_no
    root.append(m38)

    m39=Et.Element("BASICFINALDESTINATION")
    m39.text=data.destination
    root.append(m39)

    m40=Et.Element("BASICORDERREF")
    m40.text=data.order_no
    root.append(m40)

    m41=Et.Element("BASICSHIPVESSELNO")
    m41.text=data.vehical_no
    root.append(m41)

    m42=Et.Element("BASICDUEDATEOFPYMT")
    m42.text=data.mode_of_payment
    root.append(m42)

    m43=Et.Element("CONSIGNEECOUNTRYNAME")
    m43.text=data.shipto_country
    root.append(m43)

    m44=Et.Element("CONSIGNEEPINNUMBER")
    m44.text=data.shipto_pan_no
    root.append(m44)

    m45=Et.Element("VCHENTRYMODE")
    m45.text="Item Invoice"
    root.append(m45)

    m46=Et.Element("VOUCHERTYPEORIGNAME")
    m46.text="Sales"
    root.append(m46)

    m47=Et.Element("ISINVOICE")
    m47.text="Yes"
    root.append(m47)

    m48=Et.Element("ISDELETEDVCHRETAINED")
    m48.text="No"
    root.append(m48)

    m49=Et.Element("EWAYBILLDETAILS.LIST")
    root.append(m49)

    b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    c1.text=data.company.dis_add1 
    
    c21=Et.SubElement(b13,"CONSIGNORADDRESS")
    c21.text=data.company.dis_add2 

    c31=Et.SubElement(b13,"CONSIGNORADDRESS")
    c31.text=data.company.dis_add3 


    b14=Et.SubElement(m49,"CONSIGNEEADDRESS.LIST",{"TYPE":"String"})

    z1=Et.SubElement(m49,"BILLDATE")
    z1.text=data.inv_date.strftime('%Y%m%d')

    c2=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c2.text=data.shipto_address1 + data.shipto_address2

    c23=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c23.text=data.shipto_address3


    b15=Et.SubElement(m49,"DOCUMENTTYPE")
    b15.text="Tax Invoice"

    b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    b16.text=data.shipto_pincode

    b17=Et.SubElement(m49,"SUBTYPE")
    b17.text="Supply"

    b18=Et.SubElement(m49,"CONSIGNORPLACE")
    b18.text=data.company.dis_city

    b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    b19.text=data.company.dis_pincode

    b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    b20.text=data.shipto_city

    b120=Et.SubElement(m49,"CONSIGNORADDRESSTYPE")
    b120.text= "DELIVERY"

    b220=Et.SubElement(m49,"CONSIGNEEADDRESSTYPE")
    
    if data.shipto_address_type == 'Default':
        b220.text = "Primary"
    else:
        b220.text = data.shipto_address_type

    b21=Et.SubElement(m49,"SHIPPEDFROMSTATE")
    b21.text=data.company.dis_state

    b22=Et.SubElement(m49,"SHIPPEDTOSTATE")
    b22.text=data.shipto_state

    b23=Et.SubElement(m49,"TRANSPORTDETAILS.LIST")

    c3=Et.SubElement(b23,"TRANSPORTERID")
    c3.text=data.carrier_agent_id

    c4=Et.SubElement(b23,"TRANSPORTERNAME")
    c4.text=data.carrier_agent

    c5=Et.SubElement(b23,"TRANSPORTMODE")
    c5.text=data.dispatch_through

    c6=Et.SubElement(b23,"VEHICLENUMBER")
    c6.text=data.vehical_no

    c7=Et.SubElement(b23,"VEHICLETYPE")
    c7.text=data.vehical_type

    c8=Et.SubElement(b23,"DISTANCE")
    c8.text=0
    debit = 0
    for item in items:

        m50=Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append(m50)

        b23=Et.SubElement(m50,"STOCKITEMNAME")
        b23.text=str(item.get('item__product_code'))

        b24=Et.SubElement(m50,"ISDEEMEDPOSITIVE")
        b24.text="No"

        b25=Et.SubElement(m50,"RATE")
        b25.text=str(item.get('rate'))

        b26=Et.SubElement(m50,"DISCOUNT")
        b26.text=str(item.get('discount'))

        amount = round(item.get('amount'),2)
        debit += amount
        b27=Et.SubElement(m50,"AMOUNT")
        b27.text= str(amount)

        b28=Et.SubElement(m50,"ACTUALQTY")
        b28.text=str(item.get('actual_qty'))

        b29=Et.SubElement(m50,"BILLEDQTY")
        b29.text=str(item.get('billed_qty'))


        b30=Et.SubElement(m50,"BATCHALLOCATIONS.LIST")

        c9=Et.SubElement(b30,"GODOWNNAME")
        c9.text=str("Primary")

        c10=Et.SubElement(b30,"BATCHNAME")
        c10.text=str(item.get('item__mrp'))

        c11=Et.SubElement(b30,"AMOUNT")
        c11.text = str(amount)

        c12=Et.SubElement(b30,"ACTUALQTY")
        c12.text=str(item.get('actual_qty'))

        c13=Et.SubElement(b30,"BILLEDQTY")
        c13.text=str(item.get('billed_qty'))

        b31=Et.SubElement(m50,"ACCOUNTINGALLOCATIONS.LIST")

        c14=Et.SubElement(b31,"OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})

        d1=Et.SubElement(c14,"OLDAUDITENTRYIDS")
        d1.text='-1'


        c15=Et.SubElement(b31,"LEDGERNAME")
        #c15.text=str(item.get('batch').first().item.dl_sales)
        c15.text="Sales GST"

        c16=Et.SubElement(b31,"AMOUNT")
        c16.text = str(amount)

        b32=Et.SubElement(m50,"EXPENSEALLOCATIONS.LIST")

        c17=Et.SubElement(b32,"LEDGERNAME")
        c17.text="Discount A/C"

        c18=Et.SubElement(b32,"VATASSESSABLEAMOUNT")

        c18.text=str(round(((amount * item.get('discount')) / (100 - item.get('discount'))),2))


    m51=Et.Element("INVOICEDELNOTES.LIST")
    root.append(m51)


    b32=Et.SubElement(m51,"BASICSHIPPINGDATE")
    b32.text=data.inv_date.strftime('%Y%m%d')


    b33=Et.SubElement(m51,"BASICSHIPDELIVERYNOTE")
    b33.text=str(data.dn)

    m52=Et.Element("INVOICEORDERLIST.LIST")
    root.append(m52)

    if data.dn:
        b34=Et.SubElement(m52,"BASICORDERDATE")
        b34.text=data.dn.sales_order.so_date.strftime('%Y%m%d')

        b35=Et.SubElement(m52,"BASICPURCHASEORDERNO")
        if data.order_no:
            b35.text = data.order_no
        else:
            b35.text= data.dn.sales_order.so_no


    m53=Et.Element("LEDGERENTRIES.LIST")
    root.append(m53)


    b36=Et.SubElement(m53,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c19=Et.SubElement(b36,"OLDAUDITENTRYIDS")
    c19.text='-1'

    b37=Et.SubElement(m53,"LEDGERNAME")
    b37.text= data.buyer.name

    b53=Et.SubElement(m53,"ISPARTYLEDGER")
    b53.text= 'Yes'

    b38=Et.SubElement(m53,"AMOUNT")
    b38.text= str(-(data.total))

    b39=Et.SubElement(m53,"BILLALLOCATIONS.LIST")

    c20=Et.SubElement(b39,"NAME")
    c20.text= data.inv_no

    c21=Et.SubElement(b39,"BILLTYPE")
    c21.text="New Ref"

    c22=Et.SubElement(b39,"AMOUNT")
    c22.text= str(-(data.total))
    credit = data.total
    # c23=Et.SubElement(b39,"INTERESTCOLLECTION.LIST")
    # c23.text=""

    # c24=Et.SubElement(b39,"STBILLCATEGORIES.LIST")
    # c24.text=""

    if data.discount > 0:
        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)


        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text= '-1'

        b40=Et.SubElement(m54,"BASICRATEOFINVOICETAX.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"BASICRATEOFINVOICETAX")
        c25.text= str(-data.discount)

        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text="C- Cash Discount"

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="No"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text= str(-round(((data.ammount * data.discount) / 100),2))
        credit += round(((data.ammount * data.discount) / 100),2)

    if data.shipto_state != 'GUJARAT':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="OUTPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="No"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(data.igst)
        debit += data.igst

    else:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)


        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text='-1'

        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="CGST"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="No"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(data.cgst)
        debit += data.cgst


        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)


        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text='-1'


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="SGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="No"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(data.sgst)
        debit += data.sgst

    m57=Et.Element("LEDGERENTRIES.LIST")
    root.append(m57)

    b52=Et.SubElement(m57,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c28=Et.SubElement(b52,"OLDAUDITENTRYIDS")
    c28.text='-1'


    b53=Et.SubElement(m57,"LEDGERNAME")
    b53.text="TCS @ 0.10%"

    b54=Et.SubElement(m57,"ISDEEMEDPOSITIVE")
    b54.text="No"

    b55=Et.SubElement(m57,"AMOUNT")
    b55.text=str(data.tcs)
    debit += data.tcs

    m58=Et.Element("LEDGERENTRIES.LIST")
    root.append(m58)


    b56=Et.SubElement(m58,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c29=Et.SubElement(b56,"OLDAUDITENTRYIDS")
    c29.text='-1'


    b57=Et.SubElement(m58,"LEDGERNAME")
    b57.text="Round Off"

    b58=Et.SubElement(m58,"ISDEEMEDPOSITIVE")
    b58.text="No"

    b59=Et.SubElement(m58,"AMOUNT")
    b59.text= str(credit-debit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str


def cncreator(data, items):


    root = Et.Element("VOUCHER",{"VCHTYPE":"Credit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})


    f1 = Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append (f1)

    g1 = Et.SubElement(f1, "ADDRESS")
    g1.text = data.inv.buyer_address1

    g2 = Et.SubElement(f1, "ADDRESS")
    g2.text = data.inv.buyer_address2

    g53 = Et.SubElement(f1, "ADDRESS")
    g53.text = data.inv.buyer_address3


    f39 = Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append (f39)

    g54 = Et.SubElement(f39,"DISPATCHFROMADDRESS")
    g54.text =  data.company.dis_add1

    g55 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g55.text =  data.company.dis_add2

    g56 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g56.text =  data.company.dis_add3

    f2 = Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append (f2)

    g3 = Et.SubElement(f2,"BASICBUYERADDRESS")
    g3.text = data.inv.shipto_address1

    g4 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g4.text = data.inv.shipto_address2

    g57 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g57.text = data.inv.shipto_address3

    # f40 = Et.Element("BASICORDERTERMS.LIST",{"TYPE":"String"})
    # root.append (f40)

    # g58 = Et.SubElement(f40,"BASICORDERTERMS")
    # g58.text = ""


    f3 = Et.Element("OLDAUDITENTRYIDS.LIST ",{"TYPE":"Number"})
    root.append (f3)

    g5 = Et.SubElement(f3, "OLDAUDITENTRYIDS")
    g5.text = "-1"


    f4 = Et.Element("DATE")
    f4.text = data.cn_date.strftime('%Y%m%d')
    root.append (f4)

    f5 = Et.Element("REFERENCEDATE")
    f5.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f5)

    f41 = Et.Element("VATPARTYTRANSRETURNDATE")
    f41.text = data.cn_date.strftime('%Y%m%d')
    root.append (f41)


    f42 = Et.Element("IRNACKDATE")
    f42.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f42)


    f6 = Et.Element("GUID")
    f6.text = ""
    root.append (f6)

    f7 = Et.Element("GSTREGISTRATIONTYPE")
    f7.text = data.inv.buyer_gst_reg_type
    root.append (f7)

    f8 = Et.Element("VATDEALERTYPE")
    f8.text = "Regular"
    root.append (f8)

    f9 = Et.Element("STATENAME")
    f9.text = data.inv.buyer_state
    root.append (f9)

    f10 = Et.Element("VOUCHERTYPENAME")
    f10.text = "Credit Note"
    root.append (f10)

    f11 = Et.Element("NARRATION")
    f11.text = data.inv.narration
    root.append (f11)

    f12 = Et.Element("ENTEREDBY")
    f12.text = ""
    root.append (f12)

    f13 = Et.Element("COUNTRYOFRESIDENCE")
    f13.text = data.inv.buyer_country
    root.append (f13)

    f14 = Et.Element("PARTYGSTIN")
    f14.text = data.inv.buyer_gstin
    root.append (f14)

    f15 = Et.Element("PLACEOFSUPPLY")
    f15.text = data.inv.destination
    root.append (f15)

    f16 = Et.Element("PARTYNAME")
    f16.text = data.inv.buyer.name
    root.append (f16)

    f17 = Et.Element("PARTYLEDGERNAME")
    f17.text = data.inv.buyer.name
    root.append (f17)

    # f43 = Et.Element("VATPARTYTRANSRETURNNUMBER")
    # f43.text = "DN00005"
    # root.append (f43)

    f44 = Et.Element("GSTNATUREOFRETURN")
    f44.text = "Sales Return"
    root.append (f44)

    f18 = Et.Element("REFERENCE")
    f18.text = str(data.inv.inv_no)
    root.append (f18)

    f19 = Et.Element("PARTYMAILINGNAME")
    f19.text = data.inv.buyer_mailingname
    root.append (f19)

    f20 = Et.Element("PARTYPINCODE")
    f20.text = data.inv.buyer_pincode
    root.append (f20)

    # f45 = Et.Element("IRN")
    # f45.text = ""
    # root.append (f45)

    f46 = Et.Element("BILLTOPLACE")
    f46.text = data.inv.buyer_city
    root.append (f46)

    f48 = Et.Element("DISPATCHFROMNAME")
    f48.text = data.inv.shipto.name
    root.append (f48)

    f49 = Et.Element("DISPATCHFROMSTATENAME")
    f49.text = data.inv.shipto_state
    root.append (f49)

    f50 = Et.Element("DISPATCHFROMPINCODE")
    f50.text = data.inv.shipto_pincode
    root.append (f50)


    f47 = Et.Element("DISPATCHFROMPLACE")
    f47.text = "MANJUSAR"
    root.append (f47)

    f21 = Et.Element("CONSIGNEEGSTIN")
    f21.text = data.inv.shipto_gstin
    root.append (f21)

    f22 = Et.Element("CONSIGNEEMAILINGNAME")
    f22.text = data.inv.shipto_mailingname
    root.append (f22)

    f23 = Et.Element("CONSIGNEEPINCODE")
    f23.text = data.inv.shipto_pan_no
    root.append (f23)

    f24 = Et.Element("CONSIGNEESTATENAME")
    f24.text = data.inv.shipto_state
    root.append (f24)

    f25 = Et.Element("VOUCHERNUMBER")
    f25.text = data.cn_no
    root.append (f25)

    f26 = Et.Element("BASICBASEPARTYNAME")
    f26.text = data.inv.buyer.name
    root.append (f26)

    f27 = Et.Element("PERSISTEDVIEW")
    f27.text = "Invoice Voucher View"
    root.append (f27)

    # f51 = Et.Element("IRNACKNO")
    # f51.text = ""
    # root.append (f51)

    # f52 = Et.Element("IRNQRCODE")
    # f52.text = ""
    # root.append (f52)

    f28 = Et.Element("BASICBUYERNAME")
    f28.text = data.inv.buyer.name
    root.append (f28)

    f53 = Et.Element("BASICDUEDATEOFPYMT")
    f53.text = "1. GOODS RETURNS & Damages"
    root.append (f53)

    f29 = Et.Element("CONSIGNEECOUNTRYNAME")
    f29.text = data.inv.shipto_country
    root.append (f29)

    # f30 = Et.Element("VCHGSTCLASS")
    # f30.text = "VCHGSTCLASS"
    # root.append (f30)

    # f54 = Et.Element("COSTCENTRENAME")
    # f54.text = str(data.inv.buyer.price_level)
    # root.append (f54)

    f31 = Et.Element("VCHENTRYMODE")
    f31.text = "Item Invoice"
    root.append (f31)

    f32 = Et.Element("DIFFACTUALQTY")
    f32.text = "No"
    root.append (f32)

    f33 = Et.Element("EFFECTIVEDATE")
    f33.text = data.cn_date.strftime('%Y%m%d')
    root.append (f33)

    f55 = Et.Element("ALTERID")
    f55.text = "-1"
    root.append (f55)

    # f56 = Et.Element("MASTERID")
    # f56.text = ""
    # root.append (f56)

    f57 = Et.Element("VOUCHERKEY")
    f57.text = ""
    root.append (f57)

    f58 = Et.Element("QRCODECRC")
    f58.text = ""
    root.append (f58)


    m49=Et.Element("EWAYBILLDETAILS.LIST")
    root.append(m49)

    b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    c1.text=data.inv.shipto_address1 + data.inv.shipto_address2
    
    c21=Et.SubElement(b13,"CONSIGNORADDRESS")
    c21.text=data.inv.shipto_address3


    b14=Et.SubElement(m49,"CONSIGNEEADDRESS.LIST",{"TYPE":"String"})

    c2=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c2.text="Plot No. 901/05/10, G.I.D.C. Industrial Estate"

    c23=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c23.text="Makarpura, Vadodara"


    b15=Et.SubElement(m49,"DOCUMENTTYPE")
    b15.text="Tax Invoice"

    b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    b16.text="390010"

    b17=Et.SubElement(m49,"SUBTYPE")
    b17.text="Supply"

    b18=Et.SubElement(m49,"CONSIGNORPLACE")
    b18.text=data.inv.shipto_city

    b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    b19.text=data.inv.shipto_pincode

    b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    b20.text="Vadodara"

    b120=Et.SubElement(m49,"CONSIGNORADDRESSTYPE")
    if data.inv.shipto_address_type == 'Default':
        b120.text=''
    else:
        b120.text=data.inv.shipto_address_type
    debit = 0

    for item in items:
        f59 = Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append (f59)

        # g59 = Et.SubElement(f59, "BASICUSERDESCRIPTION.LIST ",{"Type":"String"})
        # g59.text = "SK10167-2- CDOHP MARKER-BLACK"


        # i24 = Et.SubElement(g59, "BASICUSERDESCRIPTION")
        # i24.text = "SK10167-2- CDOHP MARKER-BLACK"

        g6 = Et.SubElement(f59, "STOCKITEMNAME")
        g6.text = item.item.product_code

        g7 = Et.SubElement(f59, "ISDEEMEDPOSITIVE")
        g7.text = "Yes"


        g8 = Et.SubElement(f59, "ISLASTDEEMEDPOSITIVE")
        g8.text = "Yes"


        g9 = Et.SubElement(f59, "RATE")
        g9.text = str(item.rate)

        debit += item.amount
        g10 = Et.SubElement(f59, "AMOUNT")
        g10.text = str(-(item.amount))

        g110=Et.SubElement(f59,"DISCOUNT")
        g110.text=str(item.discount)

        # g11 = Et.SubElement(f59, "ACTUALQTY")
        # g11.text = str(item.billed_qty)


        g12 = Et.SubElement(f59, "BILLEDQTY")
        g12.text = str(item.billed_qty)


        g13 = Et.SubElement(f59, "BATCHALLOCATIONS.LIST")

        i1 = Et.SubElement(g13, "GODOWNNAME")
        i1.text = "Primary"

        i2 = Et.SubElement(g13, "BATCHNAME")
        i2.text = str(item.item.mrp)

        i3 = Et.SubElement(g13, "DESTINATIONGODOWNNAME")
        i3.text = "Primary"

        i4 = Et.SubElement(g13, "AMOUNT")
        i4.text = str(-(item.amount))


        # i5 = Et.SubElement(g13, "ACTUALQTY")
        # i5.text = str(item.billed_qty)

        i6 = Et.SubElement(g13, "BILLEDQTY")
        i6.text = str(item.billed_qty)

        g14 = Et.SubElement(f59, "ACCOUNTINGALLOCATIONS.LIST")

        i7 = Et.SubElement(g14, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        j1 = Et.SubElement(i7, "OLDAUDITENTRYIDS")
        j1.text = "-1"

        i8 = Et.SubElement(g14, "LEDGERNAME")
        i8.text = "Sales GST"

        i9 = Et.SubElement(g14, "ISDEEMEDPOSITIVE")
        i9.text = "Yes"

        i10 = Et.SubElement(g14, "LEDGERFROMITEM")
        i10.text = "No"

        i11 = Et.SubElement(g14, "ISLASTDEEMEDPOSITIVE")
        i11.text = "Yes"

        i14 = Et.SubElement(g14, "AMOUNT")
        i14.text = str(-(item.amount))


    f35 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f35)

    g15 = Et.SubElement(f35, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i15 = Et.SubElement(g15, "OLDAUDITENTRYIDS")
    i15.text = "-1"

    g16 = Et.SubElement(f35, "LEDGERNAME")
    g16.text = data.inv.buyer.name

    g17 = Et.SubElement(f35, "AMOUNT")
    g17.text = str(data.total)
    credit = data.total

    # g19 = Et.SubElement(f35, "SERVICETAXDETAILS.LIST")

    g21 = Et.SubElement(f35, "BILLALLOCATIONS.LIST")

    i33 = Et.SubElement(g21, "NAME")
    i33.text = data.inv.inv_no

    # i34 = Et.SubElement(g21, "BILLCREDITPERIOD",{"JD":"44538", "P":"30 Days"})
    # i34.text = "30 Days"

    i35 = Et.SubElement(g21, "BILLTYPE")
    i35.text = "Agst Ref"

    i36 = Et.SubElement(g21, "TDSDEDUCTEEISSPECIALRATE")
    i36.text = "No"

    i37 = Et.SubElement(g21, "AMOUNT")
    i37.text = str(data.total)

    if data.discount > 0:

        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)

        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text= '-1'

        b40=Et.SubElement(m54,"BASICRATEOFINVOICETAX.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"BASICRATEOFINVOICETAX")
        c25.text= str(-data.discount)

        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text="C- Cash Discount"

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="Yes"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text= str(round(((data.ammount * data.discount) / 100),2))
        credit += round(((data.ammount * data.discount) / 100),2)

    if data.inv.buyer_gstin and data.inv.buyer_gstin[0:2] != '24':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="OUTPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(-data.igst)
        debit += data.igst

    else:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)


        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text='-1'

        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="CGST"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(-data.cgst)
        debit += data.cgst


        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)


        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text='-1'


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="SGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="Yes"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(-data.sgst)
        debit += data.sgst

    f37 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f37)

    g35 = Et.SubElement(f37, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i22 = Et.SubElement(g35, "OLDAUDITENTRYIDS")
    i22.text = "-1"

    g36 = Et.SubElement(f37, "ROUNDTYPE")
    g36.text = "Normal Rounding"

    g37 = Et.SubElement(f37, "LEDGERNAME")
    g37.text = "Round Off"

    g38 = Et.SubElement(f37, "ISDEEMEDPOSITIVE")
    g38.text = "Yes"

    # g39 = Et.SubElement(f37, "LEDGERFROMITEM")
    # g39.text = "No"

    # g40 = Et.SubElement(f37, "ISPARTYLEDGER")
    # g40.text = "No"

    g41 = Et.SubElement(f37, "ISLASTDEEMEDPOSITIVE")
    g41.text = "Yes"

    # g42 = Et.SubElement(f37, "ROUNDLIMIT")
    # g42.text = "1"

    g43 = Et.SubElement(f37, "AMOUNT")
    g43.text = str((debit - credit))

    xml_str = Et.tostring(root, encoding='unicode') 

    return xml_str


def rsocreator(data, items):

    root = Et.Element("VOUCHER",{"VCHTYPE":"Credit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    f1 = Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append (f1)

    g1 = Et.SubElement(f1, "ADDRESS")
    g1.text = data.inv.buyer_address1

    g2 = Et.SubElement(f1, "ADDRESS")
    g2.text = data.inv.buyer_address2

    g53 = Et.SubElement(f1, "ADDRESS")
    g53.text = data.inv.buyer_address3


    f39 = Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append (f39)

    g54 = Et.SubElement(f39,"DISPATCHFROMADDRESS")
    g54.text =  data.company.dis_add1

    g55 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g55.text =  data.company.dis_add2

    g56 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g56.text =  data.company.dis_add3

    f2 = Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append (f2)

    g3 = Et.SubElement(f2,"BASICBUYERADDRESS")
    g3.text = data.inv.shipto_address1

    g4 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g4.text = data.inv.shipto_address2

    g57 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g57.text = data.inv.shipto_address3

    # f40 = Et.Element("BASICORDERTERMS.LIST",{"TYPE":"String"})
    # root.append (f40)

    # g58 = Et.SubElement(f40,"BASICORDERTERMS")
    # g58.text = "1. GOODS RETURNS & Damages"


    f3 = Et.Element("OLDAUDITENTRYIDS.LIST ",{"TYPE":"Number"})
    root.append (f3)

    g5 = Et.SubElement(f3, "OLDAUDITENTRYIDS")
    g5.text = "-1"


    f4 = Et.Element("DATE")
    f4.text = data.rso_date.strftime('%Y%m%d')
    root.append (f4)

    f5 = Et.Element("REFERENCEDATE")
    f5.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f5)

    f41 = Et.Element("VATPARTYTRANSRETURNDATE")
    f41.text = data.rso_date.strftime('%Y%m%d')
    root.append (f41)


    f42 = Et.Element("IRNACKDATE")
    f42.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f42)


    f6 = Et.Element("GUID")
    f6.text = ""
    root.append (f6)

    f7 = Et.Element("GSTREGISTRATIONTYPE")
    f7.text = data.inv.buyer.gst_registration_type
    root.append (f7)

    f8 = Et.Element("VATDEALERTYPE")
    f8.text = "Regular"
    root.append (f8)

    f9 = Et.Element("STATENAME")
    f9.text = data.inv.buyer_state
    root.append (f9)

    f10 = Et.Element("VOUCHERTYPENAME")
    f10.text = "Credit Note"
    root.append (f10)

    f11 = Et.Element("NARRATION")
    f11.text = data.inv.narration
    root.append (f11)

    f12 = Et.Element("ENTEREDBY")
    f12.text = ""
    root.append (f12)

    f13 = Et.Element("COUNTRYOFRESIDENCE")
    f13.text = data.inv.buyer_country
    root.append (f13)

    f14 = Et.Element("PARTYGSTIN")
    f14.text = data.inv.buyer_gstin
    root.append (f14)

    f15 = Et.Element("PLACEOFSUPPLY")
    f15.text = data.inv.destination
    root.append (f15)

    f16 = Et.Element("PARTYNAME")
    f16.text = data.inv.buyer.name
    root.append (f16)

    f17 = Et.Element("PARTYLEDGERNAME")
    f17.text = data.inv.buyer.name
    root.append (f17)

    # f43 = Et.Element("VATPARTYTRANSRETURNNUMBER")
    # f43.text = "DN00005"
    # root.append (f43)

    f44 = Et.Element("GSTNATUREOFRETURN")
    f44.text = "Sales Return"
    root.append (f44)
    if data.inv.inv_no:
        f18 = Et.Element("REFERENCE")
        f18.text = str(data.inv.inv_no)
        root.append (f18)

    f19 = Et.Element("PARTYMAILINGNAME")
    f19.text = data.inv.buyer_mailingname
    root.append (f19)

    f20 = Et.Element("PARTYPINCODE")
    f20.text = data.inv.buyer_pincode
    root.append (f20)

    f45 = Et.Element("IRN")
    f45.text = ""
    root.append (f45)

    f46 = Et.Element("BILLTOPLACE")
    f46.text = data.inv.buyer_city
    root.append (f46)

    f48 = Et.Element("DISPATCHFROMNAME")
    f48.text = data.inv.shipto.name
    root.append (f48)

    f49 = Et.Element("DISPATCHFROMSTATENAME")
    f49.text = data.inv.shipto_state
    root.append (f49)

    f50 = Et.Element("DISPATCHFROMPINCODE")
    f50.text = data.inv.shipto_pincode
    root.append (f50)


    f47 = Et.Element("DISPATCHFROMPLACE")
    f47.text = "MANJUSAR"
    root.append (f47)

    f21 = Et.Element("CONSIGNEEGSTIN")
    f21.text = data.inv.shipto_gstin
    root.append (f21)

    f22 = Et.Element("CONSIGNEEMAILINGNAME")
    f22.text = data.inv.shipto_mailingname
    root.append (f22)

    f23 = Et.Element("CONSIGNEEPINCODE")
    f23.text = data.inv.shipto_pan_no
    root.append (f23)

    f24 = Et.Element("CONSIGNEESTATENAME")
    f24.text = data.inv.shipto_state
    root.append (f24)

    f25 = Et.Element("VOUCHERNUMBER")
    f25.text = data.rso_no
    root.append (f25)

    f26 = Et.Element("BASICBASEPARTYNAME")
    f26.text = data.inv.buyer.name
    root.append (f26)

    f27 = Et.Element("PERSISTEDVIEW")
    f27.text = "Invoice Voucher View"
    root.append (f27)

    f51 = Et.Element("IRNACKNO")
    f51.text = ""
    root.append (f51)

    f52 = Et.Element("IRNQRCODE")
    f52.text = ""
    root.append (f52)

    f28 = Et.Element("BASICBUYERNAME")
    f28.text = data.inv.buyer.name
    root.append (f28)

    f53 = Et.Element("BASICDUEDATEOFPYMT")
    f53.text = "1. GOODS RETURNS & Damages"
    root.append (f53)

    f29 = Et.Element("CONSIGNEECOUNTRYNAME")
    f29.text = data.inv.shipto_country
    root.append (f29)

    f30 = Et.Element("VCHGSTCLASS")
    f30.text = "VCHGSTCLASS"
    root.append (f30)

    # f54 = Et.Element("COSTCENTRENAME")
    # f54.text = "S-ODISHA"
    # root.append (f54)

    f31 = Et.Element("VCHENTRYMODE")
    f31.text = "Item Invoice"
    root.append (f31)

    f32 = Et.Element("DIFFACTUALQTY")
    f32.text = "Yes"
    root.append (f32)

    f33 = Et.Element("EFFECTIVEDATE")
    f33.text = data.rso_date.strftime('%Y%m%d')
    root.append (f33)

    f55 = Et.Element("ALTERID")
    f55.text = "-1"
    root.append (f55)

    f56 = Et.Element("MASTERID")
    f56.text = ""
    root.append (f56)

    f57 = Et.Element("VOUCHERKEY")
    f57.text = ""
    root.append (f57)

    f58 = Et.Element("QRCODECRC")
    f58.text = ""
    root.append (f58)


    m49=Et.Element("EWAYBILLDETAILS.LIST")
    root.append(m49)

    b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    c1.text=data.inv.shipto_address1 + data.inv.shipto_address2
    
    c21=Et.SubElement(b13,"CONSIGNORADDRESS")
    c21.text=data.inv.shipto_address3


    b14=Et.SubElement(m49,"CONSIGNEEADDRESS.LIST",{"TYPE":"String"})

    c2=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c2.text="Plot No. 901/05/10, G.I.D.C. Industrial Estate"

    c23=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c23.text="Makarpura, Vadodara"


    b15=Et.SubElement(m49,"DOCUMENTTYPE")
    b15.text="Tax Invoice"

    b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    b16.text="390010"

    b17=Et.SubElement(m49,"SUBTYPE")
    b17.text="Supply"

    b18=Et.SubElement(m49,"CONSIGNORPLACE")
    b18.text=data.inv.shipto_city

    b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    b19.text=data.inv.shipto_pincode

    b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    b20.text="Vadodara"

    b120=Et.SubElement(m49,"CONSIGNORADDRESSTYPE")
    if data.inv.shipto_address_type == 'Default':
        b120.text=''
    else:
        b120.text=data.inv.shipto_address_type

    debit = 0
    for item in items:
        f59 = Et.Element("ALLINVENTORYENTRIES.LIST")
        f59.text = ""
        root.append (f59)

        # g59 = Et.SubElement(f59, "BASICUSERDESCRIPTION.LIST ",{"Type":"String"})
        # g59.text = "SK10167-2- CDOHP MARKER-BLACK"


        # i24 = Et.SubElement(g59, "BASICUSERDESCRIPTION")
        # i24.text = "SK10167-2- CDOHP MARKER-BLACK"

        g6 = Et.SubElement(f59, "STOCKITEMNAME")
        g6.text = item.item.product_code

        g7 = Et.SubElement(f59, "ISDEEMEDPOSITIVE")
        g7.text = "Yes"


        g8 = Et.SubElement(f59, "ISLASTDEEMEDPOSITIVE")
        g8.text = "Yes"


        g9 = Et.SubElement(f59, "RATE")
        g9.text = str(item.rate)


        g10 = Et.SubElement(f59, "AMOUNT")
        g10.text = str(-(item.amount))

        debit += item.amount 

        g110=Et.SubElement(f59,"DISCOUNT")
        g110.text=str(item.discount)

        g11 = Et.SubElement(f59, "ACTUALQTY")
        g11.text = str(item.billed_qty + item.free_qty)


        g12 = Et.SubElement(f59, "BILLEDQTY")
        g12.text = str(item.billed_qty)


        g13 = Et.SubElement(f59, "BATCHALLOCATIONS.LIST")

        # i25 = Et.SubElement(g13, "MFDON")
        # i25.text = ""

        i1 = Et.SubElement(g13, "GODOWNNAME")
        i1.text = "Primary"

        i2 = Et.SubElement(g13, "BATCHNAME")
        i2.text = str(item.item.mrp)

        i3 = Et.SubElement(g13, "DESTINATIONGODOWNNAME")
        i3.text = "Primary"

        i4 = Et.SubElement(g13, "AMOUNT")
        i4.text = str(-(item.amount))


        i5 = Et.SubElement(g13, "ACTUALQTY")
        i5.text = str(item.billed_qty + item.free_qty)

        i6 = Et.SubElement(g13, "BILLEDQTY")
        i6.text = str(item.billed_qty)

        g14 = Et.SubElement(f59, "ACCOUNTINGALLOCATIONS.LIST")

        i7 = Et.SubElement(g14, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        j1 = Et.SubElement(i7, "OLDAUDITENTRYIDS")
        j1.text = "-1"

        i8 = Et.SubElement(g14, "LEDGERNAME")
        i8.text = "Sales GST"

        i9 = Et.SubElement(g14, "ISDEEMEDPOSITIVE")
        i9.text = "Yes"

        i10 = Et.SubElement(g14, "LEDGERFROMITEM")
        i10.text = "No"

        i11 = Et.SubElement(g14, "ISLASTDEEMEDPOSITIVE")
        i11.text = "Yes"

        i14 = Et.SubElement(g14, "AMOUNT")
        i14.text = str(-(item.amount))

    f35 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f35)

    g15 = Et.SubElement(f35, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i15 = Et.SubElement(g15, "OLDAUDITENTRYIDS")
    i15.text = "-1"

    g16 = Et.SubElement(f35, "LEDGERNAME")
    g16.text = data.inv.buyer.name

    g17 = Et.SubElement(f35, "AMOUNT")
    g17.text = str(data.total)


    g19 = Et.SubElement(f35, "SERVICETAXDETAILS.LIST")


    g21 = Et.SubElement(f35, "BILLALLOCATIONS.LIST")


    i33 = Et.SubElement(g21, "NAME")
    i33.text = data.inv.inv_no

    i34 = Et.SubElement(g21, "BILLCREDITPERIOD",{"JD":"44538", "P":"30 Days"})
    i34.text = "30 Days"

    i35 = Et.SubElement(g21, "BILLTYPE")
    i35.text = "Agst Ref"

    i36 = Et.SubElement(g21, "TDSDEDUCTEEISSPECIALRATE")
    i36.text = "No"

    i37 = Et.SubElement(g21, "AMOUNT")
    i37.text = str(data.total)
    credit = data.total

    if data.discount > 0:

        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)

        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text= '-1'

        b40=Et.SubElement(m54,"BASICRATEOFINVOICETAX.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"BASICRATEOFINVOICETAX")
        c25.text= str(-data.discount)

        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text="C- Cash Discount"

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="Yes"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text= str(round(((data.ammount * data.discount) / 100),2))
        credit += round(((data.ammount * data.discount) / 100),2)


    if data.inv.buyer.state != 'GUJARAT':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="OUTPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(-data.igst)
        debit += data.igst

    else:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)


        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text='-1'

        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="CGST"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(-data.cgst)
        debit += data.cgst


        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)


        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text='-1'


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="SGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="Yes"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(-data.sgst)
        debit += data.sgst


    f37 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f37)

    g35 = Et.SubElement(f37, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i22 = Et.SubElement(g35, "OLDAUDITENTRYIDS")
    i22.text = "-1"

    g36 = Et.SubElement(f37, "ROUNDTYPE")
    g36.text = "Normal Rounding"

    g37 = Et.SubElement(f37, "LEDGERNAME")
    g37.text = "Round Off"

    g38 = Et.SubElement(f37, "ISDEEMEDPOSITIVE")
    g38.text = "Yes"

    g39 = Et.SubElement(f37, "LEDGERFROMITEM")
    g39.text = "No"

    g40 = Et.SubElement(f37, "ISPARTYLEDGER")
    g40.text = "No"

    g41 = Et.SubElement(f37, "ISLASTDEEMEDPOSITIVE")
    g41.text = "Yes"

    g42 = Et.SubElement(f37, "ROUNDLIMIT")
    g42.text = "1"


    g43 = Et.SubElement(f37, "AMOUNT")
    g43.text = str(debit - credit)


    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str

def qdncreator(data, items):


    root = Et.Element("VOUCHER",{"VCHTYPE":"Credit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    f1 = Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append (f1)

    g1 = Et.SubElement(f1, "ADDRESS")
    g1.text = data.inv.buyer_address1

    g2 = Et.SubElement(f1, "ADDRESS")
    g2.text = data.inv.buyer_address2

    g53 = Et.SubElement(f1, "ADDRESS")
    g53.text = data.inv.buyer_address3


    f39 = Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append (f39)

    g54 = Et.SubElement(f39,"DISPATCHFROMADDRESS")
    g54.text =  data.company.dis_add1

    g55 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g55.text =  data.company.dis_add2

    g56 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g56.text =  data.company.dis_add3

    f2 = Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append (f2)

    g3 = Et.SubElement(f2,"BASICBUYERADDRESS")
    g3.text = data.inv.shipto_address1

    g4 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g4.text = data.inv.shipto_address2

    g57 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g57.text = data.inv.shipto_address3

    f40 = Et.Element("BASICORDERTERMS.LIST",{"TYPE":"String"})
    root.append (f40)

    g58 = Et.SubElement(f40,"BASICORDERTERMS")
    g58.text = "1. GOODS RETURNS & Damages"


    f3 = Et.Element("OLDAUDITENTRYIDS.LIST ",{"TYPE":"Number"})
    root.append (f3)

    g5 = Et.SubElement(f3, "OLDAUDITENTRYIDS")
    g5.text = "-1"


    f4 = Et.Element("DATE")
    f4.text = data.qdn_date.strftime('%Y%m%d')
    root.append (f4)

    f5 = Et.Element("REFERENCEDATE")
    f5.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f5)

    f41 = Et.Element("VATPARTYTRANSRETURNDATE")
    f41.text = data.qdn_date.strftime('%Y%m%d')
    root.append (f41)


    f42 = Et.Element("IRNACKDATE")
    f42.text = data.inv.inv_date.strftime('%Y%m%d')
    root.append (f42)


    f6 = Et.Element("GUID")
    f6.text = ""
    root.append (f6)

    f7 = Et.Element("GSTREGISTRATIONTYPE")
    f7.text = data.inv.buyer_gst_reg_type
    root.append (f7)

    f8 = Et.Element("VATDEALERTYPE")
    f8.text = "Regular"
    root.append (f8)

    f9 = Et.Element("STATENAME")
    f9.text = data.inv.buyer_state
    root.append (f9)

    f10 = Et.Element("VOUCHERTYPENAME")
    f10.text = "Credit Note"
    root.append (f10)

    f11 = Et.Element("NARRATION")
    f11.text = data.inv.narration
    root.append (f11)

    f12 = Et.Element("ENTEREDBY")
    f12.text = ""
    root.append (f12)

    f13 = Et.Element("COUNTRYOFRESIDENCE")
    f13.text = data.inv.buyer_country
    root.append (f13)

    f14 = Et.Element("PARTYGSTIN")
    f14.text = data.inv.buyer_gstin
    root.append (f14)

    f15 = Et.Element("PLACEOFSUPPLY")
    f15.text = data.inv.destination
    root.append (f15)

    f16 = Et.Element("PARTYNAME")
    f16.text = data.inv.buyer.name
    root.append (f16)

    f17 = Et.Element("PARTYLEDGERNAME")
    f17.text = data.inv.buyer.name
    root.append (f17)

    # f43 = Et.Element("VATPARTYTRANSRETURNNUMBER")
    # f43.text = "DN00005"
    # root.append (f43)

    f44 = Et.Element("GSTNATUREOFRETURN")
    f44.text = "Sales Return"
    root.append (f44)

    f18 = Et.Element("REFERENCE")
    f18.text = str(data.inv.inv_no)
    root.append (f18)

    f19 = Et.Element("PARTYMAILINGNAME")
    f19.text = data.inv.buyer_mailingname
    root.append (f19)

    f20 = Et.Element("PARTYPINCODE")
    f20.text = data.inv.buyer_pincode
    root.append (f20)

    f45 = Et.Element("IRN")
    f45.text = ""
    root.append (f45)

    f46 = Et.Element("BILLTOPLACE")
    f46.text = data.inv.buyer_city
    root.append (f46)

    f48 = Et.Element("DISPATCHFROMNAME")
    f48.text = data.inv.shipto.name
    root.append (f48)

    f49 = Et.Element("DISPATCHFROMSTATENAME")
    f49.text = data.inv.shipto_state
    root.append (f49)

    f50 = Et.Element("DISPATCHFROMPINCODE")
    f50.text = data.inv.shipto_pincode
    root.append (f50)


    f47 = Et.Element("DISPATCHFROMPLACE")
    f47.text = "MANJUSAR"
    root.append (f47)

    f21 = Et.Element("CONSIGNEEGSTIN")
    f21.text = data.inv.shipto_gstin
    root.append (f21)

    f22 = Et.Element("CONSIGNEEMAILINGNAME")
    f22.text = data.inv.shipto_mailingname
    root.append (f22)

    f23 = Et.Element("CONSIGNEEPINCODE")
    f23.text = data.inv.shipto_pan_no
    root.append (f23)

    f24 = Et.Element("CONSIGNEESTATENAME")
    f24.text = data.inv.shipto_state
    root.append (f24)

    f25 = Et.Element("VOUCHERNUMBER")
    f25.text = data.qdn_no
    root.append (f25)

    f26 = Et.Element("BASICBASEPARTYNAME")
    f26.text = data.inv.buyer.name
    root.append (f26)

    f27 = Et.Element("PERSISTEDVIEW")
    f27.text = "Invoice Voucher View"
    root.append (f27)

    f51 = Et.Element("IRNACKNO")
    f51.text = ""
    root.append (f51)

    f52 = Et.Element("IRNQRCODE")
    f52.text = ""
    root.append (f52)

    f28 = Et.Element("BASICBUYERNAME")
    f28.text = data.inv.buyer.name
    root.append (f28)

    f53 = Et.Element("BASICDUEDATEOFPYMT")
    f53.text = "1. GOODS RETURNS & Damages"
    root.append (f53)

    f29 = Et.Element("CONSIGNEECOUNTRYNAME")
    f29.text = data.inv.shipto_country
    root.append (f29)

    f30 = Et.Element("VCHGSTCLASS")
    f30.text = "VCHGSTCLASS"
    root.append (f30)

    # f54 = Et.Element("COSTCENTRENAME")
    # f54.text = "S-ODISHA"
    # root.append (f54)

    f31 = Et.Element("VCHENTRYMODE")
    f31.text = "Item Invoice"
    root.append (f31)

    f32 = Et.Element("DIFFACTUALQTY")
    f32.text = "Yes"
    root.append (f32)

    f33 = Et.Element("EFFECTIVEDATE")
    f33.text = data.qdn_date.strftime('%Y%m%d')
    root.append (f33)

    f55 = Et.Element("ALTERID")
    f55.text = "-1"
    root.append (f55)

    f56 = Et.Element("MASTERID")
    f56.text = ""
    root.append (f56)

    f57 = Et.Element("VOUCHERKEY")
    f57.text = ""
    root.append (f57)

    f58 = Et.Element("QRCODECRC")
    f58.text = ""
    root.append (f58)

    m49=Et.Element("EWAYBILLDETAILS.LIST")
    root.append(m49)

    b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    c1.text=data.inv.shipto_address1 + data.inv.shipto_address2
    
    c21=Et.SubElement(b13,"CONSIGNORADDRESS")
    c21.text=data.inv.shipto_address3


    b14=Et.SubElement(m49,"CONSIGNEEADDRESS.LIST",{"TYPE":"String"})

    c2=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c2.text="Plot No. 901/05/10, G.I.D.C. Industrial Estate"

    c23=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c23.text="Makarpura, Vadodara"


    b15=Et.SubElement(m49,"DOCUMENTTYPE")
    b15.text="Tax Invoice"

    b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    b16.text="390010"

    b17=Et.SubElement(m49,"SUBTYPE")
    b17.text="Supply"

    b18=Et.SubElement(m49,"CONSIGNORPLACE")
    b18.text=data.inv.shipto_city

    b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    b19.text=data.inv.shipto_pincode

    b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    b20.text="Vadodara"
    
    b120=Et.SubElement(m49,"CONSIGNORADDRESSTYPE")
    if data.inv.shipto_address_type == 'Default':
        b120.text=''
    else:
        b120.text=data.inv.shipto_address_type

    debit = 0
    for item in items:
        f59 = Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append (f59)

        # g59 = Et.SubElement(f59, "BASICUSERDESCRIPTION.LIST ",{"Type":"String"})
        # g59.text = "SK10167-2- CDOHP MARKER-BLACK"


        # i24 = Et.SubElement(g59, "BASICUSERDESCRIPTION")
        # i24.text = "SK10167-2- CDOHP MARKER-BLACK"

        g6 = Et.SubElement(f59, "STOCKITEMNAME")
        g6.text = item.item.product_code

        g7 = Et.SubElement(f59, "ISDEEMEDPOSITIVE")
        g7.text = "Yes"


        g8 = Et.SubElement(f59, "ISLASTDEEMEDPOSITIVE")
        g8.text = "Yes"


        g9 = Et.SubElement(f59, "RATE")
        g9.text = str(item.rate)


        g10 = Et.SubElement(f59, "AMOUNT")
        g10.text = str(-(item.amount))

        g110=Et.SubElement(f59,"DISCOUNT")
        g110.text=str(item.discount)

        debit +=item.amount

        g11 = Et.SubElement(f59, "ACTUALQTY")
        g11.text = str(item.billed_qty + item.free_qty)


        g12 = Et.SubElement(f59, "BILLEDQTY")
        g12.text = str(item.billed_qty)


        g13 = Et.SubElement(f59, "BATCHALLOCATIONS.LIST")

        # i25 = Et.SubElement(g13, "MFDON")
        # i25.text = ""

        i1 = Et.SubElement(g13, "GODOWNNAME")
        i1.text = "Primary"

        i2 = Et.SubElement(g13, "BATCHNAME")
        i2.text = str(item.item.mrp)

        i3 = Et.SubElement(g13, "DESTINATIONGODOWNNAME")
        i3.text = "Primary"

        i4 = Et.SubElement(g13, "AMOUNT")
        i4.text = str(-(item.amount))


        i5 = Et.SubElement(g13, "ACTUALQTY")
        i5.text = str(item.billed_qty + item.free_qty)

        i6 = Et.SubElement(g13, "BILLEDQTY")
        i6.text = str(item.billed_qty)

        g14 = Et.SubElement(f59, "ACCOUNTINGALLOCATIONS.LIST")
        g14.text = ""

        i7 = Et.SubElement(g14, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})
        i7.text = ""

        j1 = Et.SubElement(i7, "OLDAUDITENTRYIDS")
        j1.text = "-1"

        i8 = Et.SubElement(g14, "LEDGERNAME")
        i8.text = "Sales GST"

        i9 = Et.SubElement(g14, "ISDEEMEDPOSITIVE")
        i9.text = "Yes"

        i10 = Et.SubElement(g14, "LEDGERFROMITEM")
        i10.text = "No"

        i11 = Et.SubElement(g14, "ISLASTDEEMEDPOSITIVE")
        i11.text = "Yes"

        i14 = Et.SubElement(g14, "AMOUNT")
        i14.text = str(-(item.amount))


    f35 = Et.Element("LEDGERENTRIES.LIST")
    f35.text = ""
    root.append (f35)

    g15 = Et.SubElement(f35, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})
    g15.text = ""

    i15 = Et.SubElement(g15, "OLDAUDITENTRYIDS")
    i15.text = "-1"

    g16 = Et.SubElement(f35, "LEDGERNAME")
    g16.text = data.inv.buyer.name

    g17 = Et.SubElement(f35, "AMOUNT")
    g17.text = str(data.total)


    # g19 = Et.SubElement(f35, "SERVICETAXDETAILS.LIST")
    # g19.text = ""

    g21 = Et.SubElement(f35, "BILLALLOCATIONS.LIST")

    i33 = Et.SubElement(g21, "NAME")
    i33.text = data.inv.inv_no

    i34 = Et.SubElement(g21, "BILLCREDITPERIOD",{"JD":"44538", "P":"30 Days"})
    i34.text = "30 Days"

    i35 = Et.SubElement(g21, "BILLTYPE")
    i35.text = "Agst Ref"

    i36 = Et.SubElement(g21, "TDSDEDUCTEEISSPECIALRATE")
    i36.text = "No"

    i37 = Et.SubElement(g21, "AMOUNT")
    i37.text = str(data.total)
    credit = data.total

    if data.discount > 0:

        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)

        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text= '-1'

        b40=Et.SubElement(m54,"BASICRATEOFINVOICETAX.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"BASICRATEOFINVOICETAX")
        c25.text= str(-data.discount)

        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text="C- Cash Discount"

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="Yes"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text= str(round(((data.ammount * data.discount) / 100),2))
        credit += round(((data.ammount * data.discount) / 100),2)

    if data.inv.buyer_gstin and data.inv.buyer_gstin[0:2] != '24':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="OUTPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(-data.igst)
        debit += data.igst

    else:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)


        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text='-1'

        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="CGST"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(-data.cgst)
        debit += data.cgst


        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)


        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text='-1'


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="SGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="Yes"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(-data.sgst)
        debit += data.sgst

    f37 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f37)

    g35 = Et.SubElement(f37, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i22 = Et.SubElement(g35, "OLDAUDITENTRYIDS")
    i22.text = "-1"

    g36 = Et.SubElement(f37, "ROUNDTYPE")
    g36.text = "Normal Rounding"

    g37 = Et.SubElement(f37, "LEDGERNAME")
    g37.text = "Round Off"

    g38 = Et.SubElement(f37, "ISDEEMEDPOSITIVE")
    g38.text = "Yes"

    g39 = Et.SubElement(f37, "LEDGERFROMITEM")
    g39.text = "No"

    g40 = Et.SubElement(f37, "ISPARTYLEDGER")
    g40.text = "No"

    g41 = Et.SubElement(f37, "ISLASTDEEMEDPOSITIVE")
    g41.text = "Yes"

    g42 = Et.SubElement(f37, "ROUNDLIMIT")
    g42.text = "1"

    g43 = Et.SubElement(f37, "AMOUNT")
    g43.text = str(debit-credit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str


def creditmemocreator(data, items):

    root = Et.Element("VOUCHER",{"VCHTYPE":"Credit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    f1 = Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append (f1)

    g1 = Et.SubElement(f1, "ADDRESS")
    g1.text = data.buyer_address1

    g2 = Et.SubElement(f1, "ADDRESS")
    g2.text = data.buyer_address2

    g53 = Et.SubElement(f1, "ADDRESS")
    g53.text = data.buyer_address3


    f39 = Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append (f39)

    g54 = Et.SubElement(f39,"DISPATCHFROMADDRESS")
    g54.text =  data.company.dis_add1

    g55 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g55.text =  data.company.dis_add2

    g56 = Et.SubElement(f39, "DISPATCHFROMADDRESS")
    g56.text =  data.company.dis_add3

    f2 = Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append (f2)

    g3 = Et.SubElement(f2,"BASICBUYERADDRESS")
    g3.text = data.buyer_address1

    g4 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g4.text = data.buyer_address2

    g57 = Et.SubElement(f2, "BASICBUYERADDRESS")
    g57.text = data.buyer_address3

    f40 = Et.Element("BASICORDERTERMS.LIST",{"TYPE":"String"})
    root.append (f40)

    # g58 = Et.SubElement(f40,"BASICORDERTERMS")
    # g58.text = "1. GOODS RETURNS & Damages"


    f3 = Et.Element("OLDAUDITENTRYIDS.LIST ",{"TYPE":"Number"})
    root.append (f3)

    g5 = Et.SubElement(f3, "OLDAUDITENTRYIDS")
    g5.text = "-1"

    f4 = Et.Element("DATE")
    f4.text = data.rso_date.strftime('%Y%m%d')
    root.append (f4)

    if data.ref_date:
        f5 = Et.Element("REFERENCEDATE")
        f5.text = data.ref_date.strftime('%Y%m%d')
        root.append (f5)

    f41 = Et.Element("VATPARTYTRANSRETURNDATE")
    f41.text = data.rso_date.strftime('%Y%m%d')
    root.append (f41)


    # f42 = Et.Element("IRNACKDATE")
    # f42.text = data.inv.inv_date.strftime('%Y%m%d')
    # root.append (f42)


    f6 = Et.Element("GUID")
    f6.text = ""
    root.append (f6)

    f7 = Et.Element("GSTREGISTRATIONTYPE")
    f7.text = data.buyer_gst_reg_type
    root.append (f7)

    f8 = Et.Element("VATDEALERTYPE")
    f8.text = "Regular"
    root.append (f8)

    f9 = Et.Element("STATENAME")
    f9.text = data.buyer_state
    root.append (f9)

    f10 = Et.Element("VOUCHERTYPENAME")
    f10.text = "Credit Note"
    root.append (f10)

    f11 = Et.Element("NARRATION")
    f11.text = data.narration
    root.append (f11)

    f12 = Et.Element("ENTEREDBY")
    f12.text = ""
    root.append (f12)

    f13 = Et.Element("COUNTRYOFRESIDENCE")
    f13.text = data.buyer_country
    root.append (f13)

    f14 = Et.Element("PARTYGSTIN")
    f14.text = data.buyer_gstin
    root.append (f14)

    f15 = Et.Element("PLACEOFSUPPLY")
    f15.text = data.buyer_state
    root.append (f15)

    f16 = Et.Element("PARTYNAME")
    f16.text = data.buyer.name
    root.append (f16)

    f17 = Et.Element("PARTYLEDGERNAME")
    f17.text = data.buyer.name
    root.append (f17)

    # f43 = Et.Element("VATPARTYTRANSRETURNNUMBER")
    # f43.text = "DN00005"
    # root.append (f43)

    f44 = Et.Element("GSTNATUREOFRETURN")
    f44.text = "Sales Return"
    root.append (f44)
    f18 = Et.Element("REFERENCE")
    f18.text = str(data.rso_ref)
    root.append (f18)

    f19 = Et.Element("PARTYMAILINGNAME")
    f19.text = data.buyer_mailingname
    root.append (f19)

    f20 = Et.Element("PARTYPINCODE")
    f20.text = data.buyer_pincode
    root.append (f20)

    f45 = Et.Element("IRN")
    f45.text = ""
    root.append (f45)

    f46 = Et.Element("BILLTOPLACE")
    f46.text = data.buyer_city
    root.append (f46)

    f48 = Et.Element("DISPATCHFROMNAME")
    f48.text = data.buyer.name
    root.append (f48)

    f49 = Et.Element("DISPATCHFROMSTATENAME")
    f49.text = data.buyer_state
    root.append (f49)

    f50 = Et.Element("DISPATCHFROMPINCODE")
    f50.text = data.buyer_pincode
    root.append (f50)


    f47 = Et.Element("DISPATCHFROMPLACE")
    f47.text = "MANJUSAR"
    root.append (f47)

    f21 = Et.Element("CONSIGNEEGSTIN")
    f21.text = data.buyer_gstin
    root.append (f21)

    f22 = Et.Element("CONSIGNEEMAILINGNAME")
    f22.text = data.buyer_mailingname
    root.append (f22)

    f23 = Et.Element("CONSIGNEEPINCODE")
    f23.text = data.buyer_pincode
    root.append (f23)

    f24 = Et.Element("CONSIGNEESTATENAME")
    f24.text = data.buyer_state
    root.append (f24)

    f25 = Et.Element("VOUCHERNUMBER")
    f25.text = data.rso_no
    root.append (f25)

    f26 = Et.Element("BASICBASEPARTYNAME")
    f26.text = data.buyer.name
    root.append (f26)

    f27 = Et.Element("PERSISTEDVIEW")
    f27.text = "Invoice Voucher View"
    root.append (f27)

    f51 = Et.Element("IRNACKNO")
    f51.text = ""
    root.append (f51)

    f52 = Et.Element("IRNQRCODE")
    f52.text = ""
    root.append (f52)

    f28 = Et.Element("BASICBUYERNAME")
    f28.text = data.buyer.name
    root.append (f28)

    f53 = Et.Element("BASICDUEDATEOFPYMT")
    f53.text = "1. GOODS RETURNS & Damages"
    root.append (f53)

    f29 = Et.Element("CONSIGNEECOUNTRYNAME")
    f29.text = data.buyer_country
    root.append (f29)

    f30 = Et.Element("VCHGSTCLASS")
    f30.text = "VCHGSTCLASS"
    root.append (f30)

    # f54 = Et.Element("COSTCENTRENAME")
    # f54.text = "S-ODISHA"
    # root.append (f54)

    f31 = Et.Element("VCHENTRYMODE")
    f31.text = "Item Invoice"
    root.append (f31)

    f32 = Et.Element("DIFFACTUALQTY")
    f32.text = "Yes"
    root.append (f32)

    f33 = Et.Element("EFFECTIVEDATE")
    f33.text = data.rso_date.strftime('%Y%m%d')
    root.append (f33)

    f55 = Et.Element("ALTERID")
    f55.text = "-1"
    root.append (f55)

    f56 = Et.Element("MASTERID")
    f56.text = ""
    root.append (f56)

    f57 = Et.Element("VOUCHERKEY")
    f57.text = ""
    root.append (f57)

    f58 = Et.Element("QRCODECRC")
    f58.text = ""
    root.append (f58)


    m49=Et.Element("EWAYBILLDETAILS.LIST")
    root.append(m49)

    b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    c1.text=data.buyer_address1 + data.buyer_address2
    
    c21=Et.SubElement(b13,"CONSIGNORADDRESS")
    c21.text=data.buyer_address3


    b14=Et.SubElement(m49,"CONSIGNEEADDRESS.LIST",{"TYPE":"String"})

    c2=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c2.text="Plot No. 901/05/10, G.I.D.C. Industrial Estate"

    c23=Et.SubElement(b14,"CONSIGNEEADDRESS")
    c23.text="Makarpura, Vadodara"


    b15=Et.SubElement(m49,"DOCUMENTTYPE")
    b15.text="Tax Invoice"

    b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    b16.text="390010"

    b17=Et.SubElement(m49,"SUBTYPE")
    b17.text="Supply"

    b18=Et.SubElement(m49,"CONSIGNORPLACE")
    b18.text=data.buyer_city

    b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    b19.text=data.buyer_pincode

    b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    b20.text="Vadodara"

    b120=Et.SubElement(m49,"CONSIGNORADDRESSTYPE")
    if data.buyer_address_type == 'Default':
        b120.text=''
    else:
        b120.text=data.buyer_address_type

    debit = 0
    for item in items:
        f59 = Et.Element("ALLINVENTORYENTRIES.LIST")
        f59.text = ""
        root.append (f59)

        # g59 = Et.SubElement(f59, "BASICUSERDESCRIPTION.LIST ",{"Type":"String"})
        # g59.text = "SK10167-2- CDOHP MARKER-BLACK"


        # i24 = Et.SubElement(g59, "BASICUSERDESCRIPTION")
        # i24.text = "SK10167-2- CDOHP MARKER-BLACK"

        g6 = Et.SubElement(f59, "STOCKITEMNAME")
        g6.text = item.item.product_code

        g7 = Et.SubElement(f59, "ISDEEMEDPOSITIVE")
        g7.text = "Yes"


        g8 = Et.SubElement(f59, "ISLASTDEEMEDPOSITIVE")
        g8.text = "Yes"


        g9 = Et.SubElement(f59, "RATE")
        g9.text = str(item.rate)


        g10 = Et.SubElement(f59, "AMOUNT")
        g10.text = str(-(item.amount))

        debit += item.amount 

        g110=Et.SubElement(f59,"DISCOUNT")
        g110.text=str(item.discount)

        g11 = Et.SubElement(f59, "ACTUALQTY")
        g11.text = str(item.billed_qty + item.free_qty)


        g12 = Et.SubElement(f59, "BILLEDQTY")
        g12.text = str(item.billed_qty)


        g13 = Et.SubElement(f59, "BATCHALLOCATIONS.LIST")

        # i25 = Et.SubElement(g13, "MFDON")
        # i25.text = ""

        i1 = Et.SubElement(g13, "GODOWNNAME")
        i1.text = "Primary"

        i2 = Et.SubElement(g13, "BATCHNAME")
        i2.text = str(item.item.mrp)

        i3 = Et.SubElement(g13, "DESTINATIONGODOWNNAME")
        i3.text = "Primary"

        i4 = Et.SubElement(g13, "AMOUNT")
        i4.text = str(-(item.amount))


        i5 = Et.SubElement(g13, "ACTUALQTY")
        i5.text = str(item.billed_qty + item.free_qty)

        i6 = Et.SubElement(g13, "BILLEDQTY")
        i6.text = str(item.billed_qty)

        g14 = Et.SubElement(f59, "ACCOUNTINGALLOCATIONS.LIST")

        i7 = Et.SubElement(g14, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        j1 = Et.SubElement(i7, "OLDAUDITENTRYIDS")
        j1.text = "-1"

        i8 = Et.SubElement(g14, "LEDGERNAME")
        i8.text = "Sales GST"

        i9 = Et.SubElement(g14, "ISDEEMEDPOSITIVE")
        i9.text = "Yes"

        i10 = Et.SubElement(g14, "LEDGERFROMITEM")
        i10.text = "No"

        i11 = Et.SubElement(g14, "ISLASTDEEMEDPOSITIVE")
        i11.text = "Yes"

        i14 = Et.SubElement(g14, "AMOUNT")
        i14.text = str(-(item.amount))

    f35 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f35)

    g15 = Et.SubElement(f35, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i15 = Et.SubElement(g15, "OLDAUDITENTRYIDS")
    i15.text = "-1"

    g16 = Et.SubElement(f35, "LEDGERNAME")
    g16.text = data.buyer.name

    g17 = Et.SubElement(f35, "AMOUNT")
    g17.text = str(data.total)


    g19 = Et.SubElement(f35, "SERVICETAXDETAILS.LIST")


    g21 = Et.SubElement(f35, "BILLALLOCATIONS.LIST")


    i33 = Et.SubElement(g21, "NAME")
    i33.text = data.buyer.name

    i34 = Et.SubElement(g21, "BILLCREDITPERIOD",{"JD":"44538", "P":"30 Days"})
    i34.text = "30 Days"

    i35 = Et.SubElement(g21, "BILLTYPE")
    i35.text = "Agst Ref"

    i36 = Et.SubElement(g21, "TDSDEDUCTEEISSPECIALRATE")
    i36.text = "No"

    i37 = Et.SubElement(g21, "AMOUNT")
    i37.text = str(data.total)
    credit = data.total

    if data.discount > 0:

        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)

        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text= '-1'

        b40=Et.SubElement(m54,"BASICRATEOFINVOICETAX.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"BASICRATEOFINVOICETAX")
        c25.text= str(-data.discount)

        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text="C- Cash Discount"

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="Yes"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text= str(round(((data.ammount * data.discount) / 100),2))
        credit += round(((data.ammount * data.discount) / 100),2)


    if data.buyer_gstin and data.buyer_gstin[0:2] != '24':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="OUTPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(-data.igst)
        debit += data.igst

    else:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)


        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text='-1'

        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="CGST"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(-data.cgst)
        debit += data.cgst


        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)


        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text='-1'


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="SGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="Yes"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(-data.sgst)
        debit += data.sgst


    f37 = Et.Element("LEDGERENTRIES.LIST")
    root.append (f37)

    g35 = Et.SubElement(f37, "OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    i22 = Et.SubElement(g35, "OLDAUDITENTRYIDS")
    i22.text = "-1"

    g36 = Et.SubElement(f37, "ROUNDTYPE")
    g36.text = "Normal Rounding"

    g37 = Et.SubElement(f37, "LEDGERNAME")
    g37.text = "Round Off"

    g38 = Et.SubElement(f37, "ISDEEMEDPOSITIVE")
    g38.text = "Yes"

    g39 = Et.SubElement(f37, "LEDGERFROMITEM")
    g39.text = "No"

    g40 = Et.SubElement(f37, "ISPARTYLEDGER")
    g40.text = "No"

    g41 = Et.SubElement(f37, "ISLASTDEEMEDPOSITIVE")
    g41.text = "Yes"

    g42 = Et.SubElement(f37, "ROUNDLIMIT")
    g42.text = "1"


    g43 = Et.SubElement(f37, "AMOUNT")
    g43.text = str(debit - credit)


    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str