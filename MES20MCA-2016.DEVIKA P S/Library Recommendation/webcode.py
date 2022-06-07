import os
from flask import *
from werkzeug.utils import secure_filename

from src.dbconnect import *
app=Flask(__name__)
app.secret_key="aaa"

import functools
def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "lid" not in session:
            return redirect ("/")
        return func()
    return secure_function

@app.route("/logout")
# @login_required

def logout():
    session.clear()
    return render_template("login.html")



@app.route('/')
def login():
    return render_template("login.html")


@app.route('/addandmanagebook')
@login_required
def addandmanagebook():
    qry = "SELECT * FROM books"
    s = select(qry)
    return render_template("addandmanagebook.html",val=s)

@app.route('/issuebook')
@login_required
def issuebook():
    qry="SELECT `user_registration`.`firstname`,`user_registration`.`lastname`,`books`.`bookname`,`reservebook`.`status`,`date`,`reservebook`.`id` FROM `reservebook` JOIN `user_registration` ON `reservebook`.`userid`=`user_registration`.`lid` JOIN `books` ON `books`.`id`=`reservebook`.`bookid` where `reservebook`.`status`='reserved'"
    res=select(qry)
    return render_template("issuebook.html",val=res)



@app.route('/issued')
def issued():
    id=request.args.get('id')
    qry="UPDATE `reservebook` SET `status`='issued',`date`=CURDATE() WHERE `id`=%s"
    val=str(id)
    iud(qry,val)
    return '''<script>alert('successfully issued');window.location='/issuebook'</script>'''

@app.route('/returnbook')
@login_required
def returnbook():
    qry="SELECT `user_registration`.`firstname`,`user_registration`.`lastname`,`books`.`bookname`,`reservebook`.`status`,`date` FROM `reservebook` JOIN `user_registration` ON `reservebook`.`userid`=`user_registration`.`lid` JOIN `books` ON `books`.`id`=`reservebook`.`bookid` where  `reservebook`.`status`='returned'"
    res=select(qry)
    return render_template("returnbook.html",val=res)


@app.route('/verifyuser')
@login_required
def verifyuser():
    qry = "SELECT `user_registration`.*,`login`.`type` FROM `login` JOIN `user_registration` ON `user_registration`.`lid`=`login`.`id` "
    s = select(qry)
    return render_template("verifyuser.html",val=s)

@app.route('/viewbookreservation')
@login_required
def viewbookreservation():
    qry="SELECT `user_registration`.`firstname`,`user_registration`.`lastname`,`books`.`bookname`,`reservebook`.`status`,`date` FROM `reservebook` JOIN `user_registration` ON `reservebook`.`userid`=`user_registration`.`lid` JOIN `books` ON `books`.`id`=`reservebook`.`bookid` where  `reservebook`.`status`='reserved'"
    res=select(qry)
    return render_template("viewbookreservation.html",val=res)




@app.route('/homepage')
def homepage():
    return render_template("homepage.html")


@app.route('/addbook',methods=['post'])
def addbook():
    return render_template("add book.html")



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

    elif s[3]=='shop':
        session['lid']=s[0]
        return '''<script>alert('login successfully');window.location='/shophomepage'</script>'''

@app.route('/addbooks',methods=['post','get'])
def addbooks():
    bookname=request.form['textfield']
    author =request.form['textfield2']
    publisg_date =request.form['textfield3']
    price=request.form['textfield4']
    ISBN=request.form['textfield5']
    Language=request.form['textfield6']
    Category=request.form['textfield7']
    Noofcopies=request.form['textfield8']
    image=request.files['file']
    file=secure_filename(image.filename)
    image.save(os.path.join("static/image",file))
    pdf=request.files['file2']
    file1=secure_filename(pdf.filename)
    image.save(os.path.join("static/file",file1))
    qry2 = "insert into books values(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    values = (bookname, author, publisg_date, price,ISBN,Language,Category,Noofcopies,file,file1)
    iud(qry2, values)
    return '''<script>alert('BOOK ADDED');window.location='/addandmanagebook'</script>'''



@app.route('/deletebook')
def deletebook():
    id=request.args.get('id')
    print(id)
    q="delete from books where id=%s"
    val=(id)
    iud(q,val)
    return '''<script>alert('deleted');window.location='/addandmanagebook'</script>'''




@app.route('/approveuser')
def approveuser():
    id=request.args.get('id')
    print(id)
    q="update login set type='user' where id=%s"
    val=(id)
    iud(q,val)
    return '''<script>alert('user approved');window.location='/verifyuser'</script>'''

@app.route('/rejectuser')
def rejectuser():
    id=request.args.get('id')
    print(id)
    q="update login set type='reject' where id=%s"
    val=(id)
    iud(q,val)
    return '''<script>alert('user rejectd');window.location='/verifyuser'</script>'''


@app.route('/shopsignup')
def shopsignup():
    return render_template("shopsignup.html")

@app.route('/shopsignup2',methods=['post'])
def shopsignup2():
    shopname=request.form['textfield']
    place=request.form['textfield2']
    post=request.form['textfield3']
    phone=request.form['textfield4']
    email=request.form['textfield5']
    Username=request.form['textfield6']
    password=request.form['textfield7']
    qry="INSERT INTO login VALUES(NULL,%s,%s,'pending')"
    val=(Username,password)
    lid=iud(qry,val)
    qry2="INSERT INTO shop VALUES(NULL,%s,%s,%s,%s,%s,%s)"
    val2=(str(lid),shopname,place,post,phone,email)
    iud(qry2,val2)
    return '''<script>alert('success');window.location='/'</script>'''

@app.route('/adminverifyshop')
def adminverifyshop():
    qry="SELECT `shop`.* FROM `shop` JOIN `login` ON `shop`.`loginid`=`login`.`id` WHERE `login`.`type`='pending'"
    res=select(qry)
    return render_template('Adminverifyshop.html',val=res)


@app.route('/shopaddbook',methods=['post'])
def shopaddbook():
    Bookname=request.form['textfield']
    Author=request.form['textfield2']
    Rate=request.form['textfield3']
    Stock=request.form['textfield4']
    img=request.files['file']
    fn=secure_filename(img.filename)
    path=r'./static/shopbook'
    img.save(os.path.join(path,fn))
    qry="INSERT INTO shopbook VALUES(NULL,%s,%s,%s,%s,%s,%s)"
    val=(session['lid'],Bookname,Author,Rate,Stock,fn)
    iud(qry,val)
    return  '''<script>alert('success');window.location='/shopmanagebook'</script>'''


@app.route('/shopeaddbook',methods=['post'])
def shopeaddbook():
    return render_template("shopaddbook.html")


@app.route('/shopeditbook')
def shopeditbook():
    id = request.args.get('id')
    session['bid']=id
    qry="select * from shopbook where  bookid=%s"
    res=selectonecond(qry,id)

    return  render_template("shopbookedit.html",val=res)

@app.route('/shopeditupdate',methods=['post'])
def shopeditupdate():
    Bookname = request.form['textfield']
    Author = request.form['textfield2']
    Rate = request.form['textfield3']
    Stock = request.form['textfield4']
    qry = "UPDATE shopbook SET bookname=%s,author=%s,rate=%s,stock=%s WHERE bookid=%s"
    val = (Bookname, Author, Rate, Stock,session['bid'])
    iud(qry, val)
    return '''<script>alert('Update');window.location='/shopmanagebook'</script>'''





@app.route('/shopedeletebook')
def shopedeletebook():
    id = request.args.get('id')
    print(id)
    q = "delete from shopbook where bookid=%s"
    val = (id)
    iud(q, val)
    return '''<script>alert('deleted');window.location='/shopmanagebook'</script>'''






@app.route('/shopmanagebook')
def shopmanagebook():
    qry="SELECT * FROM `shopbook` WHERE shopid=%s"
    val=(str(session['lid']))
    res=selectcond(qry,val)
    return  render_template("shopmanagebook.html",val=res)


@app.route('/shophomepage')
def shophomepage():
    return  render_template("shophomepage.html")


@app.route('/viewbooking')
def viewbooking():
    qry = "SELECT `bookingtable`.*,`shopbook`.*,`user_registration`.* FROM `bookingtable` JOIN `shopbook` ON `shopbook`.`bookid`=`bookingtable`.`bookid` JOIN `user_registration` ON `user_registration`.`lid`=`bookingtable`.`uid` WHERE `bookingtable`.`status`='pending' AND `shopbook`.`shopid`=%s"
    res = selectcond(qry, session['lid'])

    return  render_template("View Booking_shop.html",val=res)

@app.route('/acceptbooking')
def acceptbooking():
    id=request.args.get('id')
    qry="UPDATE `bookingtable` SET STATUS='Accepted' WHERE `bookingid`=%s"
    iud(qry,id)
    return redirect("/viewbooking")

@app.route('/Rejectbooking')
def Rejectbooking():
    id=request.args.get('id')
    qry="UPDATE bookingtable SET STATUS='Rejected' WHERE bookingid=%s"
    iud(qry,id)
    return redirect("/viewbooking")

@app.route('/acceptshop')
def acceptshop():
    id=request.args.get('id')
    qry="UPDATE login SET type='shop' WHERE id=%s"
    iud(qry,id)
    return redirect("/adminverifyshop")

@app.route('/rejectshop')
def rejectshop():
    id=request.args.get('id')
    qry="UPDATE login SET type='Rejected' WHERE id=%s"
    iud(qry,id)
    return redirect("/adminverifyshop")






@app.route('/viewmonthlyreport')
def viewmonthlyreport():

    return  render_template("Viewmonthly report.html",vals=0)
@app.route('/searchreport',methods=['post'])
def searchreport():
    mnth=request.form['select']
    qry = "SELECT SUM(`totalamount`) FROM `bill`   WHERE shopid=%s  AND MONTH(DATE)=%s GROUP BY shopid"
    val=(session['lid'],mnth)
    res = selectonecond(qry, val)
    return render_template("Viewmonthly report.html", vals=res)










app.run(debug=True)