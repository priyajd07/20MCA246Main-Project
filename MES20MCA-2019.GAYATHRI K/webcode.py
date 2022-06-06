from flask import *
from src.dbconnect import *
app=Flask(__name__)
app.secret_key="aaaaaq"
import functools
def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "lid" not in session:
            return redirect ("/")
        return func()
    return secure_function
@app.route('/')
def login():
    return render_template("login.html")


@app.route('/viewuser')
@login_required
def viewuser():
    qry = "SELECT * FROM users"
    s = select(qry)
    return render_template("viewuser.html",val=s)

@app.route('/reply')
@login_required
def reply():
    id=request.args.get('id')
    session['cid']=id
    return render_template("reply.html")

@app.route('/reply1',methods=['post'])
def reply1():
    reply=request.form['textarea']
    qry="update complaint set reply=%s where cid=%s"
    val=(reply,session['cid'])
    iud(qry,val)
    return '''<script>alert('added');window.location='/viewcomplaint'</script>'''


@app.route('/viewcomplaint')
@login_required
def viewcomplaint():
    qry="SELECT `users`.`fname`,`users`.`lname`,`complaint`.* FROM `complaint` JOIN `users` ON `complaint`.`user_lid`=`users`.`lid` where complaint.reply='pending'"
    res=select(qry)
    return render_template("viewcomplaint.html",val=res)


@app.route('/viewfeedback')
@login_required
def viewfeedback():
    qry="SELECT `users`.`fname`,`users`.`lname`,`feedback`.* FROM `feedback` JOIN `users` ON `users`.`lid`=`feedback`.`user_lid`"
    s = select(qry)
    return render_template("viewfeedback.html",val=s)

@app.route('/homepage')
@login_required
def homepage():
    return render_template("homepage.html")






@app.route('/login2',methods=['post'])
def login2():
    uname=request.form['textfield']
    pword=request.form['textfield2']
    q="select * from login where username=%s and password=%s"
    val=(uname,pword)
    s=selectonecond(q,val)
    if s  is None:
        return '''<script>alert('Invalid user name or password');window.location='/'</script>'''
    elif s[3]=='admin':
        session['lid']=s[0]
        return '''<script>alert('login successfully');window.location='/homepage'</script>'''
    elif s[3] == 'counsellor':
        session['lid'] = s[0]
        return '''<script>alert('login successfully');window.location='/councilhome'</script>'''



@app.route("/logout")
def logout():
    session.clear()
    return render_template("login.html")

@app.route('/councilhome')
def councilhome():
    return render_template("counscellorhomepage.html")

@app.route('/addcounsellor')
def addcounsellor():
    return render_template("Counsellor_registration.html")

@app.route('/councellor_reg',methods=['post'])
def councellor_reg():
    fname=request.form['textfield']
    lname = request.form['textfield2']
    dob=request.form['textfield3']
    gender=request.form['radiobutton']
    place = request.form['textfield4']
    post = request.form['textfield5']
    pincode = request.form['textfield6']
    qualification = request.form['textfield7']
    phoneno = request.form['textfield8']
    emailid = request.form['textfield9']
    username = request.form['textfield10']
    password = request.form['textfield11']
    qry="INSERT INTO `login` VALUES(NULL,%s,%s,'pending')"
    val=(username,password)
    loginid=iud(qry,val)
    qry1="INSERT INTO `counsellor` VALUES(NULL,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    val2=(loginid,fname,lname,dob,gender,place,post,pincode,qualification,phoneno,emailid)
    iud(qry1,val2)
    return '''<script>alert('Successfully Registered');window.location='/'</script>'''

@app.route('/approve_counc',methods=['post','get'])
def approve_counc():
    qry="SELECT `counsellor`.* FROM `counsellor` JOIN `login` ON `login`.`id`=`counsellor`.`login_id` WHERE `login`.`usertype`='pending'"
    res=select(qry)
    return render_template("approvecouncellor.html",res1=res)
@app.route('/approved_counc',methods=['post','get'])
def approved_counc():
    qry="SELECT `counsellor`.* FROM `counsellor` JOIN `login` ON `login`.`id`=`counsellor`.`login_id` WHERE `login`.`usertype`='counsellor'"
    res=select(qry)
    return render_template("approvedcouncellor.html",res1=res)

@app.route('/accept_co')
def accept_co():
    id=request.args.get("id")
    qry="UPDATE `login` SET `usertype`='counsellor' WHERE `id`=%s"
    iud(qry,id)
    return redirect("/approve_counc")

@app.route('/reject_co')
def reject_co():
    id=request.args.get("id")
    qry="DELETE from `login`  WHERE `id`=%s"
    iud(qry,id)
    qry="DELETE  from `counsellor`  WHERE `login_id`=%s"
    iud(qry,id)
    return redirect("/approve_counc")

@app.route('/managecounsellortips')
def managecounsellortips():
    qry="select * from tips where counsellor_id=%s"
    res=selectcond(qry,session['lid'])
    return render_template("c_managetips.html",val=res)

@app.route('/addcounsellortips',methods=['post'])
def addcounsellortips():
    return render_template("c_addtips.html")
@app.route('/inserttips',methods=['post'])
def inserttips():
    tip=request.form['textfield']
    qry="insert into tips values(null,%s,%s,curdate())"
    val=(session['lid'],tip)
    iud(qry,val)
    return redirect('managecounsellortips')

@app.route('/deletetip')
def deletetip():
    id=request.args.get("id")
    qry="DELETE from `tips`  WHERE `t_id`=%s"
    iud(qry,id)
    return redirect("/managecounsellortips")


app.run(debug=True)
