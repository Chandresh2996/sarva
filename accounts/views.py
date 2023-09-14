from django.shortcuts import get_object_or_404, render
from django.http import JsonResponse
from django.http import HttpResponseRedirect
from django.contrib.auth.forms import UserCreationForm
from django.urls import reverse_lazy
from django.contrib import messages
# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from django.views.generic.edit import CreateView
from django.dispatch import receiver
from django.db.models.signals import pre_save
from django.contrib.auth.models import User
from .company import CompanyId
from company.models import Company as Com

from django.contrib.auth.forms import PasswordChangeForm

# @receiver(pre_save, sender=User)
# def set_new_user_inactive(sender, instance, **kwargs):
#     if instance._state.adding is True:
#         print("Creating Inactive User")
#         instance.is_active = False
#     else:
#         print("Updating User Record")


class Register(CreateView):
    template_name = 'registration/register.html'
    form_class = UserCreationForm
    success_url = reverse_lazy('register-success')

    def form_valid(self, form):
        form.save()
        return HttpResponseRedirect(self.success_url)
@csrf_exempt
def Company_data(request):
    com = CompanyId(request)

    if request.POST.get('action') == 'post':
        id = int(request.POST.get('id'))
        company = get_object_or_404(Com, id =id)

        com.add(company=company)
        i={'id': company.id,'name':company.name}

        response = JsonResponse(i)
        return response

def user_change_pass(request):
    if request.method == "POST":
        fm = PasswordChangeForm(user=request.user, data=request.POST)
        if fm.is_valid():
            fm.save()
            messages.success(request, 'Password Changed Successfully')
            return HttpResponseRedirect('/logout/')
    else:
        fm = PasswordChangeForm(user=request.user)
    return render(request, 'changepass.html', {'form': fm})