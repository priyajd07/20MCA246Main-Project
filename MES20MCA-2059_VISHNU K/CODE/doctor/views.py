from django.shortcuts import render
from doctor.models import Doctor
from login.models import Login

# Create your views here.
def doc_reg(request):
    if request.method == "POST":
        obj = Doctor()
        obj.doctor_name = request.POST.get('name')
        obj.address = request.POST.get('addr')
        obj.phone = request.POST.get('phone')
        obj.email = request.POST.get('email')
        obj.username = request.POST.get('username')
        obj.password = request.POST.get('password')
        obj.save()

        obb = Login()
        obb.username = request.POST.get('username')
        obb.password = request.POST.get('password')
        obb.type = 'doc'
        obb.u_id = obj.d_id
        obb.save()

    return render(request, 'doctor/doc_reg.html')

def doc(request):
    return render(request, 'doctor/doctor.html')