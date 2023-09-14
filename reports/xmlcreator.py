import xml.etree.ElementTree as Et 
from datetime import datetime

def paymentPayablexml(data):
	root = Et.Element("ENVELOPE")
	    
	m1 = Et.Element("HEADER")
	root.append (m1)
	    
	b1 = Et.SubElement(m1, "TALLYREQUEST")

	b1.text = "Export Data"

	m2 = Et.Element("BODY")
	root.append (m2)

	b2= Et.SubElement(m2,"EXPORTDATA")
	b3=Et.SubElement(b2,"REQUESTDESC")
	b4=Et.SubElement(b3,"STATICVARIABLES")
	c1=Et.SubElement(b4,"SVViewName")
	c1.text="Accounting Voucher View"

	c2=Et.SubElement(b4,"SVFROMDATE")
	c2.text="01-04-2022"

	c3=Et.SubElement(b4,"SVTODATE")
	c3.text=datetime.now().strftime('%d-%m-%Y')

	c4=Et.SubElement(b4,"SVEXPORTFORMAT")
	c4.text="$$SysName:xml"

	c5=Et.SubElement(b4,"SVCURRENTCOMPANY")
	c5.text="ABC Company"

	b5=Et.SubElement(b3,"REPORTNAME")
	b5.text="Bills Receivable"



	    
	tree = Et.ElementTree(root)

	xml_str = Et.tostring(root, encoding='unicode')

	return xml_str