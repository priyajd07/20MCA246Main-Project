from flask import *
from src.dbconnect import *
app=Flask(__name__)
app.secret_key='aa'


import functools

def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "lid" not in session:
            return redirect("/")
        return func()

    return secure_function
@app.route('/')
def login():
    return render_template("login.html")


@app.route('/viewuser')
@login_required

def viewuser():

    qry = "SELECT * FROM user"
    s = select(qry)
    return render_template("viewuser.html",val=s)

@app.route('/viewpolice')
@login_required

def viewpolice():

    qry = "SELECT * FROM police"
    s = select(qry)
    return render_template("viewpolice.html",val=s)

@app.route('/notification')
@login_required

def notification():
    qry = "SELECT * FROM notification ORDER BY nid DESC"
    s = select(qry)

    return render_template("add notification.html",val=s)


@app.route('/addnotification',methods=['post','get'])
@login_required

def addnotification():
    notification=request.form['textarea']


    qry2 = "insert into notification values(null,curdate(),%s)"
    values = (notification)
    iud(qry2, values)
    return '''<script>alert('NOTIFICATION ADDED');window.location='/notification'</script>'''

@app.route('/addpolice',methods=['post','get'])
@login_required
def addpolice():
    fname=request.form['textfield']
    mname = request.form['textfield2']
    lname = request.form['textfield3']
    phoneno = request.form['textfield4']
    email = request.form['textfield5']
    username = request.form['textfield6']
    password = request.form['textfield7']
    qry="insert into login values(null,%s,%s,'police')"
    val=(username,password)
    id=iud(qry,val)

    qry2 = "insert into police values(null,%s,%s,%s,%s,%s,%s)"
    values = (id,fname,mname,lname,phoneno,email)
    iud(qry2, values)
    return '''<script>alert('POLICE ADDED');window.location='/homepage'</script>'''




@app.route('/addroutes',methods=['post','get'])
@login_required

def addroutes():
    froms=request.form['textfield']
    to=request.form['textfield2']
    route=request.form['textfield3']
    qry2 = "insert into route values(null,%s,%s,%s)"
    values = (froms,to,route)
    iud(qry2, values)
    return '''<script>alert('ROUTE ADDED');window.location='/manageroute'</script>'''


@app.route('/removoe')
@login_required

def remove():
    id=request.args.get('id')
    print(id)
    q="delete from notification where nid=%s"
    val=(id)
    iud(q,val)
    return '''<script>alert('deleted');window.location='/notification'</script>'''
@app.route('/delt')
@login_required

def delt():
    id=request.args.get('id')
    print(id)
    q="delete from route where id=%s"
    val=(id)
    iud(q,val)
    return '''<script>alert('deleted');window.location='/manageroute'</script>'''

@app.route('/addroute',methods=['post'])
@login_required

def addroute():
    return render_template("add route.html")


@app.route('/manageroute')
@login_required

def manageroute():
    qry="select * from route"
    res = select(qry)
    return render_template("manageroute.html",val=res)


@app.route('/viewfeedback')
@login_required

def viewfeedback():
    qry="SELECT `user`.`fname`,`user`.`lname`,`feedback`.* FROM `feedback` JOIN `user` ON `user`.`user_lid`=`feedback`.`user_lid`"
    res=select(qry)
    return render_template("viewfeedback.html",val=res)

@app.route('/trackuser')
@login_required

def trackuser():
    qry="SELECT `user`.`fname`,`user`.`lname`,`user`.`phone`,`user`.`email`,`track`.* FROM `track` JOIN `user` ON `user`.`user_lid`=`track`.`user_lid`"
    res=select(qry)
    return render_template("trackuser.html",val=res)
@app.route('/homepage')


def homepage():
    return render_template("homepage.html")

@app.route('/addp',methods=['post','get'])
def addp():
    return render_template("Addpolice.html")




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

@app.route('/deletepolice')
@login_required
def deletepolice():
    id=request.args.get('id')
    qry="delete from police where tp_id=%s"
    iud(qry,str(id))
    return '''<script>alert('Deleted ');window.location='/viewpolice'</script>'''


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')




app.run(debug=True)
