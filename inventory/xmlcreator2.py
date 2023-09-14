import xml.etree.ElementTree as Et


#----------------------------------------------------------------------------------------------- Brand XML

def brandxml(data):
#Brand
    root = Et.Element("STOCKGROUP",{"NAME":data["name"][0],"RESERVEDNAME":""})

    j1=Et.Element("PARENT")
    j1.text=""
    root.append(j1)

    m4 =Et.Element("LANGUAGENAME.LIST")
    root.append(m4)

    b1=Et.SubElement(m4,"NAME.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b1,"NAME")
    c1.text=data["name"][0]

    m5 =Et.Element("UDF:CODE.LIST")
    root.append(m5)

    b2=Et.SubElement(m5,"UDF:CODE",{"DESC":"Code"})
    b2.text=data["group_code"][0]

    xml_str = Et.tostring(root, encoding='unicode')
    return xml_str

#----------------------------------------------------------------------------------------------- Category XML

def categoryxml(data):
#category    
    root = Et.Element("STOCKCATEGORY",{"NAME":data["name"][0],"RESERVEDNAME":""})

    j1=Et.Element("PARENT")
    j1.text=""
    root.append(j1)

    m4 =Et.Element("LANGUAGENAME.LIST")
    root.append(m4)

    b1=Et.SubElement(m4,"NAME.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b1,"NAME")
    c1.text=data["name"][0]

    b2=Et.SubElement(m4,"LANGUAGEID")
    b2.text="1033"

    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str

#----------------------------------------------------------------------------------------------- Godown XML

def godownxml(data):
#Godown    
    root = Et.Element("GODOWN",{"NAME":data["name"][0],"RESERVEDNAME":""})

    j1=Et.Element("PARENT")
    if data["under"][0] == "Primary":
        j1.text=''    
    else:
        j1.text=data["under"][0]
    root.append(j1)

    m18=Et.Element("LANGUAGENAME.LIST")

    root.append(m18)

    b1=Et.SubElement(m18,"NAME.LIST",{"TYPE":"String"})

    c1=Et.SubElement(b1,"NAME")
    c1.text=data["name"][0]

    m19=Et.Element("UDF:GODOWNTYPE.LIST")
    root.append(m19)

    m20=Et.SubElement(m19,"UDF:GODOWNTYPE",{"DESC":"`GodownType`"})
    if data.get("type"):
        m20.text="SALEABLE"
    else:
        m20.text="NON-SALEABLE"
    xml_str = Et.tostring(root,encoding='unicode')

    return xml_str

#----------------------------------------------------------------------------------------------- UOM XML

def uomxml(data):
#UNitsofMeasurwe    
    root = Et.Element("UNIT",{"NAME":data["symbol"][0],"RESERVEDNAME":""})
    
    m1 = Et.Element("NAME")
    m1.text=data["symbol"][0]
    root.append (m1)
    
    n = Et.Element("ORIGINALNAME")
    n.text=data["name"][0]
    root.append (n)

    m2 = Et.Element("GSTREPUOM")
    m2.text=data["under"][0]
    root.append (m2)
    
    m4 = Et.Element("ISSIMPLEUNIT")
    m4.text="Yes"
    root.append (m4)
        
    m3 = Et.Element("DECIMALPLACES")
    m3.text=data["decimal"][0]
    root.append (m3)
        
    xml_str = Et.tostring(root, encoding='unicode')

    return xml_str

#----------------------------------------------------------------------------------------------- Sales XML

def pmxml(data):
#produictMaster
	root = Et.Element("STOCKITEM",{"NAME": data.product_code ,"RESERVEDNAME":""})

	j1=Et.Element("MAILINGNAME.LIST",{"TYPE":"String"})
	root.append(j1)
	 
	j2 = Et.SubElement(j1,"MAILINGNAME")
	j2.text=data.product_code


	m2=Et.Element("PARENT")
	m2.text=data.brand.name
	root.append(m2)

	m3=Et.Element("CATEGORY")
	m3.text=data.category.name
	root.append(m3)

	m4=Et.Element("NARRATION")
	m4.text=''
	root.append(m4)

	m5=Et.Element("TCSAPPLICABLE")
	m5.text="Applicable"
	root.append(m5)

	m6=Et.Element("GSTAPPLICABLE")
	m6.text="Applicable"
	root.append(m6)

	m7=Et.Element("DESCRIPTION")
	m7.text=data.description
	root.append(m7)

	m8=Et.Element("GSTTYPEOFSUPPLY")
	m8.text="Goods"
	root.append(m8)

	m9=Et.Element("COSTINGMETHOD")
	m9.text="Avg .Cost"
	root.append(m9)

	m10=Et.Element("VALUATIONMETHOD")
	m10.text="Avg.Price"
	root.append(m10)

	m11=Et.Element("BASEUNITS")
	m11.text="No"
	root.append(m11)

	m12=Et.Element("ADDITIONALUNITS")
	m12.text="kgs"
	root.append(m12)

	m13=Et.Element("TCSCATEGORY")
	m13.text="TSC @ 0.010%"
	root.append(m13)

	m14=Et.Element("ISBATCHWISEON")
	m14.text="Yes"
	root.append(m14)

	m15=Et.Element("ISPERISHABLEON")
	m15.text="Yes"
	root.append(m15)

	m16=Et.Element("ALTERID")
	m16.text="2732"
	root.append(m16)

	m17=Et.Element("DENOMINATOR")
	m17.text="10"
	root.append(m17)

	m18=Et.Element("CONVERSION")
	m18.text="1"
	root.append(m18)

	m19=Et.Element("GSTDETAILS.LIST")
	root.append(m19)

	b1=Et.SubElement(m19,"APPLICABLEFROM")
	b1.text="20170701"

	b2=Et.SubElement(m19,"CALCULATIONTYPE")
	b2.text="On Value"

	b3=Et.SubElement(m19,"HSNCODE")
	b3.text=data.hsn

	b4=Et.SubElement(m19,"HSNMASTERNAME")
	b4.text=data.gstdetails.last.discription

	b5=Et.SubElement(m19,"TAXABILITY")
	b5.text=data.gstdetails.last.taxability

	b6=Et.SubElement(m19,"ISREVERSECHARGEAPPLICABLE")
	b6.text="No"

	b7=Et.SubElement(m19,"ISNONGSTGOODS")
	b7.text="No"

	b8=Et.SubElement(m19,"GSTINELIGIBLEITC")
	b8.text="No"

	b9=Et.SubElement(m19,"INCLUDEEXPFORSLABCALC")
	b9.text="No"

	b10=Et.SubElement(m19,"STATEWISEDETAILS.LIST")


	c1=Et.SubElement(b10,"STATENAME")
	c1.text="Any"

	c2=Et.SubElement(b10,"RATEDETAILS.LIST")

	d1=Et.SubElement(c2,"GSTRATEDUTYHEAD")
	d1.text="Central Tex"

	d2=Et.SubElement(c2,"GSTRATEVALUATIONTYPE")
	d2.text="Based On Value"

	d3=Et.SubElement(c2,"GSTRATE")
	d3.text="9"


	c3=Et.SubElement(b10,"RATEDETAILS.LIST")



	d4=Et.SubElement(c3,"GSTRATEDUTYHEAD")
	d4.text="State Tax"

	d5=Et.SubElement(c3,"GSTRATEVALUATIONTYPE")
	d5.text="Based On Value"

	d6=Et.SubElement(c3,"GSTRATE")
	d6.text="9"

	c4=Et.SubElement(b10,"RATEDETAILS.LIST")



	d7=Et.SubElement(c4,"GSTRATEDUTYHEAD")
	d7.text="Integrated Tax"

	d8=Et.SubElement(c4,"GSTRATEVALUATIONTYPE")
	d8.text="Based On Value"

	d9=Et.SubElement(c4,"GSTRATE")
	d9.text="18"

	c5=Et.SubElement(b10,"RATEDETAILS.LIST")


	d10=Et.SubElement(c5,"GSTRATEDUTYHEAD")
	d10.text="Cess"

	d11=Et.SubElement(c5,"GSTRATEVALUATIONTYPE")
	d11.text="Based On Value"

	c6=Et.SubElement(b10,"RATEDETAILS.LIST")


	d12=Et.SubElement(c6,"GSTRATEDUTYHEAD")
	d12.text="Cess on qty"

	d13=Et.SubElement(c6,"GSTRATEVALUATIONTYPE")
	d13.text="Based On Quantity"

	c7=Et.SubElement(b10,"RATEDETAILS.LIST")

	d14=Et.SubElement(c7,"GSTRATEDUTYHEAD")
	d14.text="State Cess"

	d15=Et.SubElement(c7,"GSTRATEVALUATIONTYPE")
	d15.text="Based On Value"

	c8=Et.SubElement(b10,"GSTSLABRATES.LIST")
	c8.text="GSTSLABRATES.LIST"


	b11=Et.SubElement(m19,"TEMPGSTDETAILSLABRATES.LIST")
	b11.text="TEMPGSTDETAILSLABRATES"

	m20=Et.Element("LANGUAGENAME.LIST")
	root.append(m20)

	b12=Et.SubElement(m20,"NAME.LIST",{"TYPE":"`String`"})


	c9=Et.SubElement(b12,"NAME")
	c9.text=data.product_name

	m21=Et.Element("SCHVIDETAILS")
	m21.text="SCHVIDETAILS"
	root.append(m21)

	m22=Et.Element("EXCISETARIFFDETAILS.LIST")
	m22.text="EXCISETARIFFDETAILS.List"
	root.append(m22)

	m23=Et.Element("TCSCATEGORYDETAILS.LIST")
	root.append(m23)
	 
	b13=Et.SubElement(m23,"CATEGORYDATE")
	b13.text="20201001"

	b14=Et.SubElement(m23,"CATEGORYNAME")
	b14.text="TCS@ 0.010%"

	m24=Et.Element("TDSACATEGORYDETAILS.LIST")
	root.append(m24)
	 
	b15=Et.SubElement(m24,"CATEGORYDATE")
	b15.text="20210401"

	b16=Et.SubElement(m24,"CATEGORYNAME")
	b16.text="ANY"

	m25=Et.Element("MRPDETAILS.LIST")
	root.append(m25)
	 
	b15=Et.SubElement(m25,"FROMDATE")
	b15.text="20210501"

	b16=Et.SubElement(m25,"MRPRATEDETAILS:LIST")

	c10=Et.SubElement(b16,"STATENAME")
	c10.text="Arunachal Pradesh"

	c11=Et.SubElement(b16,"MRPRATE")
	c11.text="900.00 / NO"

	b17=Et.SubElement(m25,"MRPRATEDETAILS:LIST")
	b17.text="MRPRATEDETAILS:LIST"

	m26=Et.Element("COMPONENTLIST.LIST")
	m26.text="COMPONENTLIST.LIST"
	root.append(m26)

	m27=Et.Element("ADDITIONALLEDGERS.LIST")
	m27.text="ADDITIONALLEDGERS.LIST"
	root.append(m27)

	m28=Et.Element("SALESLIST.LIST")
	root.append(m28)

	b18=Et.SubElement(m28,"NAME")
	b18.text=data.dl_sales.name

	b19=Et.SubElement(m28,"CLASSRATE")
	b19.text="100.00000"

	b20=Et.SubElement(m28,"LEDGERFROMITEM")
	b20.text="NO"

	b21=Et.SubElement(m28,"REMOVEZEROENTRIES")
	b21.text="Yes"

	b22=Et.SubElement(m28,"DUTYHEADDETAILS.LIST")
	b22.text="DUTYHEADDETAILS.LIST"


	m29=Et.Element("PURCHASELIST.LIST")
	root.append(m29)

	b23=Et.SubElement(m29,"NAME")
	b23.text=data.dl_purchase.name

	b24=Et.SubElement(m29,"CLASSRATE")
	b24.text="100.00000"

	b25=Et.SubElement(m29,"LEDGERFROMITEM")
	b25.text="NO"

	b26=Et.SubElement(m29,"REMOVEZEROENTRIES")
	b26.text="Yes"

	b27=Et.SubElement(m29,"DUTYHEADDETAILS.LIST")
	b27.text="DUTYHEADDETAILS.LIST"

	m30=Et.Element("FULLPRICELIST.LIST")
	m30.text="FULLPRICELIST"
	root.append(m30)

	m31=Et.Element("BATCHALLOCATIONS.LIST")
	m31.text="BATCHALLOCATIONS"
	root.append(m31)

	m32=Et.Element("TRADEREXCISEDUTIES.LIST")
	m32.text="TRADEREXCISEDUTIES"
	root.append(m32)

	m33=Et.Element("STANDARDCOSTLIST.LIST")
	root.append(m33)

	b28=Et.SubElement(m33,"DATE")
	b28="20210401"

	b29=Et.SubElement(m33,"RATE")
	b29.text="500.00 / NO"

	m34=Et.Element("STANDARDPRICELIST.LIST")
	root.append(m34)

	b30=Et.SubElement(m34,"DATE")
	b30="20210401"

	b31=Et.SubElement(m34,"RATE")
	b31.text="700.00 / NO"

	m35=Et.Element("MULTICOMPONENTLIST.LIST")
	root.append(m35)

	b32=Et.SubElement(m35,"COMPONENTLISTNAME")
	b32.text="12"

	b33=Et.SubElement(m35,"COMPONENTBASICQTY")
	b33.text="1.0000 No"

	b34=Et.SubElement(m35,"MULTICOMPONENTITEMLIST")

	c12=Et.SubElement(b34,"NATUREOFITEM")
	c12.text="Component"

	c13=Et.SubElement(b34,"STOCKITEMNAME")
	c13.text="Electronics"

	c14=Et.SubElement(b34,"ACTUALQTY")
	c14.text="1.0000 No"

	m36=Et.Element("UDF:STOCKPACKSIZE",{"DESC":"Stockpacksize"})
	m36.text="18"
	root.append(m36)

	m37=Et.Element("UDF:PORTFOLIO",{"DESC":"PORTFOLIO"})
	m37.text="12"
	root.append(m37)

	m38=Et.Element("UDF:STKICLASS",{"DESC":"STKI Class"})
	m38.text="Art Supplies"
	root.append(m38)

	m39=Et.Element("UDF:STKISUBCLASS",{"DESC":"STKI Sub Class"})
	m39.text="Art Kit"
	root.append(m39)

	m40=Et.Element("UDF:STKISUBBRAND",{"DESC":"STKI Sub Brand"})
	m40.text="S5256"
	root.append(m40)

	m41=Et.Element("UDF:STKITYPE")
	m41.text="Finish Product"
	root.append(m41)

	m42=Et.Element("UDF:STKISHAPECODE")
	m42.text="1"
	root.append(m42)



	m44=Et.Element("UDF:STKISIZE",{"DESC":"STKI Size"})
	m44.text="2"
	root.append(m44)

	m45=Et.Element("UDF:STKISTYLE",{"DESC":"STKI Style"})
	m45.text="3"
	root.append(m45)

	m46=Et.Element("UDF:STKISERIES",{"DESC":"STKI Series"})
	m46.text="4"
	root.append(m46)

	m47=Et.Element("UDF:STKIPATTERN",{"DESC":"STKI Pattern"})
	m47.text="5"
	root.append(m47)

	m48=Et.Element("UDF:STKICOO",{"DESC":"STKI COO"})
	m48.text="6"
	root.append(m48)

	m49=Et.Element("UDF:STKICOLOUR",{"DESC":"STKI COLOUR"})
	m49.text="7"
	root.append(m49)

	m50=Et.Element("UDF:STKIINNER",{"DESC":"STKI INNER"})
	m50.text="8"
	root.append(m50)

	m51=Et.Element("UDF:STKIIMPORT",{"DESC":"STKI Import"})
	m51.text="9"
	root.append(m51)

	m52=Et.Element("UDF:STKIMFG",{"DESC":"STKI MFG"})
	m52.text="10"
	root.append(m52)

	m53=Et.Element("UDF:STKIMARKET",{"DESC":"STKI market"})
	m53.text="11"
	root.append(m53)

	m54=Et.Element("UDF:OLDSKUCODE",{"DESC":"OldSkuCode"})
	m54.text="OLDSKUCODE"
	root.append(m54)

	m55=Et.Element("UDF:EANCODE",{"DESC":"EAN CODE"})
	m55.text="EANCODE"
	root.append(m55)

	m56=Et.Element("UDF:ALUCODE",{"DESC":"ALUCODE"})
	m56.text="ALUCODE"
	root.append(m56)

	xml_str = Et.tostring(root,encoding='unicode')
	return xml_str