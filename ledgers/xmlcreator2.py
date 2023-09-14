import xml.etree.ElementTree as Et

from requests import request


def ledgerxml(data):
#LedgersType
    root = Et.Element("LEDGER",{"NAME":"Sales A/c1","RESERVEDNAME":""})

    m1=Et.Element("VATDEALERTYPE")
    m1.text="Regular"
    root.append(m1)

    m2=Et.Element("PARENT")
    m2.text="Sales Accounts"
    root.append(m2)

    m3=Et.Element("TCSAPPLICABLE")
    m3.text="Applicable"
    root.append(m3)

    m4=Et.Element("GSTAPPLICABLE")
    m4.text="Applicable"
    root.append(m4)

    m5=Et.Element("TAXCLASSIFICATIONNAME")
    root.append(m5)

    m6=Et.Element("TAXTYPE")
    m6.text="Others"
    root.append(m6)

    m7=Et.Element("GSTTYPEOFSUPPLY")
    m7.text="Services"
    root.append(m7)

    m8=Et.Element("ISTCSAPPLICABLE")
    m8.text="Yes"
    root.append(m8)

    m9=Et.Element("ISTDSAPPLICABLE")
    m9.text="No"
    root.append(m9)

    m10=Et.Element("ISGSTAPPLICABLE")
    m10.text="No"
    root.append(m10)

    m11=Et.Element("GSTDETAILS.LIST")
    m11.text="GSTDETAILS LIST"
    root.append(m11)


    m12=Et.Element("LANGUAGENAME.LIST")
    root.append(m12)

    b1=Et.SubElement(m12,"NAME.LIST",{"TYPE":"String"})

    b2=Et.SubElement(b1,"NAME")
    b2.text="Sales A/c1"


    c1=Et.SubElement(m12,"LANGUAGEID")
    c1.text="1033"


    m13=Et.Element("TCSCATEGORYDETAILS.LIST")
    root.append(m13)


    b3=Et.SubElement(m13,"CATEGORYDATE")
    b3.text="20210401"

    b4=Et.SubElement(m13,"CATEGORYNAME")
    b4.text="TCS @ 0.010%"

    m14=Et.Element("TDSCATEGORYDETAILS.LIST")
    m14.text= "TDSCATEGORYDETAILS.LIST"
    root.append(m14)

    xml_str = Et.tostring(root, encoding='unicode')
    return xml_str

def cmxml(data, request,vendor_code, group):
# Party_master
    root = Et.Element("LEDGER",{"NAME":data.name,"RESERVEDNAME":"","ACTION":"Create"})

    m1 = Et.Element("ADDRESS.LIST",{"Type":"String"})
    root.append (m1)

    b1 = Et.SubElement(m1, "ADDRESS")
    b1.text = data.addressline1
    b2 = Et.SubElement(m1, "ADDRESS")
    b2.text = data.addressline2 
    b3 = Et.SubElement(m1, "ADDRESS")
    b3.text = data.addressline3

    m2 = Et.Element("MAILINGNAME.LIST",{"Type":"String"})
    root.append (m2)
    c1 = Et.SubElement(m2, "MAILINGNAME")
    c1.text = data.name


    m3 = Et.Element("LEDSTATENAME")
    m3.text= data.state.name
    root.append (m3)

    m4 = Et.Element("COUNTRYNAME")
    m4.text = data.country.name
    root.append(m4)

    m5 = Et.Element("PINCODE")
    m5.text = data.pin_code
    root.append(m5)

    m6 = Et.Element("WEBSITE")
    m6.text = data.website
    root.append(m6)

    m7 = Et.Element("INCOMETAXNUMBER")
    m7.text = data.pan_no
    root.append(m7)

    m8 = Et.Element("GSTREGISTRATIONTYPE")
    m8.text = data.gst_registration_type
    root.append(m8)

    m9 = Et.Element("PARENT")
    m9.text = group.name
    root.append(m9)


    m10 = Et.Element("CREATEDBY")
    m10.text = str(request.user)
    root.append(m10)


    m11 = Et.Element("BILLCREDITPERIOD")
    m11.text = data.dafault_credit_period
    root.append(m11)


    m12 = Et.Element("EMAIL")
    m12.text = data.email_id
    root.append(m12)


    m13 = Et.Element("EMAILCC")
    m13.text = data.cc_email
    root.append(m13)

    m14 = Et.Element("LEDGERPHONE")
    m14.text = data.phone_no
    root.append(m14)

    m15 = Et.Element("LEDGERFAX")
    m15.text = data.fax_no
    root.append(m15)

    m16 = Et.Element("LEDGERCONTACT")
    m16.text = data.contact_person
    root.append(m16)

    m17 = Et.Element("LEDGERMOBILE")
    m17.text = data.mobile_no
    root.append(m17)

    m18 = Et.Element("PARTYGSTIN")
    m18.text = data.gstin
    root.append(m18)

    m19 = Et.Element("ISBILLWISEON")
    d = 'y'
    m19.text = d 
    root.append(m19)

    m20 = Et.Element("CREDITLIMIT")
    m20.text = data.credit_limit
    root.append(m20)

    m21 = Et.Element("LANGUAGENAME.LIST")
    root.append(m21)

    c1 = Et.SubElement(m21, "NAME.LIST",{"TYPE":"String"})

    d1 = Et.SubElement(c1, "NAME")
    d1.text = data.name

    m22 = Et.Element("PAYMENTDETAILS.LIST")
    root.append(m22)

    e1 = Et.SubElement(m22, "IFSCODE")
    e1.text = data.ifsc_code

    e2 = Et.SubElement(m22, "BANKNAME")
    e2.text = data.bank

    e3 = Et.SubElement(m22, "ACCOUNTNUMBER")
    e3.text = data.account_no

    e4 = Et.SubElement(m22, "PAYMENTFAVOURING")
    e4.text = data.account_name

    e5 = Et.SubElement(m22, "TRANSACTIONNAME")
    e5.text = "Primary"

    e6 = Et.SubElement(m22, "SETASDEFAULT")
    e6.text = "No"

    e7 = Et.SubElement(m22, "DEFAULTTRANSACTIONTYPE")
    e7.text = ''

    m23 = Et.Element("LEDMULTIADDRESSLIST.LIST")
    root.append(m23)

    e8 = Et.SubElement(m23, "ADDRESS.LIST" ,{"Type":"String"})

    f1 =Et.SubElement(e8, "ADDRESS")
    f1.text = "M- Address1"

    f2 =Et.SubElement(e8, "ADDRESS")
    f2.text = "M- Address2"

    f3 =Et.SubElement(e8, "ADDRESS")
    f3.text = "M- Address3"

    e9 = Et.SubElement(m23, "EMAIL")
    e9.text = "M-MAIL"
    e10 = Et.SubElement(m23, "PINCODE")
    e10.text = "M-PINCODE"
    e11= Et.SubElement(m23, "PHONENUMBER")
    e11.text = "M-PHONE"
    e12= Et.SubElement(m23, "MOBILENUMBER")
    e12.text = "M-MOB"
    e13 = Et.SubElement(m23, "FAXNUMBER")
    e13.text = "M-FAX"
    e14 = Et.SubElement(m23, "INCOMETAXNUMBER")
    e14.text = "M-PANCARD"
    e15 = Et.SubElement(m23, "COUNTRYNAME")
    e15.text = "M-COUNTRY"
    e16 = Et.SubElement(m23, "ADDRESSNAME")
    e16.text = "M-ADDRESSNAME"
    e17 = Et.SubElement(m23, "PARTYGSTIN")
    e17.text = "M-GSTIN"
    e18 = Et.SubElement(m23, "CONTACTPERSON")
    e18.text = "M-CONTACTPERSON"
    e19 = Et.SubElement(m23, "STATE")
    e19.text = "M-STATE"


    m24 = Et.Element("UDF:PAYMENTTERMS",{"DESC":"`PaymentTerms`"})
    m24.text = data.payment_terms
    root.append(m24)

    m25 = Et.Element("UDF:LEDPARTYTYPE ",{"DESC":"`LedPartyType`"})
    m25.text = data.party_type.name
    root.append(m25)

    m26 = Et.Element("UDF:VENDORCODE",{"DESC":"`Vendor Code`"})
    m26.text = str(vendor_code)
    root.append(m26)

    m27 = Et.Element("UDF:LEDZONE1",{"DESC":"`LEDZONE1`"})
    m27.text = data.region.name
    root.append(m27)

    m28 = Et.Element("UDF:LEDZSM",{"DESC":"`LEDZSM`"})
    m28.text = data.zsm.name
    root.append(m28)

    m29 = Et.Element("UDF:LEDASM",{"DESC":"`LEDASM`"})
    m29.text = data.asm.name
    root.append(m29)

    m30 = Et.Element("UDF:LEDSE",{"DESC":"`LEDSE`"})
    m30.text = data.se.name
    root.append(m30)

    m31 = Et.Element("UDF:LEDREGION",{"DESC":"`LEDRegion`"})
    m31.text = data.zone.name
    root.append(m31)

    m32 = Et.Element("LEDCITYINP",{"DESC":"`LEDCITYINP`"})
    m32.text = data.city.name
    root.append(m32)

    xml_str = Et.tostring(root, encoding='unicode')
    return xml_str