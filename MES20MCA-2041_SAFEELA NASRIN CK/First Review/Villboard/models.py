from distutils.command.upload import upload
from io import BytesIO
from unittest.util import _MAX_LENGTH
from click import option
from django.db import models
from django.contrib.auth.models import User
import qrcode
from django.core.files import File
from PIL import Image,ImageDraw

# Create your models here.
# Registration model
class UserRegisterModel(models.Model):
	user=models.OneToOneField(User,on_delete=models.CASCADE)
	ward_no=models.CharField(max_length=30,default='None')
	house_no=models.CharField(max_length=30,default='None')
	rationcard_no=models.CharField(max_length=30,default='None')
	address=models.TextField(max_length=80)
	phone_no=models.CharField(max_length=14,default='None')
	status=models.BooleanField(default=True)
	created_on=models.DateTimeField(auto_now=True)

	def __str__(self):
		return (self.house_no)

# visitor...
class VisitorModel(models.Model):
    
    username=models . ForeignKey (User, on_delete = models . CASCADE ) 
    name=models.CharField(max_length=30, help_text='Enter car Name')
    email=models.EmailField(max_length=254 )
    address=models.TextField()
    phone_no=models.CharField(max_length=30)
    qrcode=models.ImageField(upload_to='qrcode/',blank=True)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return (self.name)
    
    def save ( self , * args , ** kwargs ) :
        qrcode_img = qrcode.make ( self.name+' '+self.address+" "+self.phone_no)
        canvas=Image.new ( 'RGB' , ( 700 , 700 ) ,'white' )
        draw = ImageDraw.Draw ( canvas ) 
        canvas.paste ( qrcode_img )
        fname = f'qr_code- {self.name} .png' 
        buffer = BytesIO ( ) 
        canvas.save ( buffer , 'PNG' ) 
        self.qrcode.save ( fname , File ( buffer ) , save = False)
        canvas.close ( ) 
        super ( ) . save ( * args , ** kwargs )


 #... Add members model...
 
class AddMemberModel(models.Model):
    username=models.ForeignKey(User, on_delete = models . CASCADE ) 
    house_no=models.CharField(max_length=30,default='None')
    name=models.CharField(max_length=30, null=True)
    age=models.IntegerField()
    adhaar_no=models.CharField(max_length=30, null=True)
    designation= models.CharField(max_length=30, null=True)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return (self.name)
    
#.....Add pets...

class PetModel(models.Model):
    type_choice=(('Dog','Dog'),
                 ('cat','Cat'),
                 ('cow','Cow'),
                 )
    
    username=models . ForeignKey (User, on_delete = models . CASCADE ) 
    name=models.CharField(max_length=30, help_text='Enter Pet Name')
    type=models.CharField(max_length=20 ,choices=type_choice)
    Is_vaccinated=models.BooleanField(default=True)
    image=models.ImageField(upload_to='pic/',blank=True)
    qrcode=models.ImageField(upload_to='qrcode/',blank=True)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return (self.name)
    
    def save ( self , * args , ** kwargs ) :
        qrcode_img = qrcode.make ( self.name+' '+self.type+" "+self.image)
        canvas=Image.new ( 'RGB' , ( 700 , 700 ) ,'white' )
        draw = ImageDraw.Draw ( canvas ) 
        canvas.paste ( qrcode_img )
        fname = f'qr_code- { self.name } .png' 
        buffer = BytesIO ( ) 
        canvas.save ( buffer , 'PNG' ) 
        self.qrcode.save ( fname , File ( buffer ) , save = False)
        canvas.close ( ) 
        super ( ) . save ( * args , ** kwargs )
    
     
     
    
#...........Vehicle Registration............

class VehicleModel(models.Model):
    
    username=models . ForeignKey (User, on_delete = models . CASCADE ) 
    name=models.CharField(max_length=30, help_text='Enter car Name')
    email=models.EmailField(max_length=254 )
    address=models.TextField()
    phone_no=models.CharField(max_length=30)
    qrcode=models.ImageField(upload_to='qrcode/',blank=True)
    car_model=models.CharField(max_length=30)
    plate_number=models.CharField(max_length=30)
    image=models.ImageField(upload_to='pic/',blank=True)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return (self.name)
    
    def save ( self , * args , ** kwargs ) :
        qrcode_img = qrcode.make ( self.name+' '+self.address+" "+self.plate_number)
        canvas=Image.new ( 'RGB' , ( 700 , 700 ) ,'white' )
        draw = ImageDraw.Draw ( canvas ) 
        canvas.paste ( qrcode_img )
        fname = f'qr_code- { self.name} .png' 
        buffer = BytesIO ( ) 
        canvas.save ( buffer , 'PNG' ) 
        self.qrcode.save ( fname , File ( buffer ) , save = False)
        canvas.close ( ) 
        super ( ) . save ( * args , ** kwargs )

#payment integration

class DonationModel(models.Model):
    username=models.ForeignKey(User, on_delete = models . CASCADE ) 
    amount=models.DecimalField(decimal_places=2, max_digits=6)
    Pay_status=models.BooleanField(default=False)  
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return str(self.username)
    
# post

class PostCategoryModel(models.Model):
    type=models.CharField(max_length=30)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    def __str__(self):
        return self.type 
    
class PostModel(models.Model):
    user=models . ForeignKey (User, on_delete = models . CASCADE ) 
    title=models.CharField(max_length=30)
    subtitle=models.CharField(max_length=30)
    image=models.ImageField(upload_to='pic/',blank=True)
    type=models . ForeignKey (PostCategoryModel, on_delete = models . CASCADE ) 
    description=models.TextField(max_length=400)
    status=models.BooleanField(default=True)
    created_on=models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return self.user 