
class CompanyId():

    def __init__(self, request):

        self.session = request.session

        company = self.session.get('skey')

        if 'skey' not in request.session:
            company = self.session['skey'] = {}

        self.company = company


    def add(self, company):

        events = {'id': company.id,'name':company.name}
        self.company['company'] = events

        self.session.modified = True