from email import feedparser
from multiprocessing import context
from re import template
from urllib.robotparser import RequestRate
from django.shortcuts import render,redirect
from django.views.generic import TemplateView,View,CreateView,UpdateView
from breakdown.forms import *
from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
import razorpay
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseBadRequest

# Create your views here.

class HomeView(TemplateView):
	template_name='home.html'


class RegisterView(View):
	template_name='register.html'
	def get(self,request):
		context={'form':UserRegisterForm}
		return render(request,self.template_name,context)
	def post(self,request):
		username=request.POST.get('username')
		password=request.POST.get('password1')
		email=request.POST.get('email')
		first_name=request.POST.get('first_name')
		last_name=request.POST.get('last_name')
		user=User.objects.create(username=username,password=password,email=email,first_name=first_name,last_name=last_name,is_staff=False)
		user.set_password(password)
		user.save()
		return redirect('home')	

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
				return redirect('dashboard')
			if user.is_staff == True and user.is_superuser == False:
				return redirect('mechdashboard')
			if user.is_staff == False and user.is_superuser == False:
				return redirect ('home')
		else:
			form=AuthenticationForm()
			context={'form':form}
			return render(request,'login.html',context)

def logout_view(request):
    logout(request)

    return redirect('home')




class AddServiceView(CreateView):
	template_name='addservice.html'
	form_class=ServiceForm
	success_url='/'

class UserView(TemplateView):
	template_name='userhome.html'

class RequestView(View):
	template_name='complaint.html'
	def get(self,request):
		context={'form':RequestForm}
		return render(request,self.template_name,context)
		
	def post(self,request):
		user=request.user
		vehicle_no=request.POST.get('vehicle_no')
		vehicle_name=request.POST.get('vehicle_name')
		vehicle_brand=request.POST.get('vehicle_brand')
		vehicle_model=request.POST.get('vehicle_model')
		problem_descripition=request.POST.get('problem_descripition')
		longitude=request.POST.get('longitude')
		lattitude=request.POST.get('lattitude')
		RequestModel.objects.create(username=user,vehicle_no=vehicle_no,vehicle_name=vehicle_name,vehicle_brand=vehicle_brand,vehicle_model=vehicle_model,problem_descripition=problem_descripition,
			longitude=longitude,lattitude=lattitude)
		return redirect('home')	

class ServieListView(View):
	template_name='offer.html'

	def get(self,request):
		context={'data':ServiceModel.objects.all()}
		return render (request,self.template_name,context)

class AdminView(View):
	template_name='dashboard.html'

	def get(self,request):
		feedback_count=FeedbackModel.objects.all().count()
		servicepending_count=ServiceBookingModel.objects.filter(type='pending').count()
		serviceprogress_count=ServiceBookingModel.objects.filter(type='work_in_progress').count()
		servicedone_count=ServiceBookingModel.objects.filter(type='done').count()




		context={
			'feedback_count':feedback_count,
			'servicepending_count':servicepending_count,
			'serviceprogress_count':serviceprogress_count,
			'servicedone_count':servicedone_count
		}
		return render(request,self.template_name,context)

class StaffView(View):
	template_name='staff.html'
	def get(self,request):
		context={'form':StaffRegisterForm}
		return render(request,self.template_name,context)
	def post(self,request):
		username=request.POST.get('username')
		password=request.POST.get('password1')
		email=request.POST.get('email')
		first_name=request.POST.get('first_name')
		last_name=request.POST.get('last_name')
		user=User.objects.create(username=username,password=password,email=email,first_name=first_name,last_name=last_name,is_staff=True)
		user.set_password(password)
		user.save()
		return redirect('dashboard')	

class ServiceBookingView(View):
	template_name='booking.html'

	def get(self,request,pk):
		data=ServiceModel.objects.get(id=pk)
		service_name=data.service_name
		service_charge=data.service_charge
		context={'form':ServiceBookingForm,'name':service_name,'amount':service_charge}
		return render (request,self.template_name,context)

	def post(self,request,pk):
		data=ServiceModel.objects.get(id=pk)
		service_name=data.service_name
		service_charge=data.service_charge
		pickup_date=request.POST.get('pickup_date')
		address=request.POST.get('address')
		place=request.POST.get('place')
		num=request.POST.get('num')

		ServiceBookingModel.objects.create(username=request.user,
		service_name=service_name,
		service_charge=service_charge,
		pickup_date=pickup_date,
		address=address,
		place=place,
		num=num
		)
		return redirect ('pay')

# authorize razorpay client with API Keys.
razorpay_client = razorpay.Client(
	auth=(settings.RAZOR_KEY_ID, settings.RAZOR_KEY_SECRET))

class PaymentView(View):
	template_name="payment.html"

	def get(self,request):
		data=ServiceBookingModel.objects.last()
		amount=int(data.service_charge)*100
		currency = 'INR'
		# amount = 20000  # Rs. 200
 
		# Create a Razorpay Order
		razorpay_order = razorpay_client.order.create(dict(amount=amount,
			currency=currency,payment_capture='0'))
 
		# order id of newly created order.
		razorpay_order_id = razorpay_order['id']
		callback_url = '/paymenthandler/'
 
		# we need to pass these details to frontend.
		context = {'amount_rupee':data.service_charge}
		context['razorpay_order_id'] = razorpay_order_id
		context['razorpay_merchant_key'] = settings.RAZOR_KEY_ID
		context['razorpay_amount'] = amount
		context['currency'] = currency
		context['callback_url'] = callback_url
 
		return render(request,self.template_name, context=context)
 
 
# we need to csrf_exempt this url as
# POST request will be made by Razorpay
# and it won't have the csrf token.
@csrf_exempt
def paymenthandler(request):
 
	# only accept POST request.
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
				data=ServiceBookingModel.objects.last()
				amount=int(data.service_charge)*100
				try:
 
					# capture the payemt
					razorpay_client.payment.capture(payment_id, amount)
 
					# render success page on successful caputre of payment
					return render(request, 'paymentsuccess.html')
				except:
 
					# if there is an error while capturing payment.
					return render(request, 'paymentfail.html')
			else:
 
				# if signature verification fails.
				return render(request, 'paymentfail.html')
		except:
 
			# if we don't find the required parameters in POST data
			return HttpResponseBadRequest()
	else:
		# if other than POST request is made.
		return HttpResponseBadRequest()


class FeedbackView(View):
	template_name='feedback.html'

	def get(self,request):
		context={'form':FeedbackForm}
		return render(request,self.template_name,context)

	def post(self,request):
		username=request.user
		feedback=request.POST.get('feedback')
		print(feedback)
		suggestions=request.POST.get('suggestions')
		FeedbackModel.objects.create(username=username,feedback=feedback,suggestions=suggestions)
		return redirect('home')	


class ReadView(TemplateView):
	template_name='readmore.html'


class BookingListView(View):
	template_name='choice.html'

	def get(self,request):
		context={'list':ServiceBookingModel.objects.all()}
		return render (request,self.template_name,context)

class UpadateStatusView(UpdateView):
	model=ServiceBookingModel
	fields=["type"]
	template_name='update.html'
	success_url="/dashboard/"



class MechanicAssignView(UpdateView):
	model=ServiceBookingModel
	fields=["mechanic"]
	template_name='mechassign.html'
	success_url="/dashboard/"	

class RequestListView(View):
	template_name='requestlist.html'
	def get(self,request):
		context={'list':RequestModel.objects.all()}
		return render(request,self.template_name,context)

class PendingListView(View):
	template_name='type.html'
	def get(self,request):
		status_title='pending'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title).order_by('-created_on'),
			'status_title':status_title}
		return render(request,self.template_name,context)

class ProgressListView(View):
	template_name='type.html'
	def get(self,request):
		status_title='work_in_progress'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title),
			'status_title':status_title}
		return render(request,self.template_name,context)

class DoneListView(View):
	template_name='done.html'
	def get(self,request):
		status_title='done'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title),
			"status_title":status_title}
		return render(request,self.template_name,context)





class WorkStatusView(View):
	template_name="workstatus.html"

	def get(self,request):
		context={
			'data':ServiceBookingModel.objects.filter(username=request.user).last()

		}
		return render (request,self.template_name,context)


class FeedbackListView(View):
	template_name='feedbacklist.html'

	def get(self,request):
		context={'list':FeedbackModel.objects.all()}
		return render (request,self.template_name,context)


class StaffListView(View):
	template_name='mechaniclist.html'

	def get(self,request):
		context={'data':User.objects.filter(is_staff=True,is_superuser=False)}
		return render (request,self.template_name,context)


class RegisterListView(View):
	template_name='registerlist.html'

	def get(self,request):
		context={'data':User.objects.filter(is_staff=False,is_superuser=False)}
		return render (request,self.template_name,context)		
	
class MechView(View):
	template_name='mechdashboard.html'

	def get(self,request):
		feedback_count=FeedbackModel.objects.all().count()
		servicepending_count=ServiceBookingModel.objects.filter(type='pending',mechanic=request.user).count()
		serviceprogress_count=ServiceBookingModel.objects.filter(type='work_in_progress',mechanic=request.user).count()
		servicedone_count=ServiceBookingModel.objects.filter(type='done',mechanic=request.user).count()


		context={
			'feedback_count':feedback_count,
			'servicepending_count':servicepending_count,
			'serviceprogress_count':serviceprogress_count,
			'servicedone_count':servicedone_count
		}
		return render(request,self.template_name,context)

class MechPendingListView(View):
	template_name='mechpendinglist.html'
	def get(self,request):
		status_title='pending'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title,mechanic=request.user),
			'status_title':status_title}
		return render(request,self.template_name,context)


class MechProgressListView(View):
	template_name='mechprogresslist.html'
	def get(self,request):
		status_title='work_in_progress'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title,mechanic=request.user),
			'status_title':status_title}
		return render(request,self.template_name,context)	



class mechDoneListView(View):
	template_name='mechdonelist.html'
	def get(self,request):
		status_title='done'
		context={
			'data':ServiceBookingModel.objects.filter(type=status_title,mechanic=request.user),
			"status_title":status_title}
		return render(request,self.template_name,context)			