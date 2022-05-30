from flask import *
import functools
app=Flask(__name__)
from dbconn import *
app.secret_key="hjvghvf"

@app.route('/')
def login():
    return render_template('/login.html')

def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "lid" not in session:
            return redirect ("/")
        return func()
    return secure_function


@app.route('/logincode',methods=['post'])
def logincode():
    uname=request.form['textfield']
    pwd=request.form['textfield2']
    qry="SELECT * FROM login WHERE username=%s AND PASSWORD=%s"
    val=(uname,pwd)
    print(val)
    res=selectone(qry,val)
    if res is None:
        return '''<script>alert('invalid');window.location="/"</script>'''
    else:
        if res[3]=='expert':
            session['lid']=res[0]
            return redirect('/experthome')
        elif res[3]=='admin':
            session['lid']=res[0]
            return redirect('/admin')

        else:
            return '''<script>alert('invalid');window.location="/"</script>'''


@app.route('/add_and_manage_treatment')
@login_required
def add_and_manage_treatment():

    qry="select* from treatment"
    res=selectall(qry)
    return render_template('add_and_manage_treatments.html',val=res)
@app.route('/dlttrtmnt')
@login_required

def dlttrtmnt():
    id=request.args.get('id')
    qry="delete from treatment where tid=%s"
    iud(qry,str(id))
    return '''<script>alert(' deleted');window.location="/add_and_manage_treatment#about"</script>'''

@app.route('/dltexpert')
@login_required

def dltexpert():
    id=request.args.get('id')
    qry = "delete from login where lid=%s"
    iud(qry, str(id))
    qry="delete from expert where Loginid=%s"
    iud(qry,str(id))
    return '''<script>alert(' deleted');window.location="/manage_expert#about"</script>'''

@app.route('/editexpert')
@login_required
def editexpert():
    expid=request.args.get('id')
    session['expid']=expid

    qry="SELECT * FROM `expert` WHERE Loginid=%s"
    res=selectone(qry,expid)

    return render_template("admin/editexp.html",val=res)



@app.route('/add_treatment',methods=['post'])
@login_required

def add_treatment():
    return render_template('add_treatment.html')

@app.route('/add_treatment1',methods=['post'])
@login_required

def add_treatment1():
    disease=request.form['textfield']
    trtmnt=request.form['textfield2']
    details=request.form['textarea']
    qry="(insert into treatment values(NULL,%s,%s,%s,curdate())"
    val=(disease,trtmnt,details)
    iud(qry,val)

    return '''<script>alert('added');window.location="/add_and_manage_treatment#about"</script>'''

@app.route('/edit_expert',methods=['post'])
@login_required

def edit_expert():
    Fname=request.form['textfield']
    Lname = request.form['textfield2']
    Gender = request.form['radiobutton']
    place = request.form['textfield3']
    post = request.form['textfield4']
    pincode = request.form['textfield5']
    phone= request.form['textfield6']
    Email = request.form['textfield7']

    qry ="UPDATE `expert` SET `Fname`=%s,`Lname`=%s,`Gender`=%s,`Place`=%s,`post`=%s,`pin`=%s,`phone`=%s,`E-Mail`=%s WHERE `Loginid`=%s"
    val = (Fname,Lname,Gender,place,post,pincode,phone,Email, session['expid'])
    iud(qry, val)
    return '''<script>alert('update');window.location="/manage_expert#about"</script>'''


@app.route('/manage_expert',methods=['post','get'])
@login_required

def manage_expert():
    qry="select * from expert"
    res=selectall(qry)
    return  render_template("admin/Manage Expert.html",val=res)

@app.route('/view_user',methods=['post','get'])
@login_required

def view_user():
    qry="select * from registration"
    res=selectall(qry)
    return  render_template("admin/view users.html",val=res)

@app.route('/view_complaint',methods=['post','get'])
@login_required

def view_complaint():
    qry="SELECT `complaint`.*,`registration`.`fname`,`lname` FROM `complaint` JOIN `registration` ON `complaint`.userid=`registration`.`lid` WHERE `complaint`.`reply`='pending'"
    res=selectall(qry)
    return  render_template("admin/view complaints.html",val=res)

@app.route('/view_feedback',methods=['post','get'])
@login_required

def view_feedback():
    qry="select * from feedback"
    res=selectall(qry)
    return  render_template("admin/view feedback.html",val=res)

@app.route('/accept_doctor',methods=['post','get'])
@login_required

def accept_doctor():
    qry="SELECT `doctor`.*,`login`.lid FROM `doctor` JOIN `login` ON `doctor`.`Loginid`=`login`.`lid` WHERE `login`.`type`='pending'"
    res=selectall(qry)
    return  render_template("admin/Accept or reject doctor.html",val=res)

@app.route('/reject_doctor',methods=['post','get'])
@login_required

def reject_doctor():
    id = request.args.get('id')
    qry = "UPDATE `login` SET `type`='reject' WHERE lid=%s "
    iud(qry, str(id))
    return '''<script>alert('reject');window.location="/accept_doctor#about"</script>'''


@app.route('/accept_doctors',methods=['post','get'])
@login_required

def accept_doctors():
    id=request.args.get('id')
    qry="UPDATE `login` SET `type`='doctor' WHERE lid=%s "
    iud(qry,str(id))
    return '''<script>alert('accepted');window.location="/accept_doctor#about"</script>'''

@app.route('/doctorregistration',methods=['post'])
def doctorregistration():
    Fname=request.form['textfield']
    Lname = request.form['lname']
    mobile=request.form['textfield2']
    Gender=request.form['radiobutton']
    dob = request.form['dob']
    email= request.form['textfield3']
    experience = request.form['experience']
    place = request.form['textfield4']
    username = request.form['uname']
    password = request.form['password']

    qry="insert into login values(NULL,%s,%s,'pending')"
    val= (username,password)
    id = iud(qry, val)
    qry = "insert into doctor values(NULL,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    val = (str(id),Fname, Lname, Gender,experience,dob, mobile,email, place)
    iud(qry, val)

    return '''<script>alert('added');window.location="/#about"</script>'''

@app.route('/addtips',methods=['post'])
@login_required

def addtips():
    return render_template('addtips.html')

@app.route('/addingtips',methods=['post'])
@login_required

def addingtips():
    tips=request.form['textarea']
    qry="INSERT INTO tips VALUES(NULL,%s,CURDATE())"
    iud(qry,tips)
    return '''<script>alert('tip added');window.location="/tips#about"</script>'''

@app.route('/addexperts',methods=['post'])
@login_required

def addexperts():
    Fname = request.form['textfield']
    Lname = request.form['textfield2']
    mobile = request.form['textfield6']
    Gender = request.form['radiobutton']
    email = request.form['textfield7']
    place = request.form['textfield3']
    post = request.form['textfield4']
    pin = request.form['textfield5']
    username = request.form['textfield8']
    password = request.form['textfield9']

    qry="insert into login values(NULL,%s,%s,'expert')"
    val=(password,username)
    id= iud(qry,val)
    qry = "insert into expert values(NULL,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    val = (str(id),Fname,Lname,Gender,place,post,pin,mobile,email)
    iud(qry, val)


    return '''<script>alert('added');window.location="/managexpert#about"</script>'''



@app.route('/experthome')
@login_required

def experthome():
    return render_template('experthome.html')


@app.route('/tips')
@login_required

def tips():
    qry="SELECT * FROM `tips`"
    res=selectall(qry)
    return render_template('tips.html',val=res)

@app.route('/dlttips')
@login_required

def dlttips():
    id=request.args.get('id')
    qry="delete FROM `tips` where tip_id=%s"
    iud(qry,str(id))
    return '''<script>alert('tip deleted');window.location="/tips#about"</script>'''


@app.route('/viewfeedback')
@login_required

def viewfeedback():
    qry="SELECT `registration`.`fname`,`registration`.`lname`,`registration`.`email`,`feedback`.* FROM `registration` JOIN `feedback` ON `registration`.`lid`=`feedback`.`lid`"
    res=selectall(qry)
    return render_template('viewfeedback.html',val=res)

@app.route('/logout')
def logout():
    session.clear()
    return render_template('login.html')

@app.route('/admin')
def admin():
    return render_template('admin/Admin.html')




@app.route('/acceptdoctor')
def acceptdoctor():
    return render_template('admin/Accept or reject doctor.html')


@app.route('/addexpert',methods=['post'])
def addexpert():
    return render_template('admin/Add Expert.html')


@app.route('/blockunblock')
def blockunblock():
    return render_template('admin/block or unblock.html')

@app.route('/managexpert')
def managexpert():
    return render_template('admin/Manage Expert.html')


@app.route('/sendreply')
def sendreply():
    cid=request.args.get('id')
    session['cid']=cid
    return render_template('admin/send reply.html')

@app.route('/viewcomplaint')
def viewcomplaint():
    return render_template('admin/view complaints.html')



@app.route('/viewfeedbackadmin')
def viewfeedbackadmin():
    return render_template('admin/view feedback.html')

@app.route('/viewuser')
def viewuser():
    return render_template('admin/view users.html')

@app.route('/addspecializtion')
def addspecializtion():
    return render_template('doctor/Add specialization.html')

@app.route('/addtimeschedule')
def addtimeschedule():
    return render_template('doctor/Add timeschedule.html')

@app.route('/manageexpert')
def manageexpert():
    return render_template('doctor/Manage Expert.html')

@app.route('/managespecialization')
def managespecialization():
    return render_template('doctor/manage specialization.html')

@app.route('/managetimeschedule')
def managetimeschedule():
    return render_template('doctor/manage timeschedule.html')

@app.route('/registration')
def registration():
    return render_template('doctor/registration.html')

@app.route('/send_reply',methods=['post'])
@login_required

def send_reply():
    reply = request.form['textarea']
    qry="UPDATE `complaint` SET `reply`=%s WHERE `id`=%s"
    val=(reply,session['cid'])
    iud(qry,val)
    return '''<script>alert('send');window.location="/view_complaint"</script>'''

app.run(debug=True)