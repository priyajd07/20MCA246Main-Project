import email
from django import views
from django.shortcuts import render,redirect
from django.views.generic import TemplateView,View
from matplotlib import image
from matplotlib.pyplot import title
from matplotlib.style import context
from requests import request
from account.models import*
from account.forms import*
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.forms import AuthenticationForm

import razorpay
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseBadRequest
# Create your views here.

# Home page
class IndexView(TemplateView):
	template_name='index.html'
 
 #.......Admin DashBoard........
 
class AdmindashView(TemplateView):
    	template_name='admin/AdminIndex.html'

# ....Users Registration..

def adduser(request):
	if request.method=="POST":
		form=UserRegisterForm(request.POST)
		extend_form=ExtendedUserForm(request.POST)

		if form.is_valid() and extend_form.is_valid():
			user=form.save()
			extended_profile=extend_form.save(commit=False)
			extended_profile.user=user
			extended_profile.save()

			username_var=form.cleaned_data.get('username')
			password_var=form.cleaned_data.get('password1')
			user=authenticate(username=username_var,password=password_var)

			login(request,user)
			return redirect ('home')

	else:
		form=UserRegisterForm(request.POST)
		extend_form=ExtendedUserForm(request.POST)

	context={"form":form,"extend_form":extend_form}
	return render(request,'trialreg.html',context)

# .....Login Page & LogOut...

class UserLogin(View):
	def get(self,request):
		form=AuthenticationForm()
		context={'form':form}
		return render(request,'login.html',context)

	def post(self,request):
		username=request.POST.get('username')
		password=request.POST.get('password')
		user=authenticate(username=username,password=password)
		if user is not None :
			login(request,user)
			if user.is_superuser == True and user.is_staff == True:
				return redirect('admindash')
			if user.is_staff == True and user.is_superuser == False:
				return redirect('staff')
			if user.is_staff == False and user.is_superuser == False:
				return redirect ('house')
		else:
			form=AuthenticationForm()
			context={'form':form}
			return render(request,'login.html',context)

def logout_view(request):
    logout(request)

    return redirect('home')

#........Visitors registration....
 
class VisitorView(View):
        template_name='visitor.html'
        
        def get(self,request):
            context={'form':VisitorForm}
            return render(request,self.template_name,context)
        
        def post(self,request):
         username=request.user
         name=request.POST.get('name')
         email=request.POST.get('email')
         address=request.POST.get('address')
         phone_no=request.POST.get('phone_no')
    
         Visitor=VisitorModel.objects.create(
            username=username,
            name=name,
            email=email,
            address=address,
            phone_no=phone_no,
             
            )
         return redirect("home") 
     
#.....Staff Home page

class StaffView(TemplateView):
    	template_name='staff/staffdash.html'
      
     
class StaffListView(View):
    template_name="staff/visitorslist.html"
    def get(self,request):
        user_data=VisitorModel.objects.all();
        context={'data':user_data}
        return render(request,self.template_name,context)    


    	
class UserView(View):
    template_name="list.html"
    def get(self,request):
        user_data=AddMemberModel.objects.filter(house_no=916);
        context={'data':user_data}
        return render(request,self.template_name,context)
    		 		  

#.....House Management Home Page....

class HouseView(TemplateView):
    	template_name='user/house.html'
            

# ....Adding Members... 

class MemberView(View):
    template_name='user/member.html'
    
    def get(self,request):
        context={'form':MemberForm}
        return render(request,self.template_name,context)
    
    def post(self,request):
        
        username=request.user
        house_no=request.POST.get('house_no')
        name=request.POST.get('name')
        age=request.POST.get('age')
        adhaar_no=request.POST.get('adhaar_no')
        designation=request.POST.get(' designation')
        
        AddMemberModel.objects.create(
            house_no=house_no,
			username=username,
   			name=name,
      		age=age,
        	adhaar_no=adhaar_no,
         	designation=designation
		) 
        return redirect("house")
     #..end Add member.. 
     
#........Pet registration....
 
class PetView(View):
        template_name='user/pet.html'
        
        def get(self,request):
            context={'form':PetForm}
            return render(request,self.template_name,context)
        
        def post(self,request):
         username=request.user
         name=request.POST.get('name')
         type=request.POST.get('type')
         Is_vaccinated=request.POST.get('Is_vaccinated')
         image=request.FILES.get('image')
         if Is_vaccinated=='on':
             Is_vaccinated=True
         else:
             Is_vaccinated=False
         
         Pet=PetModel.objects.create(
            username=username,
            name=name,
            type=type,
            Is_vaccinated=Is_vaccinated,
            image=image)
         return redirect("pet")  

#Vehicle Registration View

class VehicleView(View):
        template_name='user/vehicle.html'
        
        def get(self,request):
            context={'form':VehicleForm}
            return render(request,self.template_name,context)
        
        def post(self,request):
            username=request.user
            name=request.POST.get('name')
            email=request.POST.get('email')
            address=request.POST.get('address')
            phone_no=request.POST.get('phone_no')
            car_model=request.POST.get('car_model')
            plate_number=request.POST.get('plate_number')
            image=request.FILES.get('image')
       
          
            VehicleModel.objects.create(
                username=username,
                name=name,
                email=email,
                address=address,
                phone_no=phone_no,
                car_model=car_model,
                plate_number=plate_number,
                image=image)
            return redirect("vehicle") 
    
 # Donation payment
class DonationView(View):
    template_name='Donation/donation.html'
    
    def get(self,request):
        context={
        'form':DonationForm
        }
        return render(request,self.template_name,context)	

    def post(self,request):
        username=request.user
        amount=request.POST.get('amount')
        DonationModel.objects.create(username=username,amount=amount)
        return redirect('pay')
    
#post     
class PostView(View):
        template_name='post/post.html'
        
        def get(self,request):
            context={'form':PostForm}
            return render(request,self.template_name,context)
        
        def post(self,request):
            user=request.user
            title=request.POST.get('title')
            subtitle=request.POST.get('subtitle')
            image=request.POST.get('image')
            type=request.POST.get('type')
            description=request.POST.get('description')  
            
            PostModel.objects.create(
                user=user,
                title=title,
                subtitle=subtitle,
                image=image,
                type=type,
                description=description)
            return redirect("post")
            
 # authorize razorpay client with API Keys.
razorpay_client = razorpay.Client(
    auth=(settings.RAZOR_KEY_ID, settings.RAZOR_KEY_SECRET))

class PaymentView(View):
    template_name="Donation/payment.html"

    def get(self,request):
        username=request.user
        data=DonationModel.objects.last()
        amount=int(data.amount)*100
        currency = 'INR'
        # Create a Razorpay Order
        razorpay_order = razorpay_client.order.create(dict(amount=amount,currency=currency,payment_capture='0'))
 
        # order id of newly created order.
        razorpay_order_id = razorpay_order['id']
        callback_url = '/paymenthandler/'
        
 
		# we need to pass these details to frontend.
        context = {'amount_rupee':amount}
        context['razorpay_order_id'] = razorpay_order_id 
        context['razorpay_merchant_key'] = settings.RAZOR_KEY_ID
        context['razorpay_amount'] = amount
        context['currency'] = currency
        context['callback_url'] = callback_url
        return render(request,self.template_name,context)
        
# we need to csrf_exempt this url as
# POST request will be made by Razorpay
# and it won't have the csrf token.
@csrf_exempt
def paymenthandler(request):
    if request.method == "POST":
        try:
            # get the required parameters from post request.
            payment_id = request.POST.get('razorpay_payment_id', '')
            razorpay_order_id = request.POST.get('razorpay_order_id', '')
            signature = request.POST.get('razorpay_signature', '')
            params_dict = {
				'razorpay_order_id': razorpay_order_id,
				'razorpay_payment_id': payment_id,
				'razorpay_signature': signature
			}
            # verify the payment signature.
            result = razorpay_client.utility.verify_payment_signature(
				params_dict)
            if result is not None:
                # amount = 20000  # Rs. 200
                data=DonationModel.objects.last()
                amount=int(data.amount)*100
                try:
                    # capture the payemt
                    razorpay_client.payment.capture(payment_id, amount)
                    data=DonationModel.objects.last()
                    data.payment_status=True
                    data.save()
                    # render success page on successful caputre of payment
                    return render(request, 'Donation/paymentsuccess.html')
                except:
                    # if there is an error while capturing payment.
                    return render(request, 'Donation/paymentfail.html')
                else:
                    # if signature verification fails.
                    return render(request, 'Donation/paymentfail.html')
                
        except:
            # if we don't find the required parameters in POST data
            return HttpResponseBadRequest()
        
        else:
            # if other than POST request is made.
            return HttpResponseBadRequest()


	



        
        