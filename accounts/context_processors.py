from .company import CompanyId
import datetime

def company_id(request):

    return {'sid' : CompanyId(request)}

def date(request):
    x = datetime.datetime.today()
    return {'date':x}

def enddate(request):
    x = datetime.datetime.today() + datetime.timedelta(days=7)
    return {'enddate':x}
