from django.contrib import admin

from myapp.models import *
#from myapp.models import UserRegisterModel

# Register your models here.
admin.site.register(CategoryModel)
admin.site.register(QuestionModel)
admin.site.register(AnswerModel)
#admin.site.register(CategoryModel)