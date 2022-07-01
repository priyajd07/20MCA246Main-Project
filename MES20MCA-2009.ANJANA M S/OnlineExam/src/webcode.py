import os
from flask import *
from werkzeug.utils import secure_filename
from src.dbconnection import*
app=Flask(__name__)
app.secret_key="abc"



import functools
def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "ln" not in session:
            return redirect("/")
        return func()
    return secure_function

@app.route('/')
def main():
     return render_template("login.html")

@app.route('/logout')
def logout():
    session.clear()
    return render_template('login.html')
@app.route('/log',methods=['post'])
def log():
    username=request.form['textfield']
    password=request.form['textfield2']
    qry="select*from login where username=%s and password=%s"
    val=(username,password)
    res=selectone(qry,val)
    if res is None:
        return '''<script> alert("invalid username or password");window.location="/"</script>'''
    elif res[3]=='admin':
        session['ln'] = res[0]
        session['lid'] = res[0]
        return '''<script>alert("login success");window.location="/adminhome"</script>'''
    elif res[3]=='staff':
        session['ln']=res[0]
        session['lid']=res[0]
        return '''<script>alert("login success");window.location="/staff_home"</script>'''
    else:
        return  '''<script> alert("invalid username or password");window.location="/"</script>'''




@app.route('/adminhome')
@login_required
def adminhome():
    return render_template("admin/Home.html")


@app.route('/add_subject',methods=['post'])
@login_required
def add_subject():
    qry = "SELECT* FROM course_table;"
    res = selectall(qry)
    return render_template("admin/add_subject.html",val=res)
@app.route('/sub_add',methods=['post'])
@login_required
def sub_add():
    course=request.form['select']
    semester=request.form['select2']
    subject=request.form['textfield']
    desc=request.form['textarea']
    qry="INSERT INTO subject_table VALUES(NULL,%s,%s,%s,%s)"
    val=(course,semester,subject,desc)
    iud(qry,val)
    return '''<script> alert("success");window.location="/add_manage_subject"</script>'''



@app.route('/add_course',methods=['post'])
@login_required

def add_course():
    return render_template("admin/add course.html")
@app.route('/course_add',methods=['post'])
@login_required

def course_add():
    cname=request.form['textfield']
    desc=request.form['textarea']
    qry="INSERT INTO course_table VALUES(NULL,%s,%s)"
    val=(cname,desc)
    iud(qry,val)
    return '''<script> alert("success");window.location="/add_manage_course"</script>'''



@app.route('/add_manage_course')
@login_required

def add_manage_course():
    q="SELECT * FROM course_table"
    res=selectall(q)
    return render_template("admin/add manage course.html",val=res)

@app.route('/delete_course')
@login_required

def delete_course():
    id=request.args.get('id')
    q="DELETE FROM `course_table` WHERE `id`=%s"
    v=(str(id))
    iud(q,v)
    return '''<script> alert("delete");window.location="/add_manage_course"</script>'''


@app.route('/edit_course')
@login_required

def edit_course():
    id=request.args.get('id')
    session['eid']=id
    q="SELECT*FROM`course_table` WHERE id=%s"
    v=(str(id))
    res=selectone(q,v)
    return render_template("admin/edit course.html",val=res)
@app.route('/update_course',methods=['post'])
@login_required
def update_course():
    cname=request.form['textfield']
    desc=request.form['textarea']
    id=session['eid']
    q="UPDATE `course_table` SET `course`=%s,`description`=%s WHERE `id`=%s"
    v=(cname,desc,str(id))
    iud(q,v)
    return '''<script> alert("updated successfully");window.location="/add_manage_course"</script>'''

@app.route('/editstaff')
def editstaff():
    id=request.args.get('id')
    session['id']=id
    q="SELECT *FROM `staff` WHERE loginid=%s"
    v=(str(id))
    res=selectone(q,v)
    qry="SELECT * FROM `course_table`"
    ress=selectall(qry)
    print(res)

    return render_template("admin/editstaff.html",val=res ,vall=ress)
@app.route('/updatestf',methods=['post'])
def updatestf():
    id=session['id']
    fname=request.form['textfield']
    lname = request.form['textfield3']
    dob=request.form['textfield4']
    gender=request.form['radiobutton']
    qualification = request.form.getlist('checkbox')
    qua = ','.join(qualification)
    place=request.form['textfield6']
    post=request.form['textfield7']
    pin=request.form['textfield8']
    phone=request.form['textfield9']
    email=request.form['textfield12']
    q="UPDATE `staff` SET `fname`=%s,`lname`=%s,dob=%s,`gender`=%s,`place`=%s,`pin`=%s,`post`=%s,`phone`=%s,`email`=%s,`qualification`=%s WHERE `loginid`=%s"
    v=(fname,lname,dob,gender,place,pin,post,phone,email,qua,str(id))
    iud(q,v)
    return '''<script> alert("updated successfully");window.location="/add_manage_staff"</script>'''











@app.route('/add_manage_staff')
@login_required
def add_manage_staff():
    q="select * from staff"
    res=selectall(q)
    return render_template("admin/add manage staff.html",val=res)

@app.route('/delete_staff')
def delete_staff():
    id=request.args.get('id')
    q="DELETE FROM `staff` WHERE `loginid`=%s"
    v=(str(id))
    iud(q,v)
    q1="DELETE FROM `login` WHERE `id`=%s"
    val=(str(id))
    iud(q1,val)
    return '''<script> alert("delete");window.location="/add_manage_staff"</script>'''

@app.route('/add_staff2',methods=['post'])
def add_staff2():
    try:
        fname=request.form['textfield']
        lname=request.form['textfield3']
        dob=request.form['textfield4']
        gender=request.form['radiobutton']
        qualification=request.form.getlist('checkbox')
        qua=','.join(qualification)
        place=request.form['textfield6']
        post=request.form['textfield7']
        pin=request.form['textfield8']
        phone=request.form['textfield9']
        email=request.form['textfield12']
        username=request.form['textfield11']
        password=request.form['textfield10']
        print(pin,"===============================")
        qry="insert into login values(NULL,%s,%s,'staff')"
        val=(username,password)
        res=iud(qry,val)
        qry1="INSERT INTO staff VALUES(NULL,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val1=(str(res),fname,lname,dob,gender,place,post,pin,qua,phone,email)
        iud(qry1,val1)
        return '''<script> alert("success");window.location="/add_manage_staff"</script>'''

    except Exception as e:
        print(e,"=================================================================")
        return '''<script> alert("Duplicate entry...please try again");window.location="/add_manage_staff"</script>'''

@app.route('/add_manage_subject')
@login_required
def add_manage_subject():
    q="SELECT `course_table`.`course`,`subject_table`.* FROM `subject_table` JOIN `course_table` ON `subject_table`.`course_id`=`course_table`.`id` "
    res=selectall(q)
    return render_template("admin/add manage subject.html",data=res)

@app.route('/delete_subject')
@login_required

def delete_subject():
    id=request.args.get('id')
    q="DELETE FROM `subject_table` WHERE `id`=%s"
    v=(str(id))
    iud(q,v)
    return '''<script> alert("deleted successfully");window.location="/add_manage_subject"</script>'''

@app.route('/edit_subject')
@login_required

def edit_subject():
    id=request.args.get('id')
    session['eid']=id
    qry="SELECT* FROM course_table"
    ress=selectall(qry)
    q="SELECT*FROM `subject_table` WHERE`id`=%s"
    v=(str(id))
    res=selectone(q,v)
    return render_template("admin/edit_subject.html",value=res,val=ress)

@app.route('/update_subject',methods=['post'])
@login_required

def update_subject():
    id=session['eid']
    course=request.form['select']
    semester=request.form['select2']
    subject=request.form['textfield']
    desc=request.form['textarea']
    q="UPDATE `subject_table` SET `course_id`=%s,`semester`=%s,`subject`=%s,`description`=%s WHERE `id`=%s"
    v=(course,semester,subject,desc,str(id))
    iud(q,v)
    return '''<script> alert("updated successfully");window.location="/add_manage_subject"</script>'''







@app.route('/add_staff',methods=['post'])
def add_staff():
    qry="SELECT* FROM course_table;"
    res=selectall(qry)
    return render_template("admin/add staff.html",val=res)









@app.route('/allocate_sub',methods=['post'])
def allocate_sub():
    subject=request.form['select3']
    staff=request.form['select4']
    q="INSERT INTO `allocation` VALUES(NULL,%s,%s)"
    v=(subject,staff)
    iud(q,v)
    return'''<script> alert("success");window.location="/allocate_subject_to_staff"</script>'''


@app.route('/allocate_subject_to_staff')
def allocate_subject_to_staff():
    q="SELECT `subject_table`.`subject`,`staff`.`fname`,`staff`.`lname`,`allocation`.`id` FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` JOIN `staff` ON `staff`.`loginid`=`allocation`.`staffid`"
    res=selectall(q)
    return render_template("admin/allocate subject to staff.html",val=res)
@app.route('/delete_alocatesub')
def delete_alocatesub():
    id=request.args.get('id')
    q="DELETE FROM `allocation` WHERE `id`=%s"
    v=(str(id))
    iud(q,v)
    return '''<script> alert("deleted successfully");window.location="/allocate_subject_to_staff"</script>'''






@app.route('/add_staff_subjectt',methods=['post'])
@login_required

def add_staff_subjectt():
    q="SELECT*FROM `course_table`;"
    res=selectall(q)
    # q1="SELECT*FROM `subject_table`;"
    # res1=selectall(q1)
    q2="SELECT*FROM `staff`;"
    res2=selectall(q2)

    return render_template("admin/add staff subjectt.html",val=res,vall=res2)





@app.route('/timetable')
@login_required

def timetable():
    q="SELECT*FROM `course_table`"
    res=selectall(q)
    q1="SELECT*FROM`subject_table`"
    ress=selectall(q1)
    return render_template("admin/timetable.html",val=res,vals=ress)

# @app.route('/schedulett',methods=['post'])
# def schedulett():
#     subject=request.form['select2']
#     day=request.form['textfield']
#     time=request.form['textfield2']
#     q = "INSERT INTO `timetable` VALUES(NULL,%s,%s,%s)"
#     v=(subject,day,time)
#     iud(q,v)
#     return '''<script> alert("success");window.location="/timetable"</script>'''















@app.route('/search_student')
@login_required

def search_student():
    qry = "SELECT * FROM course_table"
    res = selectall(qry)
    return render_template("admin/view student.html",vall=res)

@app.route('/view_student',methods=['post'])
@login_required

def view_student():
    cor=request.form['select']
    sem=request.form['select2']

    qry="SELECT `course_table`.`course`,`student_table`.* FROM `course_table` JOIN `student_table` ON `student_table`.`course`=`course_table`.`id` WHERE `student_table`.`course`=%s AND `student_table`.`semester`=%s"
    val=(cor,sem)
    res=selectall2(qry,val)
    qry = "SELECT * FROM course_table"
    ress = selectall(qry)

    return render_template("admin/view student.html",val=res,vall=ress)


@app.route('/staff_home')
def staff_home():
    return render_template("staff/staff home.html")


@app.route('/add_manage_exam_notification',methods=['post'])
@login_required
def add_manage_exam_notification():
    qry = "SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` JOIN `staff` ON `staff`.`loginid`=`allocation`.`staffid` WHERE `allocation`.`staffid`=%s"
    ress= selectall2(qry,session['lid'])
    return render_template("staff/add manage exam notification.html",vall=ress)

@app.route('/upload_qpaper',methods=['post'])
@login_required

def upload_qpaper():
    subject=request.form['select3']
    date=request.form['textfield']
    time=request.form['textfield2']
    exam=request.form['textfield3']
    duration=request.form['select4']

    q="INSERT INTO `exam` VALUES (NULL,%s,%s,%s,%s,%s)"
    v=(subject,date,time,exam,duration)
    iud(q,v)
    return '''<script> alert("uploaded successfully");window.location="/staff_home"</script>'''




@app.route('/update_qpaper',methods=['post'])
@login_required

def update_qpaper():
    try:
        subject=request.form['select3']
        date=request.form['textfield']
        time=request.form['textfield2']
        exam=request.form['textfield3']
        duration=request.form['select4']
        q="update `exam` set  `sid`=%s,`date`=%s,`time`=%s,`duration`=%s,exam_name=%s WHERE `id`=%s"
        v=(subject,date,time,duration,exam,session['edi'])
        iud(q,v)
        return '''<script> alert("uploaded successfully");window.location="/manage_exam"</script>'''

    except Exception as e:
        subject=request.form['select3']
        date=request.form['textfield']
        time=request.form['textfield2']
        qpaper=request.files['file']
        duration=request.form['select4']
        fn=secure_filename(qpaper.filename)
        qpaper.save(os.path.join('static/quespaper',fn))
        q="update `exam` set  `sid`=%s,`date`=%s,`time`=%s,`q_paper`=%s,`duration`=%s WHERE `id`=%s"
        v=(subject,date,time,fn,duration,session['edi'])
        iud(q,v)
        return '''<script> alert("uploaded successfully");window.location="/manage_exam"</script>'''




# @app.route('/add_exam',methods=['post'])
# def add_exam():
#     course=request.form['select']
#     semester=request.form['select2']
#     subject=request.form['select3']
#     date=request.form['textfield']
#     time=request.form['textfield2']
#     questionp=request.files['file']
#     durtion=request.form['select4']



@app.route('/add_manage_students')
@login_required

def add_manage_students():
    q = "SELECT*FROM `course_table`"
    res = selectall(q)
    return render_template("staff/add manage students.html",val=res)


@app.route('/add_student',methods=['post'])
@login_required

def add_student():

    btn=request.form['Submit']
    if btn=="Add New":
        q="SELECT*FROM `course_table`"
        res=selectall(q)
        return render_template("staff/add student.html",val=res)
    else:
        course=request.form['select']
        print(course)
        semester=request.form['select2']
        print(semester)
        q="SELECT * FROM `student_table` WHERE `semester`=%s AND `course`=%s"
        v=(str(semester),str(course))
        res=selectall2(q,v)
        print(res)
        q = "SELECT*FROM `course_table`"
        ree = selectall(q)


        return render_template("staff/add manage students.html",val2=res,val=ree)


@app.route('/view_students',methods=['post','get'])
@login_required

def view_students():
    q = "SELECT*FROM `course_table`"
    ree = selectall(q)
    return render_template("admin/view students.html",val=ree)



@app.route('/search_students',methods=['post','get'])
@login_required

def search_students():

    course=request.form['select']
    print(course)
    semester=request.form['select2']
    print(semester)
    q="SELECT * FROM `student_table` WHERE `semester`=%s AND `course`=%s"
    v=(str(semester),str(course))
    res=selectall2(q,v)
    print(res)
    q = "SELECT*FROM `course_table`"
    ree = selectall(q)


    return render_template("admin/view students.html",val2=res,val=ree)


@app.route('/edit_student')
@login_required

def edit_student():
    id=request.args.get('id')
    session['sid']=id

    qry="SELECT*FROM `student_table` WHERE `login_id`=%s"
    val=(str(id))
    res=selectone(qry,val)
    q = "SELECT*FROM `course_table`"
    ree = selectall(q)

    return render_template("staff/edit student.html",val=res,vals=ree)



@app.route('/delete_student')
@login_required

def delete_student():
    id=request.args.get('id')
    q="DELETE FROM `student_table` WHERE `login_id`=%s"
    v=(str(id))
    iud(q,v)


    q2="DELETE FROM `login` WHERE `id`=%s"
    val = (str(id))
    iud(q2, val)
    return '''<script> alert("deleted successfully");window.location="/add_manage_students"</script>'''






@app.route('/add_student2',methods=['post'])
@login_required

def add_student2():
    try:
        fname=request.form['textfield']
        mname=request.form['textfield2']
        lname=request.form['textfield3']
        dob=request.form['textfield4']
        gender=request.form['radiobutton']
        course=request.form['select']
        semester=request.form['select2']
        doa=request.form['textfield5']
        place=request.form['textfield6']
        post=request.form['textfield7']
        pin=request.form['textfield8']
        phone=request.form['textfield9']
        email=request.form['textfield10']
        uname=request.form['textfield11']
        psword=request.form['textfield12']
        pic=request.files['file']
        fn=secure_filename(pic.filename)
        pic.save(os.path.join('static/pic',fn))
        qry="INSERT INTO `login` VALUES(NULL,%s,%s,'student')"
        val=(uname,psword)
        res=iud(qry,val)
        qry1="INSERT INTO `student_table` VALUES(NULL,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val1=(str(res),fname,mname,lname,dob,gender,course,place,post,pin,phone,email,doa,semester)
        iud(qry1,val1)
        q="INSERT INTO `pics` VALUES(NULL,%s,%s)"
        v=(str(res),fn)
        iud(q,v)
        return '''<script> alert("success");window.location="/add_manage_students"</script>'''
    except Exception as e:
        print(e)
        return '''<script> alert("duplicate entry..please try again");window.location="/add_manage_students"</script>'''

@app.route('/update_student',methods=['post'])
@login_required

def update_student():
    try:
        fname=request.form['textfield']
        mname=request.form['textfield2']
        lname=request.form['textfield3']
        dob=request.form['textfield4']
        gender=request.form['radiobutton']
        course=request.form['select']
        semester=request.form['select2']
        doa=request.form['textfield5']
        place=request.form['textfield6']
        post=request.form['textfield7']
        pin=request.form['textfield8']
        phone=request.form['textfield9']
        email=request.form['textfield10']
        pic = request.files['file']
        fn = secure_filename(pic.filename)
        pic.save(os.path.join('static/pic', fn))
        qry1="UPDATE `student_table` SET `first_name`=%s,`middle_name`=%s,`last_name`=%s,`dob`=%s,`gender`=%s,`course`=%s,`place`=%s,`post`=%s,`pin`=%s,`phone`=%s,`email`=%s,`date_of_admision`=%s,`semester`=%s WHERE `login_id`=%s"
        val1=(fname,mname,lname,dob,gender,course,place,post,pin,phone,email,doa,semester,str(session['sid']))
        iud(qry1,val1)
        q="UPDATE `pics` SET `pic`=%s WHERE `stud_id`=%s"
        v=(fn,str(session['sid']))
        iud(q,v)
        return '''<script> alert("updated successfully");window.location="/add_manage_students"</script>'''
    except:
        fname=request.form['textfield']
        mname=request.form['textfield2']
        lname=request.form['textfield3']
        dob=request.form['textfield4']
        gender=request.form['radiobutton']
        course=request.form['select']
        semester=request.form['select2']
        doa=request.form['textfield5']
        place=request.form['textfield6']
        post=request.form['textfield7']
        pin=request.form['textfield8']
        phone=request.form['textfield9']
        email=request.form['textfield10']
        qry1="UPDATE `student_table` SET `first_name`=%s,`middle_name`=%s,`last_name`=%s,`dob`=%s,`gender`=%s,`course`=%s,`place`=%s,`post`=%s,`pin`=%s,`phone`=%s,`email`=%s,`date_of_admision`=%s,`semester`=%s WHERE `login_id`=%s"
        val1=(fname,mname,lname,dob,gender,course,place,post,pin,phone,email,doa,semester,str(session['sid']))
        iud(qry1,val1)
        return '''<script> alert("updated successfully");window.location="/add_manage_students"</script>'''






@app.route('/allocated_subs' )
def allocated_subs():
    qry="SELECT `subject_table`.*,`course_table`.`course` FROM `allocation` JOIN `subject_table` ON `subject_table`.`id`=`allocation`.`subid` JOIN `course_table` ON `course_table`.`id`=`subject_table`.`course_id` WHERE `allocation`.`staffid`=%s"

    res=selectall2(qry,session['lid'])
    return render_template("staff/allocated subs.html",val=res)


@app.route('/chat')
def chat():
    q="SELECT*FROM`student_table`"
    res=selectall(q)
    return render_template("staff/chat.html",val=res)

@app.route('/chat2')
def chat2():
    tid = request.args.get('id')
    session['tid'] = tid
    qry = "SELECT `first_name`,`middle_name`,`last_name` FROM `student_table` WHERE `login_id`=%s"
    val = str(session['tid'])
    s1 = selectone(qry, val)
    print(s1)
    fid = session['lid']
    qry2 = "SELECT * FROM `chat` WHERE (`fromid`=%s AND `toid`=%s) OR (`fromid`=%s AND `toid`=%s) ORDER BY `id` ASC"
    val2 = (str(tid), str(fid), str(fid), str(tid))
    s2 = selectall2(qry2, val2)
    print(s2)

    return render_template("staff/chat2.html",first_name=s1[0],middle_name=s1[1],last_name=s1[2],data=s2,fr=str(tid))
@app.route("/send",methods=['post'])
def send():
    fid = session['lid']
    tid = session['tid']
    msg = request.form['textarea']
    qry = "insert into chat values(NULL,%s,%s,%s,curdate())"
    val = (str(fid), str(tid), msg)
    iud(qry, val)
    return '''<script>alert("send");window.location='usersendchat'</script>'''

@app.route("/usersendchat")
def usersendchat():
    tid=session['tid']
    qry="SELECT `first_name`,`middle_name`,`last_name` FROM `student_table` WHERE `login_id`=%s"
    val=str(session['tid'])
    s1=selectone(qry,val)
    print(s1)
    fid=session['lid']
    qry2="SELECT * FROM `chat` WHERE (`fromid`=%s AND `toid`=%s) OR (`fromid`=%s AND `toid`=%s) ORDER BY `id` ASC"
    val2 = (str(tid), str(fid), str(fid), str(tid))
    s2=selectall2(qry2,val2)
    print(s2 )
    return render_template("staff/chat2.html",first_name=s1[0],middle_name=s1[1],last_name=s1[2],data=s2,fr=str(tid))


@app.route('/manage_exam')
@login_required

def manage_exam():
    q="SELECT `exam`.*,`subject_table`.`subject` FROM `exam` JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid` "
    res=selectall(q)
    return render_template("staff/manage exam.html",val=res)

@app.route('/del_exm')
@login_required

def del_exm():
    id=request.args.get('id')
    q="DELETE FROM `exam` WHERE`id`=%s"
    v=(str(id))
    iud(q,v)
    return '''<script> alert("deleted successfully");window.location="/manage_exam"</script>'''
@app.route('/edit_exam_notification')
@login_required

def edit_exam_notification():
    id=request.args.get('id')
    session['edi']=id
    q="SELECT `exam`.*,`subject_table`.`subject` FROM `exam` JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid` WHERE `exam`.`id`=%s"
    v=(str(id))
    res=selectone(q,v)
    q1="SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` JOIN `staff` ON `staff`.`loginid`=`allocation`.`staffid` WHERE `allocation`.`staffid`=%s"
    res11=selectall2(q1,session['lid'])
    return render_template("staff/edit exam notification.html",val=res,vals=res11)

@app.route('/study_material')
@login_required
def study_material():

    staffid=session['ln']
    # qry="SELECT `subject_table`.*,`course_table`.`course` FROM `subject_table` JOIN `course_table` ON `course_table`.`id`=`subject_table`.`course_id` "
    qry="SELECT `allocation`.*,`subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` WHERE `allocation`.`staffid`=%s"
    res=selectall2(qry,staffid)
    return render_template("staff/study material.html",val=res)

@app.route('/material_upload',methods=['post'])
@login_required
def material_upload():
    subject=request.form['select']
    material=request.files['file']
    fn=secure_filename(material.filename)
    material.save(os.path.join('static/materials',fn))
    q="INSERT INTO `study_material` VALUES (NULL,%s,%s)"
    v=(subject,fn)
    iud(q,v)
    return '''<script> alert("uploaded successfully");window.location="/staff_home"</script>'''

@app.route('/attendance_upload',methods=['post'])
@login_required
def attendance_upload():
    stid=request.form['select']
    attendance=request.files['file']
    fn=secure_filename(attendance.filename)
    attendance.save(os.path.join('static/attendance',fn))
    q="INSERT INTO attendance VALUES (NULL,%s,%s,curdate())"
    v=(stid,fn)
    iud(q,v)
    return '''<script> alert("uploaded successfully");window.location="/staff_home"</script>'''


@app.route('/upload_video')
@login_required

def upload_video():
    id=session['ln']
    qry="SELECT `subject_table`.*,`course_table`.`course` FROM `allocation` JOIN `subject_table` ON `subject_table`.`id`=`allocation`.`subid` JOIN `course_table` ON `course_table`.`id`=`subject_table`.`course_id` WHERE `allocation`.`staffid`=%s"
    v=(str(id))
    res=selectall2(qry,v)
    return render_template("staff/upload video.html",val=res)

@app.route('/video_upload',methods=['post'])
@login_required

def video_upload():


    staffid= session['ln']
    subject=request.form['select']
    topic=request.form['textfield']
    video=request.files['file']
    fn=secure_filename(video.filename)
    # path=r"../static/videos"
    video.save(os.path.join('static/video',fn))
    q="INSERT INTO `video` VALUES (NULL,%s,%s,%s,%s)"
    v=(staffid,subject,topic,fn)
    iud(q,v)
    return '''<script> alert("success");window.location="/staff_home"</script>'''


# add_attendance

@app.route('/view_attendance')
def view_attendance():
    q="SELECT * FROM student_table"
    res=selectall(q)
    print(res)

    res1 = selectall("select attendance.*,student_table.first_name from attendance,student_table where attendance.sid = student_table.id")
    ress=[]
    for i in res:
        row=[i[0],i[1],i[2]]
        ress.append(row)
    return render_template("staff/view attendance.html",val=ress,b=res,data = res1)






@app.route('/select_subj',methods=['get','post'])
@login_required
def select_subj():
    cr = request.form['cr']
    sem=request.form['sem']
    qry="select * from `subject_table` WHERE `course_id`=%s AND `semester`=%s"
    val=(cr,sem)
    s=selectall2(qry,val)
    lis=[0,'select']
    for r in s:
        lis.append(r[0])
        lis.append(r[3])
    print(lis)
    resp = make_response(jsonify(lis))
    resp.status_code = 200
    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp

@app.route('/select_staff',methods=['get','post'])
@login_required

def select_staff():
    cr = request.form['cr']
    qry="SELECT * FROM `staff_table` WHERE course=%s"
    val=(cr)
    s=selectall2(qry,val)
    lis=[0,'select']
    for r in s:
        lis.append(r[0])
        lis.append(r[2] + " "+r[3] +" " +r[4])
    print(lis)
    resp = make_response(jsonify(lis))
    resp.status_code = 200
    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp

@app.route('/select_subject',methods=['get','post'])
@login_required

def select_subject():
    cr = request.form['cr']
    print(cr)
    qry = "SELECT*FROM `subject_table` WHERE `course_id`=%s"
    val = (cr)
    s = selectall2(qry, val)
    lis = [0, 'select']
    for r in s:
        lis.append(r[0])
        lis.append(r[3])
    print(lis)
    resp = make_response(jsonify(lis))
    resp.status_code = 200
    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp


@app.route('/allocate_tt',methods=['post'])
@login_required
def allocate_tt():
    course=request.form['select']
    sem=request.form['select2']
    time_table=request.files['file']
    file=secure_filename(time_table.filename)
    time_table.save(os.path.join("static/timetable",file))
    q="INSERT INTO `timetable` VALUES(%s,NULL,%s,%s)"
    v=(file,course,sem)
    iud(q,v)
    return '''<script> alert("success");window.location="/timetable"</script>'''





@app.route('/Add_and_Manage_exam')
@login_required
def Add_and_Manage_exam():
    q = "SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` WHERE `allocation`.`staffid`=%s"
    res = selectall2(q, session['lid'])
    q1="SELECT *FROM exam"
    res1=selectall(q1)
    return render_template("staff/Add and Manage exam.html",v=res,v1=res1)
@app.route('/searchexam',methods=['post'])
@login_required
def searchexam():
    button=request.form['Submit']
    subject=request.form['select']
    exam=request.form['select2']
    q = "SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` WHERE `allocation`.`staffid`=%s"
    res = selectall2(q,session['lid'])
    q1 = "SELECT *FROM exam"
    res1 = selectall(q1)
    if button=="Search":
        qry="SELECT `exam`.`exam_name`,`questions`.* FROM `exam` JOIN `questions` ON `questions`.`exam_id`=`exam`.`id` WHERE `questions`.`exam_id`=%s AND `exam`.`sid`=%s"
        v=(exam,subject)
        s=selectall2(qry,v)
        return render_template("staff/Add and Manage exam.html", v=res, v1=res1,val=s)
    else:
        q = "SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` WHERE `allocation`.`staffid`=%s"
        res = selectall2(q, session['lid'])
        q1 = "SELECT *FROM exam"
        res1 = selectall(q1)
        return render_template('staff/Add Questions.html', v=res, v1=res1)


@app.route('/select_course_subject',methods=['get','post'])
def select_course_subject():
    sid = request.form['brand']
    print(sid,"==============================")
    # cmd.execute("SELECT `allot_id`,`course_id`,`subject` FROM `subjectmanagement` WHERE `course_id` IN (SELECT `course_id` FROM `coursemanagement` WHERE `coursemanagement`.`coursename`='"+company+"')")
    # s=cmd.fetchall()
    q="SELECT `exam`.* FROM `exam` JOIN `subject_table` ON `subject_table`.id=`exam`.sid WHERE `subject_table`.`subject`=%s"
    # q="SELECT * FROM `exam` WHERE sid=%s"
    s=selectall2(q,sid)
    lis=[0,'select']
    for r in s:
        lis.append(r[0])
        lis.append(r[4])
    print(lis)
    resp = make_response(jsonify(lis))
    resp.status_code = 200
    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp

@app.route('/Add_Questions',methods=['post'])
@login_required
def Add_Questions():
    exam_name=request.form['select2']
    questions=request.form['textfield']
    option1=request.form['textfield2']
    option2 = request.form['textfield3']
    option3 = request.form['textfield4']
    option4 = request.form['textfield5']
    answer=request.form['textfield6']
    qry="INSERT INTO questions values(null,%s,%s,%s,%s,%s,%s,%s)"
    val=(exam_name,questions,option1,option2,option3,option4,answer)
    iud(qry,val)
    return '''<script> alert("success");window.location="Add_and_Manage_exam"</script>'''

@app.route('/editQuestions')
@login_required
def editQuestions():
    id=request.args.get('id')
    session['id']=id
    q = "SELECT `subject_table`.* FROM `subject_table` JOIN `allocation` ON `allocation`.`subid`=`subject_table`.`id` WHERE `allocation`.`staffid`=%s"
    r = selectall2(q,session['lid'])
    print(r,"====")
    qry="SELECT *FROM questions WHERE Qid=%s"
    res1=selectone(qry,id)
    return render_template('staff/editQuestions.html',v=res1,subb=r)
@app.route('/delq')
@login_required
def delq():
    id=request.args.get('id')
    q="DELETE FROM `questions` WHERE`Qid`=%s"
    v=(str(id))
    iud(q,v)
    return '''<script> alert("deleted successfully");window.location="/Add_and_Manage_exam"</script>'''
@app.route('/edit2Questions',methods=['post'])
@login_required
def edit2Questions():
    exam_name = request.form['select2']
    questions = request.form['textfield']
    option1 = request.form['textfield2']
    option2 = request.form['textfield3']
    option3 = request.form['textfield4']
    option4 = request.form['textfield5']
    answer = request.form['textfield6']
    qry="UPDATE questions SET question=%s,option1=%s,option2=%s,option3=%s,option4=%s,answer=%s WHERE Qid=%s "
    val=(questions,option1,option2,option3,option4,answer,session['id'])
    iud(qry,val)
    return '''<script> alert("updated");window.location="Add_and_Manage_exam"</script>'''




@app.route('/view_answer')
@login_required

def view_answer():

    qry="SELECT student_table.first_name,subject_table.subject,exam.exam_name,exam.date,marks.`marks` FROM student_table,subject_table,`exam`,`marks` WHERE `marks`.lid=student_table.login_id AND `subject_table`.`id` = `exam`.`sid` AND `marks`.lid = `student_table`.`login_id`"

    # q="SELECT `student_table`.*,`subject_table`.*,`allocation`.*,`answer`.*,`exam`.`id` FROM `exam` JOIN `answer` ON `answer`.`exam_id`=`exam`.`id` JOIN `allocate` ON `allocation`.`tea_id`=`exam`.`staffid` INNER JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid` JOIN `student_table` ON `student_table`.`login_id`=`answer`.`student_id`"
    res=selectall(qry)
    print(res)
    return render_template("staff/view answer.html",val=res)



#view attendance


@app.route('/view_time_schedule')
@login_required
def view_time_schedule():
    lid=session['ln']
    q="SELECT `timetable`.*,`course_table`.`course` FROM `timetable` JOIN `course_table` ON `course_table`.`id`=`timetable`.`courseid`"
    res=selectall(q)

    # qry=""
    # day=selectall(qry)
    # if day=="1":
    #     day="monday"
    # elif day=="2":
    #     day=
    return render_template("staff/view time schedule.html",val=res)



@app.route('/view_student_performance')
@login_required
def view_student_performance():
    id = request.args.get('id')
    res=selectall("select  marks.marks, exam.exam_name , subject_table.subject from marks,exam,subject_table where marks.eid = exam.id and exam.sid = subject_table.id and marks.lid = '"+str(id)+"'")
    x=[]
    y=[]
    for i in range(0,len(res)):
        x.append(i+1)
        y.append(res[i][0])
    import matplotlib.pyplot as plt
    import numpy as np

    # Define X and Y variable data


    plt.plot(x, y)
    plt.xlabel("Sl. No")  # add X-axis label
    plt.ylabel("Mark")  # add Y-axis label
    plt.title("Student Perfomance")  # add title
    from datetime import datetime
    fn=datetime.now().strftime("%Y%m%d%H%M%S")+".png"
    plt.savefig("static/graph/"+fn)
    plt.close()

    return render_template("staff/view_performance.html", val=res,fn="../static/graph/"+fn)



app.run(debug=True)

