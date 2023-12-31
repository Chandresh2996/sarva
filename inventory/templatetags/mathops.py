from decimal import Decimal, InvalidOperation
from django import template

register = template.Library()

@register.filter(name='divide')
def divide(value, arg):
    try:
        return Decimal(value) / Decimal(arg)
    except (ValueError, ZeroDivisionError):
        return None

@register.filter(name='percentage')
def percentage(value, arg):
    try:
        return round((value/arg)*100, 2)
    except (TypeError,ZeroDivisionError):
        return 0

@register.filter(name='perc')
def perc(value, arg):
    try:
        return round((value*arg)/100, 2)
    except (TypeError, ZeroDivisionError):
        return value

@register.filter(name='subtract')
def subtract(value, arg):
    try:
        return int(value) - int(arg)
    except (ValueError):
        return None
@register.filter(name='multiply')
def multiply(value, arg):
    return round(Decimal(value) * Decimal(arg),2)

@register.filter(name='addition')
def add(value, arg):
    try:
        return Decimal(value) + Decimal(arg)
    except TypeError:
        return value

@register.filter(name='dis')
def dis(value, arg):
    return round(Decimal(value) / ((100-Decimal(arg))/100),2)


@register.filter(name='has_group')
def has_group(user, group_name):
    return user.groups.filter(name=group_name).exists()

@register.filter(name="keyvalue")
def keyvalue(dict, key):
    data = dict.get(key)
    if data:
        return data
    else:
        return [{'division':'0'}]

@register.filter(name="has_year")
def has_year(dict, key):
    data = dict.get(int(key))
    if data:
        return data
    else:
        return [{'division':'0'}]     

@register.filter(name="has_qua")
def has_qua(list, key):
    data = []
    for i in list:
        if i['quarter'] == key:
            data.append(i)
    return data

@register.filter(name="has_div")
def has_div(lst, key):
    for i in lst:
        if i.get('division') == key:
            return i
    return {'total':0}
@register.filter(name="has_basic")
def has_basic(list, key):
    for i in list:
        if i['division'] == key:
            return i.get('ammount')

@register.filter(name="has_channel")
def has_channel(list, key):
    for i in list:
        if i['channel'] == key:
            return i

@register.filter(name="has_total")
def has_total(list, key):
    for i in list:
        if i['division'] == key:
            return i.get('total')

@register.filter(name="has_mrp")
def has_mrp(list, key):
    for i in list:
        if i['division'] == key:
            return i.get('mrpvalue')

@register.filter(name="has_week")
def has_week(list, key):
    for i in list:
        if str(i['week']) == key:
            return i

@register.filter(name="has_month")
def has_month(list, key):
    for i in list:
        if str(i['month']) == str(key)[:10]:
            return i

@register.filter(name="has_zone")
def has_zone(list, key):
    for i in list:
        if i['inv__buyer__zone__name'] == str(key):
            return i

@register.filter(name="has_buyer")
def has_zone(list, key):
    for i in list:
        if i['inv__buyer__name'] == str(key):
            return i

@register.filter(name="has_quarter")
def has_quarter(list, key):
    for i in list:
        if str(i['quarter']) == (key):
            return i

@register.filter(name="has_target")
def has_target(list, key):
    for i in list:
        if str(i['month']) == str(key)[:10] and i.get('target'):
            return i

@register.filter(name="has_divq1")
def has_divq1(lst, key):
    for i in lst:
        if i.get('division') == key and i.get('quarter') == 1:
            return i

@register.filter(name="has_divq2")
def has_divq2(lst, key):
    for i in lst:
        if i.get('division') == key and i.get('quarter') == 2:
            return i
        
@register.filter(name="has_divq3")
def has_divq3(lst, key):
    for i in lst:
        if i.get('division') == key and i.get('quarter') == 3:
            return i

@register.filter(name="has_divq4")
def has_divq4(lst, key):
    for i in lst:
        if i.get('division') == key and i.get('quarter') == 4:
            return i