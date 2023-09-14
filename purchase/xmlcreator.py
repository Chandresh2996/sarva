from decimal import Decimal
import xml.etree.ElementTree as Et


#----------------------------------------------------------------------------------------------- Purchase XML

def purchasexml(data, items):
    #Purchase
# "REMOTEID":"e20c8366-3352-44fd-ab5b-f697e4b53794-00016d1b"
    root=Et.Element("VOUCHER",{"VCHTYPE":"Purchase","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    m1=Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append(m1)

    b1=Et.SubElement(m1,"ADDRESS")
    b1.text=data.seller_address1

    b2=Et.SubElement(m1,"ADDRESS")
    b2.text=data.seller_address2

    b3=Et.SubElement(m1,"ADDRESS")
    b3.text=data.seller_address3


    m2=Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    root.append(m2)

    b5=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b5.text=data.seller_address1

    b6=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b6.text=data.seller_address2

    b7=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    b7.text=data.seller_address3

    m3=Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append(m3)

    b8=Et.SubElement(m3,"BASICBUYERADDRESS")
    b8.text=data.shipto_address1

    b9=Et.SubElement(m3,"BASICBUYERADDRESS")
    b9.text=data.shipto_address2

    b10=Et.SubElement(m3,"BASICBUYERADDRESS")
    b10.text=data.shipto_address3

    m4=Et.Element("BASICORDERTERMS.LIST ",{"TYPE":"String"})
    root.append(m4)

    b11=Et.SubElement(m4,"BASICORDERTERMS")
    b11.text=data.terms_of_delivery

    m5=Et.Element("OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})
    root.append(m5)


    b12=Et.SubElement(m5,"OLDAUDITENTRYIDS")
    b12.text="OLDAUDITENTRYIDS"

    m6=Et.Element("DATE")
    m6.text=data.created.strftime('%Y%m%d')
    root.append(m6)

    m7=Et.Element("BILLOFLADINGDATE")
    m7.text=data.created.strftime('%Y%m%d')
    root.append(m7)

    m8=Et.Element("GUID")
    m8.text=str(data.pk)
    root.append(m8)

    m9=Et.Element("GSTREGISTRATIONTYPE")
    m9.text=data.seller_gst_reg_type
    root.append(m9)

    m10=Et.Element("STATENAME")
    m10.text=data.seller_state
    root.append(m10)

    m11=Et.Element("VOUCHERTYPENAME")
    m11.text="Purchase"
    root.append(m11)

    m12=Et.Element("OBJECTUPDATEACTION")
    m12.text="Create"
    root.append(m12)

    m13=Et.Element("COUNTRYOFRESIDENCE")
    m13.text=data.seller_country
    root.append(m13)

    m14=Et.Element("PARTYGSTIN")
    m14.text=data.seller_gstin
    root.append(m14)

    m15=Et.Element("PLACEOFSUPPLY")
    m15.text=data.seller_city
    root.append(m15)

    m16=Et.Element("PARTYNAME")
    m16.text=data.seller.name
    root.append(m16)

    m17=Et.Element("PARTYLEDGERNAME")
    m17.text=data.seller.name
    root.append(m17)

    m18=Et.Element("BUYERADDRESSTYPE")
    m18.text="Stone DELIVERY"
    root.append(m18)

    m19=Et.Element("PARTYMAILINGNAME")
    m19.text=data.seller_mailingname
    root.append(m19)

    m20=Et.Element("PARTYPINCODE")
    m20.text=data.seller_pincode
    root.append(m20)

    m21=Et.Element("BILLTOPLACE")
    m21.text=data.shipto_city
    root.append(m21)

    m22=Et.Element("DISPATCHFROMNAME")
    m22.text="DISPATCHFROMNAME"
    root.append(m22)

    m23=Et.Element("DISPATCHFROMSTATENAME")
    m23.text=data.seller_mailingname
    root.append(m23)

    m24=Et.Element("DISPATCHFROMPINCODE")
    m24.text=data.seller_pincode
    root.append(m24)

    m25=Et.Element("DISPATCHFROMPLACE")
    m25.text=data.seller_city
    root.append(m25)

    m26=Et.Element("SHIPTOPLACE")
    m26.text=data.shipto_city
    root.append(m26)

    m27=Et.Element("CONSIGNEEGSTIN")
    m27.text=data.shipto_gstin
    root.append(m27)

    m28=Et.Element("CONSIGNEEMAILINGNAME")
    m28.text=data.shipto_mailingname
    root.append(m28)

    m29=Et.Element("CONSIGNEEPINCODE")
    m29.text=data.shipto_pincode
    root.append(m29)

    m30=Et.Element("CONSIGNEESTATENAME")
    m30.text=data.shipto_state
    root.append(m30)

    m31=Et.Element("VOUCHERNUMBER")
    m31.text=data.pi_no
    root.append(m31)

    m131=Et.Element("REFERENCEDATE")
    m131.text=data.supplier_date.strftime('%Y%m%d')
    root.append(m131)

    m131=Et.Element("REFERENCE")
    m131.text=data.supplier_invoice
    root.append(m131)

    m32=Et.Element("BASICBASEPARTYNAME")
    m32.text=data.seller.name
    root.append(m32)

    m33=Et.Element("PERSISTEDVIEW")
    m33.text="Invoice Voucher View"
    root.append(m33)

    # m34=Et.Element("BILLOFLADINGNO")
    # m34.text="BILLOFLADINGNO"
    # root.append(m34)

    # m35=Et.Element("EICHECKPOST")
    # m35.text="EICHECKPOST"
    # root.append(m35)

    # m36=Et.Element("BASICSHIPPEDBY")
    # m36.text=data.dispatch_through
    # root.append(m36)

    m37=Et.Element("BASICBUYERNAME")
    m37.text=data.shipto.name
    root.append(m37)

    # m38=Et.Element("BASICSHIPDOCUMENTNO")
    # m38.text=data.pi_no
    # root.append(m38)

    # m39=Et.Element("BASICFINALDESTINATION")
    # m39.text=data.shipto_city
    # root.append(m39)

    # m40=Et.Element("BASICORDERREF")
    # m40.text=data.other_reference
    # root.append(m40)

    # m41=Et.Element("BASICSHIPVESSELNO")
    # m41.text=""
    # root.append(m41)

    # m42=Et.Element("BASICDUEDATEOFPYMT")
    # m42.text=""
    # root.append(m42)

    m43=Et.Element("CONSIGNEECOUNTRYNAME")
    m43.text=data.shipto_country
    root.append(m43)

    m44=Et.Element("CONSIGNEEPINNUMBER")
    m44.text=data.shipto_pan_no
    root.append(m44)

    m45=Et.Element("VCHENTRYMODE")
    m45.text="Item Invoice"
    root.append(m45)

    # m46=Et.Element("VOUCHERTYPEORIGNAME")
    # m46.text="VOUCHERTYPEORIGNAME"
    # root.append(m46)

    m47=Et.Element("ISINVOICE")
    m47.text="yes"
    root.append(m47)

    m48=Et.Element("ISDELETEDVCHRETAINED")
    m48.text="NO"
    root.append(m48)

    # m49=Et.Element("EWAYBILLDETAILS.LIST")
    # root.append(m49)

    # b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    # c1.text="CONSIGNORADDRESS"

    # b14=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c2=Et.SubElement(b14,"CONSIGNORADDRESS")
    # c2.text="CONSIGNORADDRESS"

    # b15=Et.SubElement(m49,"DOCUMENTTYPE")
    # b15.text="DOCUMENTTYPE"

    # b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    # b16.text="CONSIGNEEPINCODE"

    # b17=Et.SubElement(m49,"SUBTYPE")
    # b17.text="SUBTYPE"

    # b18=Et.SubElement(m49,"CONSIGNORPLACE")
    # b18.text="CONSIGNORPLACE"

    # b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    # b19.text="CONSIGNORPINCODE"

    # b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    # b20.text="CONSIGNEEPLACE"

    # b21=Et.SubElement(m49,"SHIPPEDFROMSTATE")
    # b21.text="SHIPPEDFROMSTATE"

    # b22=Et.SubElement(m49,"SHIPPEDTOSTATE")
    # b22.text="SHIPPEDTOSTATE"

    # b23=Et.SubElement(m49,"TRANSPORTDETAILS.LIST")

    # c3=Et.SubElement(b23,"TRANSPORTERID")
    # c3.text="TRANSPORTERID"

    # c4=Et.SubElement(b23,"TRANSPORTERNAME")
    # c4.text="TRANSPORTERNAME"

    # c5=Et.SubElement(b23,"TRANSPORTMODE")
    # c5.text="TRANSPORTMODE"

    # c6=Et.SubElement(b23,"VEHICLENUMBER")
    # c6.text="VEHICLENUMBER"

    # c7=Et.SubElement(b23,"VEHICLETYPE")
    # c7.text="VEHICLETYPE"

    # c8=Et.SubElement(b23,"DISTANCE")
    # c8.text="DISTANCE"
    debit = 0
    for i in items:

        m50=Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append(m50)

        b23=Et.SubElement(m50,"STOCKITEMNAME")
        b23.text=str(i.product_code)

        b24=Et.SubElement(m50,"ISDEEMEDPOSITIVE")
        b24.text="Yes"

        if data.currency != 'INR':
            b25=Et.SubElement(m50,"RATE")
            b25.text= '$' + str( i.rate) + '=' + "₹" + str(round(i.rate * data.ex_rate,2))
        else:
            b25=Et.SubElement(m50,"RATE")
            b25.text=str(i.rate)

        # b26=Et.SubElement(m50,"DISCOUNT")
        # b26.text="0"

        if data.currency != 'INR':
            b27=Et.SubElement(m50,"AMOUNT")
            b27.text= '-$'+ str(i.amount)+ '@' + str(data.ex_rate)+ '/$' + '=' + "-₹" +str(round(i.amount * data.ex_rate,2))
        else:
            b27=Et.SubElement(m50,"AMOUNT")
            b27.text = str(-i.amount)

        debit += i.amount
        b28=Et.SubElement(m50,"ACTUALQTY")
        b28.text=str(i.recd_qty)

        b29=Et.SubElement(m50,"BILLEDQTY")
        b29.text=str(i.recd_qty)

        b30=Et.SubElement(m50,"BATCHALLOCATIONS.LIST")

        c9=Et.SubElement(b30,"GODOWNNAME")
        c9.text="Primary"

        c10=Et.SubElement(b30,"BATCHNAME")
        c10.text=str(i.mrp)

        if data.currency != 'INR':
            c11=Et.SubElement(b30,"AMOUNT")
            c11.text= '-$'+ str(i.amount)+ '@' + str(data.ex_rate)+ '/$' + '=' + "-₹" +str(round(i.amount * data.ex_rate,2))
        else:
            c11=Et.SubElement(b30,"AMOUNT")
            c11.text = str(-i.amount)

        c12=Et.SubElement(b30,"ACTUALQTY")
        c12.text=str(i.recd_qty)

        c13=Et.SubElement(b30,"BILLEDQTY")
        c13.text=str(i.recd_qty)

        b31=Et.SubElement(m50,"ACCOUNTINGALLOCATIONS.LIST")

        c14=Et.SubElement(b31,"OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})

        d1=Et.SubElement(c14,"OLDAUDITENTRYIDS")
        d1.text="-1"


        c15=Et.SubElement(b31,"LEDGERNAME")
        c15.text="PURCHASE"

        if data.currency != 'INR':
            c16=Et.SubElement(b31,"AMOUNT")
            c16.text= '-$'+ str(i.amount)+ '@' + str(data.ex_rate)+ '/$' + '=' + "-₹" +str(round(i.amount * data.ex_rate,2))
        else:
            c16=Et.SubElement(b31,"AMOUNT")
            c16.text = str(-i.amount)


    # b32=Et.SubElement(m50,"EXPENSEALLOCATIONS.LIST")

    # c17=Et.SubElement(b32,"LEDGERNAME")
    # c17.text="LEDGERNAME"

    # c18=Et.SubElement(b32,"VATASSESSABLEAMOUNT")
    # c18.text="LEDGERNVATASSESSABLEAMOUNTAME"


    m51=Et.Element("INVOICEDELNOTES.LIST")
    root.append(m51)
    if data.grn.exists():
        b32=Et.SubElement(m51,"BASICSHIPPINGDATE")
        b32.text=data.grn.first().grn_date.strftime('%Y%m%d')

        b33=Et.SubElement(m51,"BASICSHIPDELIVERYNOTE")
        b33.text=str(data.grn.first().grn_no)

    m52=Et.Element("INVOICEORDERLIST.LIST")
    root.append(m52)

    if data.grn.exists():

        b34=Et.SubElement(m52,"BASICORDERDATE")
        b34.text=data.grn.first().po.po_date.strftime('%Y%m%d')


        b35=Et.SubElement(m52,"BASICPURCHASEORDERNO")
        b35.text= str(data.grn.first().po.po_no)


    m53=Et.Element("LEDGERENTRIES.LIST")
    root.append(m53)


    b36=Et.SubElement(m53,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c19=Et.SubElement(b36,"OLDAUDITENTRYIDS")


    b37=Et.SubElement(m53,"LEDGERNAME")
    b37.text=data.seller.name

    if data.currency != 'INR':
        c16=Et.SubElement(m53,"AMOUNT")
        c16.text= '$'+ str(data.total)+ '@' + str(data.ex_rate)+ '/$' + '=' + "₹" +str(round(data.total * data.ex_rate,2))
    else:
        c16=Et.SubElement(m53,"AMOUNT")
        c16.text = str(data.total)

    b39=Et.SubElement(m53,"BILLALLOCATIONS.LIST")

    c20=Et.SubElement(b39,"NAME")
    c20.text=str(data.supplier_invoice)

    c21=Et.SubElement(b39,"BILLTYPE")
    c21.text="New Ref"

    if data.currency != 'INR':
        c16=Et.SubElement(b39,"AMOUNT")
        c16.text= '$'+ str(data.total)+ '@' + str(data.ex_rate)+ '/$' + '=' + "₹" +str(round(data.total * data.ex_rate,2))
    else:
        c16=Et.SubElement(b39,"AMOUNT")
        c16.text = str(data.total)

    credit = data.total
    # c23=Et.SubElement(b39,"INTERESTCOLLECTION.LIST")
    # c23.text="INTERESTCOLLECTION.LIST"

    # c24=Et.SubElement(b39,"STBILLCATEGORIES.LIST")
    # c24.text="STBILLCATEGORIES.LIST"

    if data.other_ledger:

        m54=Et.Element("LEDGERENTRIES.LIST")
        root.append(m54)

        b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
        c25.text="OLDAUDITENTRYIDS"


        b41=Et.SubElement(m54,"LEDGERNAME")
        b41.text=str(data.other_ledger)

        b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
        b42.text="No"

        b43=Et.SubElement(m54,"AMOUNT")
        b43.text=str(-data.other)
        debit += data.other

    if data.seller_gstin and data.seller_gstin[0:2] != '24':

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b45=Et.SubElement(m56,"LEDGERNAME")
        b45.text="INPUT IGST"

        b46=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m56,"AMOUNT")
        b47.text=str(-data.igst)
        debit += data.igst

    else:

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text="-1"

        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="INPUT CGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="Yes"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(-data.cgst)
        debit += data.cgst

        m57=Et.Element("LEDGERENTRIES.LIST")
        root.append(m57)

        b52=Et.SubElement(m57,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c28=Et.SubElement(b52,"OLDAUDITENTRYIDS")
        c28.text="-1"


        b53=Et.SubElement(m57,"LEDGERNAME")
        b53.text="INPUT SGST"

        b54=Et.SubElement(m57,"ISDEEMEDPOSITIVE")
        b54.text="Yes"

        b55=Et.SubElement(m57,"AMOUNT")
        b55.text=str(-data.sgst)
        debit += data.cgst

    if data.tcs > 0:

        m55=Et.Element("LEDGERENTRIES.LIST")
        root.append(m55)

        b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
        c26.text="OLDAUDITENTRYIDS"


        b45=Et.SubElement(m55,"LEDGERNAME")
        b45.text="TCS Receivable"

        b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
        b46.text="Yes"

        b47=Et.SubElement(m55,"AMOUNT")
        b47.text=str(-data.tcs)
        debit += data.tcs

    m58=Et.Element("LEDGERENTRIES.LIST")
    root.append(m58)

    b56=Et.SubElement(m58,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c29=Et.SubElement(b56,"OLDAUDITENTRYIDS")
    c29.text= "-1"

    b57=Et.SubElement(m58,"LEDGERNAME")
    b57.text="Round Off"

    b58=Et.SubElement(m58,"ISDEEMEDPOSITIVE")
    b58.text="Yes"

    # b59=Et.SubElement(m58,"AMOUNT")
    # b59.text= str(debit - credit)

    if data.currency != 'INR':
        b59=Et.SubElement(m58,"AMOUNT")
        b59.text= '$'+ str(debit - credit)+ '@' + str(data.ex_rate)+ '/$' + '=' + "₹" +str(round(((debit - credit) * data.ex_rate),2))
    else:
        b59=Et.SubElement(m58,"AMOUNT")
        b59.text = str(debit - credit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str


def debitxml(data, items):
    #Purchase
# "REMOTEID":"e20c8366-3352-44fd-ab5b-f697e4b53794-00016d1b"
    root=Et.Element("VOUCHER",{"VCHTYPE":"Debit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    m1=Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append(m1)

    b1=Et.SubElement(m1,"ADDRESS")
    b1.text=data.seller_address1

    b2=Et.SubElement(m1,"ADDRESS")
    b2.text=data.seller_address2

    b3=Et.SubElement(m1,"ADDRESS")
    b3.text=data.seller_address3


    # m2=Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    # root.append(m2)

    # b5=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b5.text=data.seller_address1

    # b6=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b6.text=data.seller_address2

    # b7=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b7.text=data.seller_address3

    m3=Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append(m3)

    b8=Et.SubElement(m3,"BASICBUYERADDRESS")
    b8.text=data.seller_address1

    b9=Et.SubElement(m3,"BASICBUYERADDRESS")
    b9.text=data.seller_address2

    b10=Et.SubElement(m3,"BASICBUYERADDRESS")
    b10.text=data.seller_address3

    # m4=Et.Element("BASICORDERTERMS.LIST ",{"TYPE":"String"})
    # root.append(m4)

    # b11=Et.SubElement(m4,"BASICORDERTERMS")
    # b11.text=data.terms_of_delivery

    m5=Et.Element("OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})
    root.append(m5)


    b12=Et.SubElement(m5,"OLDAUDITENTRYIDS")
    b12.text="-1"

    m6=Et.Element("DATE")
    m6.text=data.created.strftime('%Y%m%d')
    root.append(m6)

    # m7=Et.Element("BILLOFLADINGDATE")
    # m7.text=data.created.strftime('%Y%m%d')
    # root.append(m7)

    m8=Et.Element("GUID")
    m8.text=str(data.pk)
    root.append(m8)

    m9=Et.Element("GSTREGISTRATIONTYPE")
    m9.text=data.seller_gst_reg_type
    root.append(m9)

    m10=Et.Element("STATENAME")
    m10.text=data.seller_state
    root.append(m10)

    m11=Et.Element("VOUCHERTYPENAME")
    m11.text="Debit Note"
    root.append(m11)

    m12=Et.Element("OBJECTUPDATEACTION")
    m12.text="Create"
    root.append(m12)

    m13=Et.Element("COUNTRYOFRESIDENCE")
    m13.text=data.seller_country
    root.append(m13)

    m14=Et.Element("PARTYGSTIN")
    m14.text=data.seller_gstin
    root.append(m14)

    m15=Et.Element("PLACEOFSUPPLY")
    m15.text=data.seller_city
    root.append(m15)

    m16=Et.Element("PARTYNAME")
    m16.text=data.seller.name
    root.append(m16)

    m17=Et.Element("PARTYLEDGERNAME")
    m17.text=data.seller.name
    root.append(m17)

    # m18=Et.Element("BUYERADDRESSTYPE")
    # m18.text=data.seller.name
    # root.append(m18)

    m19=Et.Element("PARTYMAILINGNAME")
    m19.text=data.seller_mailingname
    root.append(m19)

    m20=Et.Element("PARTYPINCODE")
    m20.text=data.seller_pincode
    root.append(m20)

    m21=Et.Element("BILLTOPLACE")
    m21.text=data.shipto_city
    root.append(m21)

    # m22=Et.Element("DISPATCHFROMNAME")
    # m22.text="DISPATCHFROMNAME"
    # root.append(m22)

    m23=Et.Element("DISPATCHFROMSTATENAME")
    m23.text=data.seller_mailingname
    root.append(m23)

    m24=Et.Element("DISPATCHFROMPINCODE")
    m24.text=data.seller_pincode
    root.append(m24)

    m25=Et.Element("DISPATCHFROMPLACE")
    m25.text=data.seller_city
    root.append(m25)

    m26=Et.Element("SHIPTOPLACE")
    m26.text=data.seller_city
    root.append(m26)

    m27=Et.Element("CONSIGNEEGSTIN")
    m27.text=data.seller_gstin
    root.append(m27)

    m28=Et.Element("CONSIGNEEMAILINGNAME")
    m28.text=data.seller_mailingname
    root.append(m28)

    m29=Et.Element("CONSIGNEEPINCODE")
    m29.text=data.seller_pincode
    root.append(m29)

    m30=Et.Element("CONSIGNEESTATENAME")
    m30.text=data.seller_state
    root.append(m30)

    m31=Et.Element("VOUCHERNUMBER")
    m31.text=data.db_no
    root.append(m31)

    m131=Et.Element("REFERENCEDATE")
    m131.text=data.pi_no.supplier_date.strftime('%Y%m%d')
    root.append(m131)

    m131=Et.Element("REFERENCE")
    m131.text=data.pi_no.supplier_invoice
    root.append(m131)

    m32=Et.Element("BASICBASEPARTYNAME")
    m32.text=data.seller.name
    root.append(m32)

    m33=Et.Element("PERSISTEDVIEW")
    m33.text="Invoice Voucher View"
    root.append(m33)

    # m34=Et.Element("BILLOFLADINGNO")
    # m34.text="BILLOFLADINGNO"
    # root.append(m34)

    # m35=Et.Element("EICHECKPOST")
    # m35.text="EICHECKPOST"
    # root.append(m35)

    # m36=Et.Element("BASICSHIPPEDBY")
    # m36.text=data.dispatch_through
    # root.append(m36)

    m37=Et.Element("BASICBUYERNAME")
    m37.text=data.seller.name
    root.append(m37)

    # m38=Et.Element("BASICSHIPDOCUMENTNO")
    # m38.text=data.pi_no
    # root.append(m38)

    # m39=Et.Element("BASICFINALDESTINATION")
    # m39.text=data.shipto_city
    # root.append(m39)

    # m40=Et.Element("BASICORDERREF")
    # m40.text=data.other_reference
    # root.append(m40)

    # m41=Et.Element("BASICSHIPVESSELNO")
    # m41.text=""
    # root.append(m41)

    # m42=Et.Element("BASICDUEDATEOFPYMT")
    # m42.text=""
    # root.append(m42)

    m43=Et.Element("CONSIGNEECOUNTRYNAME")
    m43.text=data.shipto_country
    root.append(m43)

    m44=Et.Element("CONSIGNEEPINNUMBER")
    m44.text=data.shipto_pan_no
    root.append(m44)

    m45=Et.Element("VCHENTRYMODE")
    m45.text="Item Invoice"
    root.append(m45)

    # m46=Et.Element("VOUCHERTYPEORIGNAME")
    # m46.text="VOUCHERTYPEORIGNAME"
    # root.append(m46)

    m47=Et.Element("ISINVOICE")
    m47.text="yes"
    root.append(m47)

    m48=Et.Element("ISDELETEDVCHRETAINED")
    m48.text="NO"
    root.append(m48)

    # m49=Et.Element("EWAYBILLDETAILS.LIST")
    # root.append(m49)

    # b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    # c1.text="CONSIGNORADDRESS"

    # b14=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c2=Et.SubElement(b14,"CONSIGNORADDRESS")
    # c2.text="CONSIGNORADDRESS"

    # b15=Et.SubElement(m49,"DOCUMENTTYPE")
    # b15.text="DOCUMENTTYPE"

    # b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    # b16.text="CONSIGNEEPINCODE"

    # b17=Et.SubElement(m49,"SUBTYPE")
    # b17.text="SUBTYPE"

    # b18=Et.SubElement(m49,"CONSIGNORPLACE")
    # b18.text="CONSIGNORPLACE"

    # b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    # b19.text="CONSIGNORPINCODE"

    # b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    # b20.text="CONSIGNEEPLACE"

    # b21=Et.SubElement(m49,"SHIPPEDFROMSTATE")
    # b21.text="SHIPPEDFROMSTATE"

    # b22=Et.SubElement(m49,"SHIPPEDTOSTATE")
    # b22.text="SHIPPEDTOSTATE"

    # b23=Et.SubElement(m49,"TRANSPORTDETAILS.LIST")

    # c3=Et.SubElement(b23,"TRANSPORTERID")
    # c3.text="TRANSPORTERID"

    # c4=Et.SubElement(b23,"TRANSPORTERNAME")
    # c4.text="TRANSPORTERNAME"

    # c5=Et.SubElement(b23,"TRANSPORTMODE")
    # c5.text="TRANSPORTMODE"

    # c6=Et.SubElement(b23,"VEHICLENUMBER")
    # c6.text="VEHICLENUMBER"

    # c7=Et.SubElement(b23,"VEHICLETYPE")
    # c7.text="VEHICLETYPE"

    # c8=Et.SubElement(b23,"DISTANCE")
    # c8.text="DISTANCE"
    debit = 0
    for i in items:

        m50=Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append(m50)

        b23=Et.SubElement(m50,"STOCKITEMNAME")
        b23.text=str(i.product_code)

        b24=Et.SubElement(m50,"ISDEEMEDPOSITIVE")
        b24.text="No"

        b25=Et.SubElement(m50,"RATE")
        b25.text=str(i.rate_diff)

        # b26=Et.SubElement(m50,"DISCOUNT")
        # b26.text="0"

        b27=Et.SubElement(m50,"AMOUNT")
        b27.text = str(i.amount)
        debit += i.amount
        # b28=Et.SubElement(m50,"ACTUALQTY")
        # b28.text=str(i.actual_qty)

        b29=Et.SubElement(m50,"BILLEDQTY")
        b29.text=str(i.actual_qty)

        b30=Et.SubElement(m50,"BATCHALLOCATIONS.LIST")

        c9=Et.SubElement(b30,"GODOWNNAME")
        c9.text="Primary"

        c10=Et.SubElement(b30,"BATCHNAME")
        c10.text=str(i.mrp)

        c11=Et.SubElement(b30,"AMOUNT")
        c11.text=str(i.amount)

        # c12=Et.SubElement(b30,"ACTUALQTY")
        # c12.text=str(i.actual_qty)

        c13=Et.SubElement(b30,"BILLEDQTY")
        c13.text=str(i.actual_qty)

        b31=Et.SubElement(m50,"ACCOUNTINGALLOCATIONS.LIST")

        c14=Et.SubElement(b31,"OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})

        d1=Et.SubElement(c14,"OLDAUDITENTRYIDS")
        d1.text="-1"


        c15=Et.SubElement(b31,"LEDGERNAME")
        c15.text="PURCHASE"

        c16=Et.SubElement(b31,"AMOUNT")
        c16.text=str(i.amount)


    # b32=Et.SubElement(m50,"EXPENSEALLOCATIONS.LIST")

    # c17=Et.SubElement(b32,"LEDGERNAME")
    # c17.text="LEDGERNAME"

    # c18=Et.SubElement(b32,"VATASSESSABLEAMOUNT")
    # c18.text="LEDGERNVATASSESSABLEAMOUNTAME"


    m51=Et.Element("INVOICEDELNOTES.LIST")
    root.append(m51)


    b32=Et.SubElement(m51,"BASICSHIPPINGDATE")
    b32.text=data.pi_no.pi_date.strftime('%Y%m%d')


    b33=Et.SubElement(m51,"BASICSHIPDELIVERYNOTE")
    b33.text=str(data.pi_no)

    m52=Et.Element("INVOICEORDERLIST.LIST")
    root.append(m52)


    # b34=Et.SubElement(m52,"BASICORDERDATE")
    # b34.text=data.pi_no.pi_date.strftime('%Y%m%d')


    # b35=Et.SubElement(m52,"BASICPURCHASEORDERNO")
    # b35.text= str(data.pi_no)


    m53=Et.Element("LEDGERENTRIES.LIST")
    root.append(m53)


    b36=Et.SubElement(m53,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c19=Et.SubElement(b36,"OLDAUDITENTRYIDS")


    b37=Et.SubElement(m53,"LEDGERNAME")
    b37.text=data.seller.name

    b38=Et.SubElement(m53,"AMOUNT")
    b38.text=str(-data.total)

    b39=Et.SubElement(m53,"BILLALLOCATIONS.LIST")

    c20=Et.SubElement(b39,"NAME")
    c20.text=str(data.pi_no.supplier_invoice)

    c21=Et.SubElement(b39,"BILLTYPE")
    c21.text="agst Ref"

    c22=Et.SubElement(b39,"AMOUNT")
    c22.text=str(-data.total)
    credit = data.total
    # c23=Et.SubElement(b39,"INTERESTCOLLECTION.LIST")
    # c23.text="INTERESTCOLLECTION.LIST"

    # c24=Et.SubElement(b39,"STBILLCATEGORIES.LIST")
    # c24.text="STBILLCATEGORIES.LIST"

    # if data.other_ledger:

    #     m54=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m54)

    #     b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
    #     c25.text="OLDAUDITENTRYIDS"


    #     b41=Et.SubElement(m54,"LEDGERNAME")
    #     b41.text=str(data.other_ledger)

    #     b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
    #     b42.text="No"

    #     b43=Et.SubElement(m54,"AMOUNT")
    #     b43.text=str(-data.other)
    #     debit += data.other

    if data.seller_gstin and data.seller_gstin[0:2] != '24':

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

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text="-1"


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="CGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="No"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(data.cgst)
        debit += data.cgst

        m57=Et.Element("LEDGERENTRIES.LIST")
        root.append(m57)

        b52=Et.SubElement(m57,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c28=Et.SubElement(b52,"OLDAUDITENTRYIDS")
        c28.text="-1"


        b53=Et.SubElement(m57,"LEDGERNAME")
        b53.text="SGST"

        b54=Et.SubElement(m57,"ISDEEMEDPOSITIVE")
        b54.text="No"

        b55=Et.SubElement(m57,"AMOUNT")
        b55.text=str(data.sgst)
        debit += data.cgst

    # if data.tcs > 0:

    #     m55=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m55)

    #     b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
    #     c26.text="OLDAUDITENTRYIDS"


    #     b45=Et.SubElement(m55,"LEDGERNAME")
    #     b45.text="TCS Payable"

    #     b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
    #     b46.text="Yes"

    #     b47=Et.SubElement(m55,"AMOUNT")
    #     b47.text=str(-data.tcs)
    #     debit += data.tcs

    m58=Et.Element("LEDGERENTRIES.LIST")
    root.append(m58)

    b56=Et.SubElement(m58,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c29=Et.SubElement(b56,"OLDAUDITENTRYIDS")
    c29.text= "-1"

    b57=Et.SubElement(m58,"LEDGERNAME")
    b57.text="Round Off"

    b58=Et.SubElement(m58,"ISDEEMEDPOSITIVE")
    b58.text="No"

    b59=Et.SubElement(m58,"AMOUNT")
    b59.text= str(credit - debit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str


def qdnxml(data, items):
    #Purchase
# "REMOTEID":"e20c8366-3352-44fd-ab5b-f697e4b53794-00016d1b"
    root=Et.Element("VOUCHER",{"VCHTYPE":"Debit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    m1=Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append(m1)

    b1=Et.SubElement(m1,"ADDRESS")
    b1.text=data.seller_address1

    b2=Et.SubElement(m1,"ADDRESS")
    b2.text=data.seller_address2

    b3=Et.SubElement(m1,"ADDRESS")
    b3.text=data.seller_address3


    # m2=Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    # root.append(m2)

    # b5=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b5.text=data.seller_address1

    # b6=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b6.text=data.seller_address2

    # b7=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b7.text=data.seller_address3

    m3=Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append(m3)

    b8=Et.SubElement(m3,"BASICBUYERADDRESS")
    b8.text=data.seller_address1

    b9=Et.SubElement(m3,"BASICBUYERADDRESS")
    b9.text=data.seller_address2

    b10=Et.SubElement(m3,"BASICBUYERADDRESS")
    b10.text=data.seller_address3

    # m4=Et.Element("BASICORDERTERMS.LIST ",{"TYPE":"String"})
    # root.append(m4)

    # b11=Et.SubElement(m4,"BASICORDERTERMS")
    # b11.text=data.terms_of_delivery

    m5=Et.Element("OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})
    root.append(m5)


    b12=Et.SubElement(m5,"OLDAUDITENTRYIDS")
    b12.text="-1"

    m6=Et.Element("DATE")
    m6.text=data.created.strftime('%Y%m%d')
    root.append(m6)

    # m7=Et.Element("BILLOFLADINGDATE")
    # m7.text=data.created.strftime('%Y%m%d')
    # root.append(m7)

    m8=Et.Element("GUID")
    m8.text=str(data.pk)
    root.append(m8)

    m9=Et.Element("GSTREGISTRATIONTYPE")
    m9.text=data.seller_gst_reg_type
    root.append(m9)

    m10=Et.Element("STATENAME")
    m10.text=data.seller_state
    root.append(m10)

    m11=Et.Element("VOUCHERTYPENAME")
    m11.text="Debit Note"
    root.append(m11)

    m12=Et.Element("OBJECTUPDATEACTION")
    m12.text="Create"
    root.append(m12)

    m13=Et.Element("COUNTRYOFRESIDENCE")
    m13.text=data.seller_country
    root.append(m13)

    m14=Et.Element("PARTYGSTIN")
    m14.text=data.seller_gstin
    root.append(m14)

    m15=Et.Element("PLACEOFSUPPLY")
    m15.text=data.seller_city
    root.append(m15)

    m16=Et.Element("PARTYNAME")
    m16.text=data.seller.name
    root.append(m16)

    m17=Et.Element("PARTYLEDGERNAME")
    m17.text=data.seller.name
    root.append(m17)

    # m18=Et.Element("BUYERADDRESSTYPE")
    # m18.text=data.seller.name
    # root.append(m18)

    m19=Et.Element("PARTYMAILINGNAME")
    m19.text=data.seller_mailingname
    root.append(m19)

    m20=Et.Element("PARTYPINCODE")
    m20.text=data.seller_pincode
    root.append(m20)

    m21=Et.Element("BILLTOPLACE")
    m21.text=data.shipto_city
    root.append(m21)

    # m22=Et.Element("DISPATCHFROMNAME")
    # m22.text="DISPATCHFROMNAME"
    # root.append(m22)

    m23=Et.Element("DISPATCHFROMSTATENAME")
    m23.text=data.seller_mailingname
    root.append(m23)

    m24=Et.Element("DISPATCHFROMPINCODE")
    m24.text=data.seller_pincode
    root.append(m24)

    m25=Et.Element("DISPATCHFROMPLACE")
    m25.text=data.seller_city
    root.append(m25)

    m26=Et.Element("SHIPTOPLACE")
    m26.text=data.seller_city
    root.append(m26)

    m27=Et.Element("CONSIGNEEGSTIN")
    m27.text=data.seller_gstin
    root.append(m27)

    m28=Et.Element("CONSIGNEEMAILINGNAME")
    m28.text=data.seller_mailingname
    root.append(m28)

    m29=Et.Element("CONSIGNEEPINCODE")
    m29.text=data.seller_pincode
    root.append(m29)

    m30=Et.Element("CONSIGNEESTATENAME")
    m30.text=data.seller_state
    root.append(m30)

    m31=Et.Element("VOUCHERNUMBER")
    m31.text=data.qdn_no
    root.append(m31)

    m131=Et.Element("REFERENCEDATE")
    m131.text=data.pi_no.supplier_date.strftime('%Y%m%d')
    root.append(m131)

    m131=Et.Element("REFERENCE")
    m131.text=data.pi_no.supplier_invoice
    root.append(m131)

    m32=Et.Element("BASICBASEPARTYNAME")
    m32.text=data.seller.name
    root.append(m32)

    m33=Et.Element("PERSISTEDVIEW")
    m33.text="Invoice Voucher View"
    root.append(m33)

    # m34=Et.Element("BILLOFLADINGNO")
    # m34.text="BILLOFLADINGNO"
    # root.append(m34)

    # m35=Et.Element("EICHECKPOST")
    # m35.text="EICHECKPOST"
    # root.append(m35)

    # m36=Et.Element("BASICSHIPPEDBY")
    # m36.text=data.dispatch_through
    # root.append(m36)

    m37=Et.Element("BASICBUYERNAME")
    m37.text=data.seller.name
    root.append(m37)

    # m38=Et.Element("BASICSHIPDOCUMENTNO")
    # m38.text=data.pi_no
    # root.append(m38)

    # m39=Et.Element("BASICFINALDESTINATION")
    # m39.text=data.shipto_city
    # root.append(m39)

    # m40=Et.Element("BASICORDERREF")
    # m40.text=data.other_reference
    # root.append(m40)

    # m41=Et.Element("BASICSHIPVESSELNO")
    # m41.text=""
    # root.append(m41)

    # m42=Et.Element("BASICDUEDATEOFPYMT")
    # m42.text=""
    # root.append(m42)

    m43=Et.Element("CONSIGNEECOUNTRYNAME")
    m43.text=data.shipto_country
    root.append(m43)

    m44=Et.Element("CONSIGNEEPINNUMBER")
    m44.text=data.shipto_pan_no
    root.append(m44)

    m45=Et.Element("VCHENTRYMODE")
    m45.text="Item Invoice"
    root.append(m45)

    # m46=Et.Element("VOUCHERTYPEORIGNAME")
    # m46.text="VOUCHERTYPEORIGNAME"
    # root.append(m46)

    m47=Et.Element("ISINVOICE")
    m47.text="yes"
    root.append(m47)

    m48=Et.Element("ISDELETEDVCHRETAINED")
    m48.text="NO"
    root.append(m48)

    # m49=Et.Element("EWAYBILLDETAILS.LIST")
    # root.append(m49)

    # b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    # c1.text="CONSIGNORADDRESS"

    # b14=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c2=Et.SubElement(b14,"CONSIGNORADDRESS")
    # c2.text="CONSIGNORADDRESS"

    # b15=Et.SubElement(m49,"DOCUMENTTYPE")
    # b15.text="DOCUMENTTYPE"

    # b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    # b16.text="CONSIGNEEPINCODE"

    # b17=Et.SubElement(m49,"SUBTYPE")
    # b17.text="SUBTYPE"

    # b18=Et.SubElement(m49,"CONSIGNORPLACE")
    # b18.text="CONSIGNORPLACE"

    # b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    # b19.text="CONSIGNORPINCODE"

    # b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    # b20.text="CONSIGNEEPLACE"

    # b21=Et.SubElement(m49,"SHIPPEDFROMSTATE")
    # b21.text="SHIPPEDFROMSTATE"

    # b22=Et.SubElement(m49,"SHIPPEDTOSTATE")
    # b22.text="SHIPPEDTOSTATE"

    # b23=Et.SubElement(m49,"TRANSPORTDETAILS.LIST")

    # c3=Et.SubElement(b23,"TRANSPORTERID")
    # c3.text="TRANSPORTERID"

    # c4=Et.SubElement(b23,"TRANSPORTERNAME")
    # c4.text="TRANSPORTERNAME"

    # c5=Et.SubElement(b23,"TRANSPORTMODE")
    # c5.text="TRANSPORTMODE"

    # c6=Et.SubElement(b23,"VEHICLENUMBER")
    # c6.text="VEHICLENUMBER"

    # c7=Et.SubElement(b23,"VEHICLETYPE")
    # c7.text="VEHICLETYPE"

    # c8=Et.SubElement(b23,"DISTANCE")
    # c8.text="DISTANCE"
    debit = 0
    for i in items:

        m50=Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append(m50)

        b23=Et.SubElement(m50,"STOCKITEMNAME")
        b23.text=str(i.product_code)

        b24=Et.SubElement(m50,"ISDEEMEDPOSITIVE")
        b24.text="No"

        b25=Et.SubElement(m50,"RATE")
        b25.text=str(i.rate)

        # b26=Et.SubElement(m50,"DISCOUNT")
        # b26.text="0"

        b27=Et.SubElement(m50,"AMOUNT")
        b27.text = str(i.amount)
        debit += i.amount
        b28=Et.SubElement(m50,"ACTUALQTY")
        b28.text=str(i.qdn_qty)

        b29=Et.SubElement(m50,"BILLEDQTY")
        b29.text=str(i.qdn_qty)

        b30=Et.SubElement(m50,"BATCHALLOCATIONS.LIST")

        c9=Et.SubElement(b30,"GODOWNNAME")
        c9.text="Primary"

        c10=Et.SubElement(b30,"BATCHNAME")
        c10.text=str(i.mrp)

        c11=Et.SubElement(b30,"AMOUNT")
        c11.text=str(i.amount)

        c12=Et.SubElement(b30,"ACTUALQTY")
        c12.text=str(i.actual_qty)

        c13=Et.SubElement(b30,"BILLEDQTY")
        c13.text=str(i.actual_qty)

        b31=Et.SubElement(m50,"ACCOUNTINGALLOCATIONS.LIST")

        c14=Et.SubElement(b31,"OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})

        d1=Et.SubElement(c14,"OLDAUDITENTRYIDS")
        d1.text="-1"


        c15=Et.SubElement(b31,"LEDGERNAME")
        c15.text="PURCHASE"

        c16=Et.SubElement(b31,"AMOUNT")
        c16.text=str(i.amount)


    # b32=Et.SubElement(m50,"EXPENSEALLOCATIONS.LIST")

    # c17=Et.SubElement(b32,"LEDGERNAME")
    # c17.text="LEDGERNAME"

    # c18=Et.SubElement(b32,"VATASSESSABLEAMOUNT")
    # c18.text="LEDGERNVATASSESSABLEAMOUNTAME"


    m51=Et.Element("INVOICEDELNOTES.LIST")
    root.append(m51)


    b32=Et.SubElement(m51,"BASICSHIPPINGDATE")
    b32.text=data.pi_no.pi_date.strftime('%Y%m%d')


    b33=Et.SubElement(m51,"BASICSHIPDELIVERYNOTE")
    b33.text=str(data.pi_no)

    m52=Et.Element("INVOICEORDERLIST.LIST")
    root.append(m52)


    # b34=Et.SubElement(m52,"BASICORDERDATE")
    # b34.text=data.pi_no.pi_date.strftime('%Y%m%d')


    # b35=Et.SubElement(m52,"BASICPURCHASEORDERNO")
    # b35.text= str(data.pi_no)


    m53=Et.Element("LEDGERENTRIES.LIST")
    root.append(m53)


    b36=Et.SubElement(m53,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c19=Et.SubElement(b36,"OLDAUDITENTRYIDS")


    b37=Et.SubElement(m53,"LEDGERNAME")
    b37.text=data.seller.name

    b38=Et.SubElement(m53,"AMOUNT")
    b38.text=str(-data.total)

    b39=Et.SubElement(m53,"BILLALLOCATIONS.LIST")

    c20=Et.SubElement(b39,"NAME")
    c20.text=str(data.pi_no.supplier_invoice)

    c21=Et.SubElement(b39,"BILLTYPE")
    c21.text="agst Ref"

    c22=Et.SubElement(b39,"AMOUNT")
    c22.text=str(-data.total)
    credit = data.total
    # c23=Et.SubElement(b39,"INTERESTCOLLECTION.LIST")
    # c23.text="INTERESTCOLLECTION.LIST"

    # c24=Et.SubElement(b39,"STBILLCATEGORIES.LIST")
    # c24.text="STBILLCATEGORIES.LIST"

    # if data.other_ledger:

    #     m54=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m54)

    #     b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
    #     c25.text="OLDAUDITENTRYIDS"


    #     b41=Et.SubElement(m54,"LEDGERNAME")
    #     b41.text=str(data.other_ledger)

    #     b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
    #     b42.text="No"

    #     b43=Et.SubElement(m54,"AMOUNT")
    #     b43.text=str(-data.other)
    #     debit += data.other

    if data.seller_gstin and data.seller_gstin[0:2] != '24':

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

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text="-1"


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="CGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="No"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(data.cgst)
        debit += data.cgst

        m57=Et.Element("LEDGERENTRIES.LIST")
        root.append(m57)

        b52=Et.SubElement(m57,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c28=Et.SubElement(b52,"OLDAUDITENTRYIDS")
        c28.text="-1"


        b53=Et.SubElement(m57,"LEDGERNAME")
        b53.text="SGST"

        b54=Et.SubElement(m57,"ISDEEMEDPOSITIVE")
        b54.text="No"

        b55=Et.SubElement(m57,"AMOUNT")
        b55.text=str(data.sgst)
        debit += data.cgst

    # if data.tcs > 0:

    #     m55=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m55)

    #     b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
    #     c26.text="OLDAUDITENTRYIDS"


    #     b45=Et.SubElement(m55,"LEDGERNAME")
    #     b45.text="TCS Payable"

    #     b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
    #     b46.text="Yes"

    #     b47=Et.SubElement(m55,"AMOUNT")
    #     b47.text=str(-data.tcs)
    #     debit += data.tcs

    m58=Et.Element("LEDGERENTRIES.LIST")
    root.append(m58)

    b56=Et.SubElement(m58,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c29=Et.SubElement(b56,"OLDAUDITENTRYIDS")
    c29.text= "-1"

    b57=Et.SubElement(m58,"LEDGERNAME")
    b57.text="Round Off"

    b58=Et.SubElement(m58,"ISDEEMEDPOSITIVE")
    b58.text="Yes"

    b59=Et.SubElement(m58,"AMOUNT")
    b59.text= str(credit - debit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str


def prxml(data, items):
    #Purchase
# "REMOTEID":"e20c8366-3352-44fd-ab5b-f697e4b53794-00016d1b"
    root=Et.Element("VOUCHER",{"VCHTYPE":"Debit Note","ACTION":"Create","OBJVIEW":"Invoice Voucher View"})

    m1=Et.Element("ADDRESS.LIST",{"TYPE":"String"})
    root.append(m1)

    b1=Et.SubElement(m1,"ADDRESS")
    b1.text=data.seller_address1

    b2=Et.SubElement(m1,"ADDRESS")
    b2.text=data.seller_address2

    b3=Et.SubElement(m1,"ADDRESS")
    b3.text=data.seller_address3


    # m2=Et.Element("DISPATCHFROMADDRESS.LIST",{"TYPE":"String"})
    # root.append(m2)

    # b5=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b5.text=data.seller_address1

    # b6=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b6.text=data.seller_address2

    # b7=Et.SubElement(m2,"DISPATCHFROMADDRESS")
    # b7.text=data.seller_address3

    m3=Et.Element("BASICBUYERADDRESS.LIST",{"TYPE":"String"})
    root.append(m3)

    b8=Et.SubElement(m3,"BASICBUYERADDRESS")
    b8.text=data.seller_address1

    b9=Et.SubElement(m3,"BASICBUYERADDRESS")
    b9.text=data.seller_address2

    b10=Et.SubElement(m3,"BASICBUYERADDRESS")
    b10.text=data.seller_address3

    # m4=Et.Element("BASICORDERTERMS.LIST ",{"TYPE":"String"})
    # root.append(m4)

    # b11=Et.SubElement(m4,"BASICORDERTERMS")
    # b11.text=data.terms_of_delivery

    m5=Et.Element("OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})
    root.append(m5)


    b12=Et.SubElement(m5,"OLDAUDITENTRYIDS")
    b12.text="-1"

    m6=Et.Element("DATE")
    m6.text=data.created.strftime('%Y%m%d')
    root.append(m6)

    # m7=Et.Element("BILLOFLADINGDATE")
    # m7.text=data.created.strftime('%Y%m%d')
    # root.append(m7)

    m8=Et.Element("GUID")
    m8.text=str(data.pk)
    root.append(m8)

    m9=Et.Element("GSTREGISTRATIONTYPE")
    m9.text=data.seller_gst_reg_type
    root.append(m9)

    m10=Et.Element("STATENAME")
    m10.text=data.seller_state
    root.append(m10)

    m11=Et.Element("VOUCHERTYPENAME")
    m11.text="Debit Note"
    root.append(m11)

    m12=Et.Element("OBJECTUPDATEACTION")
    m12.text="Create"
    root.append(m12)

    m13=Et.Element("COUNTRYOFRESIDENCE")
    m13.text=data.seller_country
    root.append(m13)

    m14=Et.Element("PARTYGSTIN")
    m14.text=data.seller_gstin
    root.append(m14)

    m15=Et.Element("PLACEOFSUPPLY")
    m15.text=data.seller_city
    root.append(m15)

    m16=Et.Element("PARTYNAME")
    m16.text=data.seller.name
    root.append(m16)

    m17=Et.Element("PARTYLEDGERNAME")
    m17.text=data.seller.name
    root.append(m17)

    # m18=Et.Element("BUYERADDRESSTYPE")
    # m18.text=data.seller.name
    # root.append(m18)

    m19=Et.Element("PARTYMAILINGNAME")
    m19.text=data.seller_mailingname
    root.append(m19)

    m20=Et.Element("PARTYPINCODE")
    m20.text=data.seller_pincode
    root.append(m20)

    m21=Et.Element("BILLTOPLACE")
    m21.text=data.shipto_city
    root.append(m21)

    # m22=Et.Element("DISPATCHFROMNAME")
    # m22.text="DISPATCHFROMNAME"
    # root.append(m22)

    m23=Et.Element("DISPATCHFROMSTATENAME")
    m23.text=data.seller_mailingname
    root.append(m23)

    m24=Et.Element("DISPATCHFROMPINCODE")
    m24.text=data.seller_pincode
    root.append(m24)

    m25=Et.Element("DISPATCHFROMPLACE")
    m25.text=data.seller_city
    root.append(m25)

    m26=Et.Element("SHIPTOPLACE")
    m26.text=data.seller_city
    root.append(m26)

    m27=Et.Element("CONSIGNEEGSTIN")
    m27.text=data.seller_gstin
    root.append(m27)

    m28=Et.Element("CONSIGNEEMAILINGNAME")
    m28.text=data.seller_mailingname
    root.append(m28)

    m29=Et.Element("CONSIGNEEPINCODE")
    m29.text=data.seller_pincode
    root.append(m29)

    m30=Et.Element("CONSIGNEESTATENAME")
    m30.text=data.seller_state
    root.append(m30)

    m31=Et.Element("VOUCHERNUMBER")
    m31.text=data.pr_no
    root.append(m31)

    m131=Et.Element("REFERENCEDATE")
    m131.text=data.pi_no.supplier_date.strftime('%Y%m%d')
    root.append(m131)

    m131=Et.Element("REFERENCE")
    m131.text=data.pi_no.supplier_invoice
    root.append(m131)

    m32=Et.Element("BASICBASEPARTYNAME")
    m32.text=data.seller.name
    root.append(m32)

    m33=Et.Element("PERSISTEDVIEW")
    m33.text="Invoice Voucher View"
    root.append(m33)

    # m34=Et.Element("BILLOFLADINGNO")
    # m34.text="BILLOFLADINGNO"
    # root.append(m34)

    # m35=Et.Element("EICHECKPOST")
    # m35.text="EICHECKPOST"
    # root.append(m35)

    # m36=Et.Element("BASICSHIPPEDBY")
    # m36.text=data.dispatch_through
    # root.append(m36)

    m37=Et.Element("BASICBUYERNAME")
    m37.text=data.seller.name
    root.append(m37)

    # m38=Et.Element("BASICSHIPDOCUMENTNO")
    # m38.text=data.pi_no
    # root.append(m38)

    # m39=Et.Element("BASICFINALDESTINATION")
    # m39.text=data.shipto_city
    # root.append(m39)

    # m40=Et.Element("BASICORDERREF")
    # m40.text=data.other_reference
    # root.append(m40)

    # m41=Et.Element("BASICSHIPVESSELNO")
    # m41.text=""
    # root.append(m41)

    # m42=Et.Element("BASICDUEDATEOFPYMT")
    # m42.text=""
    # root.append(m42)

    m43=Et.Element("CONSIGNEECOUNTRYNAME")
    m43.text=data.shipto_country
    root.append(m43)

    m44=Et.Element("CONSIGNEEPINNUMBER")
    m44.text=data.shipto_pan_no
    root.append(m44)

    m45=Et.Element("VCHENTRYMODE")
    m45.text="Item Invoice"
    root.append(m45)

    # m46=Et.Element("VOUCHERTYPEORIGNAME")
    # m46.text="VOUCHERTYPEORIGNAME"
    # root.append(m46)

    m47=Et.Element("ISINVOICE")
    m47.text="yes"
    root.append(m47)

    m48=Et.Element("ISDELETEDVCHRETAINED")
    m48.text="NO"
    root.append(m48)

    # m49=Et.Element("EWAYBILLDETAILS.LIST")
    # root.append(m49)

    # b13=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c1=Et.SubElement(b13,"CONSIGNORADDRESS")
    # c1.text="CONSIGNORADDRESS"

    # b14=Et.SubElement(m49,"CONSIGNORADDRESS.LIST",{"TYPE":"String"})

    # c2=Et.SubElement(b14,"CONSIGNORADDRESS")
    # c2.text="CONSIGNORADDRESS"

    # b15=Et.SubElement(m49,"DOCUMENTTYPE")
    # b15.text="DOCUMENTTYPE"

    # b16=Et.SubElement(m49,"CONSIGNEEPINCODE")
    # b16.text="CONSIGNEEPINCODE"

    # b17=Et.SubElement(m49,"SUBTYPE")
    # b17.text="SUBTYPE"

    # b18=Et.SubElement(m49,"CONSIGNORPLACE")
    # b18.text="CONSIGNORPLACE"

    # b19=Et.SubElement(m49,"CONSIGNORPINCODE")
    # b19.text="CONSIGNORPINCODE"

    # b20=Et.SubElement(m49,"CONSIGNEEPLACE")
    # b20.text="CONSIGNEEPLACE"

    # b21=Et.SubElement(m49,"SHIPPEDFROMSTATE")
    # b21.text="SHIPPEDFROMSTATE"

    # b22=Et.SubElement(m49,"SHIPPEDTOSTATE")
    # b22.text="SHIPPEDTOSTATE"

    # b23=Et.SubElement(m49,"TRANSPORTDETAILS.LIST")

    # c3=Et.SubElement(b23,"TRANSPORTERID")
    # c3.text="TRANSPORTERID"

    # c4=Et.SubElement(b23,"TRANSPORTERNAME")
    # c4.text="TRANSPORTERNAME"

    # c5=Et.SubElement(b23,"TRANSPORTMODE")
    # c5.text="TRANSPORTMODE"

    # c6=Et.SubElement(b23,"VEHICLENUMBER")
    # c6.text="VEHICLENUMBER"

    # c7=Et.SubElement(b23,"VEHICLETYPE")
    # c7.text="VEHICLETYPE"

    # c8=Et.SubElement(b23,"DISTANCE")
    # c8.text="DISTANCE"
    debit = 0
    for i in items:

        m50=Et.Element("ALLINVENTORYENTRIES.LIST")
        root.append(m50)

        b23=Et.SubElement(m50,"STOCKITEMNAME")
        b23.text=str(i.product_code)

        b24=Et.SubElement(m50,"ISDEEMEDPOSITIVE")
        b24.text="No"

        b25=Et.SubElement(m50,"RATE")
        b25.text=str(i.rate)

        # b26=Et.SubElement(m50,"DISCOUNT")
        # b26.text="0"

        b27=Et.SubElement(m50,"AMOUNT")
        b27.text = str(i.amount)
        debit += i.amount
        b28=Et.SubElement(m50,"ACTUALQTY")
        b28.text=str(i.actual_qty)

        b29=Et.SubElement(m50,"BILLEDQTY")
        b29.text=str(i.actual_qty)

        b30=Et.SubElement(m50,"BATCHALLOCATIONS.LIST")

        c9=Et.SubElement(b30,"GODOWNNAME")
        c9.text="Primary"

        c10=Et.SubElement(b30,"BATCHNAME")
        c10.text=str(i.mrp)

        c11=Et.SubElement(b30,"AMOUNT")
        c11.text=str(i.amount)

        c12=Et.SubElement(b30,"ACTUALQTY")
        c12.text=str(i.actual_qty)

        c13=Et.SubElement(b30,"BILLEDQTY")
        c13.text=str(i.actual_qty)

        b31=Et.SubElement(m50,"ACCOUNTINGALLOCATIONS.LIST")

        c14=Et.SubElement(b31,"OLDAUDITENTRYIDS.LIST",{"TYPE":"Number"})

        d1=Et.SubElement(c14,"OLDAUDITENTRYIDS")
        d1.text="-1"


        c15=Et.SubElement(b31,"LEDGERNAME")
        c15.text="PURCHASE"

        c16=Et.SubElement(b31,"AMOUNT")
        c16.text=str(i.amount)


    # b32=Et.SubElement(m50,"EXPENSEALLOCATIONS.LIST")

    # c17=Et.SubElement(b32,"LEDGERNAME")
    # c17.text="LEDGERNAME"

    # c18=Et.SubElement(b32,"VATASSESSABLEAMOUNT")
    # c18.text="LEDGERNVATASSESSABLEAMOUNTAME"


    m51=Et.Element("INVOICEDELNOTES.LIST")
    root.append(m51)


    b32=Et.SubElement(m51,"BASICSHIPPINGDATE")
    b32.text=data.pi_no.pi_date.strftime('%Y%m%d')


    b33=Et.SubElement(m51,"BASICSHIPDELIVERYNOTE")
    b33.text=str(data.pi_no)

    m52=Et.Element("INVOICEORDERLIST.LIST")
    root.append(m52)


    # b34=Et.SubElement(m52,"BASICORDERDATE")
    # b34.text=data.pi_no.pi_date.strftime('%Y%m%d')


    # b35=Et.SubElement(m52,"BASICPURCHASEORDERNO")
    # b35.text= str(data.pi_no)


    m53=Et.Element("LEDGERENTRIES.LIST")
    root.append(m53)


    b36=Et.SubElement(m53,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c19=Et.SubElement(b36,"OLDAUDITENTRYIDS")


    b37=Et.SubElement(m53,"LEDGERNAME")
    b37.text=data.seller.name

    b38=Et.SubElement(m53,"AMOUNT")
    b38.text=str(-data.total)

    b39=Et.SubElement(m53,"BILLALLOCATIONS.LIST")

    c20=Et.SubElement(b39,"NAME")
    c20.text=str(data.pi_no.supplier_invoice)

    c21=Et.SubElement(b39,"BILLTYPE")
    c21.text="agst Ref"

    c22=Et.SubElement(b39,"AMOUNT")
    c22.text=str(-data.total)
    credit = data.total
    # c23=Et.SubElement(b39,"INTERESTCOLLECTION.LIST")
    # c23.text="INTERESTCOLLECTION.LIST"

    # c24=Et.SubElement(b39,"STBILLCATEGORIES.LIST")
    # c24.text="STBILLCATEGORIES.LIST"

    # if data.other_ledger:

    #     m54=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m54)

    #     b40=Et.SubElement(m54,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c25=Et.SubElement(b40,"OLDAUDITENTRYIDS")
    #     c25.text="OLDAUDITENTRYIDS"


    #     b41=Et.SubElement(m54,"LEDGERNAME")
    #     b41.text=str(data.other_ledger)

    #     b42=Et.SubElement(m54,"ISDEEMEDPOSITIVE")
    #     b42.text="No"

    #     b43=Et.SubElement(m54,"AMOUNT")
    #     b43.text=str(-data.other)
    #     debit += data.other

    if data.seller_gstin and data.seller_gstin[0:2] != '24':

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

        m56=Et.Element("LEDGERENTRIES.LIST")
        root.append(m56)

        b48=Et.SubElement(m56,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c27=Et.SubElement(b48,"OLDAUDITENTRYIDS")
        c27.text="-1"


        b49=Et.SubElement(m56,"LEDGERNAME")
        b49.text="CGST"

        b50=Et.SubElement(m56,"ISDEEMEDPOSITIVE")
        b50.text="No"

        b51=Et.SubElement(m56,"AMOUNT")
        b51.text=str(data.cgst)
        debit += data.cgst

        m57=Et.Element("LEDGERENTRIES.LIST")
        root.append(m57)

        b52=Et.SubElement(m57,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

        c28=Et.SubElement(b52,"OLDAUDITENTRYIDS")
        c28.text="-1"


        b53=Et.SubElement(m57,"LEDGERNAME")
        b53.text="SGST"

        b54=Et.SubElement(m57,"ISDEEMEDPOSITIVE")
        b54.text="No"

        b55=Et.SubElement(m57,"AMOUNT")
        b55.text=str(data.sgst)
        debit += data.cgst

    # if data.tcs > 0:

    #     m55=Et.Element("LEDGERENTRIES.LIST")
    #     root.append(m55)

    #     b44=Et.SubElement(m55,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    #     c26=Et.SubElement(b44,"OLDAUDITENTRYIDS")
    #     c26.text="OLDAUDITENTRYIDS"


    #     b45=Et.SubElement(m55,"LEDGERNAME")
    #     b45.text="TCS Payable"

    #     b46=Et.SubElement(m55,"ISDEEMEDPOSITIVE")
    #     b46.text="Yes"

    #     b47=Et.SubElement(m55,"AMOUNT")
    #     b47.text=str(-data.tcs)
    #     debit += data.tcs

    m58=Et.Element("LEDGERENTRIES.LIST")
    root.append(m58)

    b56=Et.SubElement(m58,"OLDAUDITENTRYIDS.LIST",{"Type":"Number"})

    c29=Et.SubElement(b56,"OLDAUDITENTRYIDS")
    c29.text= "-1"

    b57=Et.SubElement(m58,"LEDGERNAME")
    b57.text="Round Off"

    b58=Et.SubElement(m58,"ISDEEMEDPOSITIVE")
    b58.text="Yes"

    b59=Et.SubElement(m58,"AMOUNT")
    b59.text= str(credit - debit)

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str