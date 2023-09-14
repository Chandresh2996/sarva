from email import message
from django.core.mail import EmailMessage
from django.shortcuts import render
from core import settings
from django.template.loader import get_template
from django.template import Context

def send_email(request, email,email_cc, subject, attach, attachname):
	
    message = get_template("email.html").render({'message':subject,'reply': email_cc})
    try:
        mail = EmailMessage(subject, message,settings.EMAIL_HOST_USER, [email], cc= email_cc,reply_to = email_cc)
        mail.attach(attachname, attach.rendered_content, 'application/pdf')
        mail.content_subtype = "html"
        mail.send()
        return "message"
    except Exception as e:
        print(e)
        return render(request,'Error.html', {'message': 'Either the attachment is too  big or corrupt'})
