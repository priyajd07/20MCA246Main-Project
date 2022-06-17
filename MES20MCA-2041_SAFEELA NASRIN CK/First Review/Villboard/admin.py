from django.contrib import admin
from account.forms import MemberForm
from account.models import *

# Register your models here.
admin.site.register(UserRegisterModel)
admin.site.register(AddMemberModel)
admin.site.register(PetModel)
admin.site.register(VehicleModel)
admin.site.register(VisitorModel)
admin.site.register(DonationModel)