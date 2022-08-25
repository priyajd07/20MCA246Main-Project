import os
from flask import*
import pymysql
from werkzeug.utils import secure_filename
from src.new import imgprocessing
from src.apri import aprioris

app=Flask(__name__)
from datetime import *
con=pymysql.connect(host="localhost",user="root",password="",port=3306,db="criminal face identification")
cmd=con.cursor()
app.secret_key="qwer"
path=r"./static/criminalpic"
from web3 import Web3, HTTPProvider

blockchain_address = 'HTTP://127.0.0.1:7545'
# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
web3.eth.defaultAccount = web3.eth.accounts[0]

compiled_contract_path = r'D:\criminal face identifiication\criminal face identifiication\src\node_modules\.bin\build\contracts\MigrationsCase.json'
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0xb737139F6EBacC43C55d3ff436708Bc37eFA7aa8'



import functools
def login_required(func):
    @functools.wraps(func)
    def secure_function():
        if "lid" not in session:
            return redirect ("/")
        return func()
    return secure_function



@app.route('/')
def main():
    return render_template("login.html")


@app.route('/logout')
def logout():
    session.clear()
    return render_template("login.html")

@app.route('/login',methods=['get','post'])
def login():
    username=request.form['textfield']
    password=request.form['textfield2']
    cmd.execute("select*from login where username='"+username+"' and password='"+password+"'")
    s=cmd.fetchone()
    if s is None:
        return '''<script>alert("invalid");window.location="/"</script>'''
    elif s[3]=="admin":
        session['lid'] = s[0]
        return '''<script>alert("success");window.location="/adminhome"</script>'''
    elif s[3] == "forensic":
        session['lid']=s[0]
        return '''<script>alert("success");window.location="/forensic_home"</script>'''

    elif s[3] == "police":
        session['lid'] = s[0]
        return '''<script>alert("success");window.location="/police_home"</script>'''
    else:
        return '''<script>alert("login success");window.location="/"</script>'''
@app.route('/police_station_home',methods=['get','post'])
def police_station_home():
    return render_template("home.html")
@app.route('/forensic_home',methods=['get','post'])
def forensic_home():
    return render_template("home.html")
@app.route('/police_home',methods=['get','post'])
def police_home():
    return render_template("police home.html")

@app.route('/sendreport',methods=['get','post'])
def sendreport():
    cmd.execute("select*from view_task where p_id='"+str(session['lid'])+"'")
    s=cmd.fetchall()
    return render_template("send task report.html",val=s)


@app.route('/viewnoti',methods=['get','post'])
def viewnoti():
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="criminal face identification")
    cmd = con.cursor()

    cmd.execute("SELECT * FROM `notification`")
    s=cmd.fetchall()
    return render_template("viewnoti.html",val=s)




@app.route('/sendreport1',methods=['get','post'])
def sendreport1():
    wordid =request.form["select"]
    photo = request.files['file']
    print(photo)
    var = secure_filename(photo.filename)
    # path1 =r".static/report/"
    print(var)

    # photo.save(os.path.join(path1, var))
    photo.save("static/report"+var)
    cmd.execute("insert into sent_report values(null,'"+wordid+"','"+var+"') ")
    con.commit()

    path1 = r"./static/report"

    return '''<script>alert("sent..............");window.location="/police_station_home"</script>'''


@app.route('/sendreportnew',methods=['get','post'])
def sendreportnew():
    wordid =request.form["select"]
    photo = request.files['file']
    print(photo)
    var = secure_filename(photo.filename)
    # path1 =r".static/report/"
    print(var)

    # photo.save(os.path.join(path1, var))
    photo.save("static/report"+var)
    cmd.execute("insert into sent_report values(null,'"+wordid+"','"+var+"') ")
    con.commit()

    path1 = r"./static/report"

    return '''<script>alert("sent..............");window.location="/police_home"</script>'''




@app.route('/viewtask1',methods=['get','post'])
def viewtask1():
    return render_template("view tasks.html")


@app.route('/add_police_station',methods=['get','post'])
def add_police_station():
    name=request.form['textfield']
    email=request.form['textfield2']
    phone=request.form['textfield3']
    place=request.form['textfield4']
    pincode=request.form['textfield5']
    username=request.form['textfield6']
    password=request.form['textfield7']
    cmd.execute("insert into login values(null,'"+username+"','"+password+"','police')")
    id=con.insert_id()
    cmd.execute("insert into police_statiion values(null,'"+name+"','"+email+"','"+phone+"','"+place+"','"+pincode+"','"+str(id)+"')")
    con.commit()
    return '''<script>alert("registration success");window.location="/adminhome"</script>'''


@app.route('/adminhome')
def adminhome():
    return render_template("admin home.html")

@app.route('/addcriminaldetails',methods=['get','post'])
@login_required
def addcriminaldetails():
    cmd.execute("SELECT * FROM `crime_type`")
    s=cmd.fetchall()
    return render_template("add criminal details.html",val=s)

@app.route('/addcriminaldetails1',methods=['get','post'])
def addcriminaldetails1():
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="criminal face identification")
    cmd = con.cursor()
    name=request.form['textfield']
    photo=request.files['file']
    var=secure_filename(photo.filename)
    photo.save(os.path.join(path,var))
    address=request.form['textfield4']
    phone_no=request.form['phone']
    offence = request.form['select']
    pattern = request.form['textfield6']
    date_of_registration = request.form['textfield6']
    cmd.execute("insert into criminal_list values(null,'"+name+"','"+phone_no+"','"+address+"','"+var+"','"+offence+"','"+date_of_registration+"','"+pattern+"')")
    cid=con.insert_id()
    con.commit()
    imgprocessing(os.path.join(path,var),str(cid))

    return  '''<script>alert("insert");window.location='/police_home'</script>'''


@app.route('/assigntask')
def assigntask():
    cmd.execute("select * from register_police")
    s = cmd.fetchall()

    return render_template("assign task.html",val=s)

@app.route('/assigntask1',methods=['post'])
def assigntask1():
    task=request.form['textfield2']
    pid=request.form['select']
    cmd.execute("insert into `view_task_status` values(null,'"+pid+"','"+task+"',curdate(),'pending')")
    con.commit()
    return redirect('/police_station_home')

@app.route('/COMPLAINT')
@login_required
def COMPLAINT():
    cmd.execute("SELECT `complaint`.*,`signup`.* FROM `complaint` JOIN `signup` ON `signup`.`login_id`=`complaint`.`u_id` WHERE `complaint`.`reply`='pending'")
    s=cmd.fetchall()

    return render_template("COMPLAINT.html",val=s)



@app.route('/searchmanagepolicestation',methods=['get','post'])
def searchmanagepolicestation():
    type=request.form['select']
    cmd.execute("SELECT * FROM police_statiion JOIN `login` ON `login`.`id`=`police_statiion`.`login_id` WHERE `login`.`type`='"+type+"'")
    s = cmd.fetchall()

    return render_template("manage police station.html", val=s,type=str(type))


@app.route('/managepolicestation')
@login_required
def managepolicestation():
    cmd.execute("select * from police_statiion")
    s=cmd.fetchall()

    return render_template("manage police station.html",val=s)

@app.route('/editpolice_statiion',methods=['get','post'])
def editpolice_statiion():
    id=request.args.get('id')
    session['sid']=id
    cmd.execute("select * from police_statiion where p_id='"+str(id)+"'")
    s=cmd.fetchone()
    return render_template("editpolice_station.html",val=s)
@app.route('/updatestation',methods=['get','post'])
def updatestation():
    name=request.form['textfield']
    email=request.form['textfield2']
    phone=request.form['textfield3']
    place=request.form['textfield4']
    pincode=request.form['textfield5']
    cmd.execute("update police_statiion set name='"+name+"',phone='"+phone+"',email='"+email+"',place='"+place+"',pincode='"+pincode+"' where p_id='"+str(session['sid'])+"'")
    con.commit()
    return  '''<script>alert("updated");window.location="/managepolicestation"</script>'''

@app.route('/deletestation',methods=['get','post'])
def deletestation():
    sid=request.args.get('id')
    cmd.execute("delete from police_statiion  where p_id='"+str(sid)+"'")
    con.commit()
    return '''<script>alert("delete");window.location="/managepolicestation"</script>'''

@app.route('/police_station_reg',methods=['get','post'])
def police_station_reg():
    try:
        name=request.form['textfield']
        email=request.form['textfield2']
        phone=request.form['textfield3']
        place=request.form['textfield4']
        pincode=request.form['textfield5']
        username=request.form['textfield6']
        password=request.form['textfield7']
        type=request.form['select']
        cmd.execute("insert into login values(null,'"+username+"','"+password+"','"+type+"')")
        id=con.insert_id()
        cmd.execute("insert into police_statiion values(null,'"+name+"','"+phone+"','"+email+"','"+place+"','"+pincode+"','"+str(id)+"')")
        con.commit()
        return '''<script>alert("registration success");window.location="/adminhome"</script>'''
    except Exception as e:
        return '''<script>alert("duplicate entry");window.location="/adminhome"</script>'''



@app.route('/policestationreg')
@login_required

def policestationreg():
    return render_template("police station reg.html")
@app.route('/regpolice')
def regpolice():
    return render_template("reg police.html")


@app.route('/addpolice',methods=['post'])
def addpolice():
    fname=request.form['textfield2']
    lastnamr = request.form['textfield3']
    gender = request.form['radiobutton']
    email = request.form['textfield4']
    phone = request.form['textfield5']
    DOB = request.form['textfield6']
    rank = request.form['textfield7']
    usename = request.form['textfield8']
    password = request.form['textarea']
    cmd.execute("insert into login values(null,'"+usename+"','"+password+"','police')")
    id=con.insert_id()
    cmd.execute("insert into police_statiion values(null,'"+fname+"','"+lastnamr+"','"+gender+"','"+email+"','"+phone+"','"+DOB+"','"+rank+"','"+str(session['lid'])+"','"+str(id)+"')")
    con.commit()
    return '''<script>alert("registration success");window.location="/police_station_home"</script>'''



@app.route('/registration')
def registration():
    return render_template("registration.html")
@app.route('/sendcomplant')
def sendcomplant():
    return render_template("send complant.html")

@app.route('/sendrportpolice')
def sendrportpolice():
    return render_template("send rport police.html")
@app.route('/viewandmanagecriminallist')
@login_required
def viewandmanagecriminallist():
    cmd.execute("SELECT `criminal_list`.* FROM `criminal_list` ")
    s=cmd.fetchall()
    print(s)
    return render_template("view and manage criminal list.html",val=s)

@app.route('/deletecriminallist',methods=['get','post'])
def deletecriminallist():
    sid=request.args.get('id')
    cmd.execute("delete from criminal_list  where criminal_id='"+str(sid)+"'")
    con.commit()
    return '''<script>alert("delete");window.location="/viewandmanagecriminallist"</script>'''

@app.route('/viewcriminallist',methods=['get','post'])
@login_required
def viewcriminallist():
    cmd.execute("select * from criminal_list")
    s = cmd.fetchall()
    print(s)
    return render_template("view criminal list.html", val=s)




@app.route('/sndrp')
def sndrp():
    id=request.args.get('id')
    session['id']=id

    return render_template("send complant_reply.html")





@app.route('/sndrp1',methods=['post'])
def sndrp1():
    id= session['id']
    reply=request.form['textfield']
    cmd.execute("update complaint set reply='"+reply+"' where complaint_id='"+id+"'")
    con.commit()
    return redirect('COMPLAINT')

@app.route('/viewcomplantstatus')
def viewcomplantstatus():
    return render_template("view complant status.html")

@app.route('/viewcriminaldetailespublic')
def viewcriminaldetailespublic():
    return render_template("view criminal detailes public 1.html")

@app.route('/viewcriminaldetailes')
def viewcriminaldetailes():
    cmd.execute("select*from criminal_list")
    s=cmd.fetchall()
    return render_template("view criminal details.html",val=s)

@app.route('/viewprofile',methods=['get','post'])
def viewprofile():
    print(session['lid'])
    cmd.execute("select * from register_police where login_id='"+str(session['lid'])+"'")
    s=cmd.fetchone()
    print(s)
    return render_template("view profile.html",val=s)

@app.route('/updateprofile',methods=['get','post'])
def updateprofile():
    firstname = request.form['textfield']
    lastname = request.form['textfield2']
    email = request.form['textfield3']
    phone = request.form['textfield4']
    DOB= request.form['textfield5']
    rank= request.form['textfield6']
    cmd.execute("update register_police set first_name='"+firstname+"',last_name='"+lastname+"',email='"+email+"',phone='"+phone+"',DOB='"+DOB+"',rank='"+rank+"' where login_id='"+str(session['lid'])+"'")
    con.commit()
    return '''<script>alert("update success");window.location="/police_home"</script>'''






@app.route('/viewrecord')
def viewrecord():
    cmd.execute("SELECT `criminal_record`.*,`criminal_list`.* FROM `criminal_list` JOIN `criminal_record` ON `criminal_list`.`criminal_id`=`criminal_record`.`cid`")
    s = cmd.fetchall()
    return render_template("view record.html",val=s)
@app.route('/viewtaskstatus')
def viewtaskstatus():
    cmd.execute("SELECT `register_police`.*,`view_task_status`.* FROM `view_task_status` JOIN `register_police` ON `view_task_status`.p_id=`register_police`.p_id")
    s=cmd.fetchall()
    return render_template("view task status.html",val=s)
@app.route('/viewtask')
def viewtask():
    p_id=session['lid']
    cmd.execute("SELECT*FROM  view_task_status WHERE p_id='"+str(p_id)+"' AND `status`='pending'")
    s=cmd.fetchall()

    return render_template("view tasks.html",val=s)


@app.route('/updatestatus',methods=['get','post'])
def updatestatus():
    id=request.args.get('id')
    print(id)
    session['sid']=id
    return render_template("updatestatus.html")

@app.route('/updatestatus1',methods=['get','post'])
def updatestatus1():

    ssid=session['sid']
    status=request.form['textfield']
    cmd.execute("update view_task_status set status='"+status+"' where w_id='"+str(ssid)+"'")
    con.commit()
    return '''<script>alert("update success");window.location="/police_home"</script>'''

@app.route('/crimepattern')
@login_required
def crimepattern():
    cmd.execute("SELECT  DISTINCT pattern FROM `criminal_list` union SELECT DISTINCT `crime_type` FROM `dataset`")
    s = cmd.fetchall()
    return render_template('crimepattern.html',p=s)





@app.route('/crime_pattern',methods=['GET','POST'])
def crime_pattern():
        pattern= request.form['select']
        cmd.execute("SELECT `crime_type`.`crime_type`,`criminal_list`.`criminal_name`,`criminal_list`.`place` FROM `criminal_list` JOIN `crime_type` ON `crime_type`.`id`=`criminal_list`.`crime`  WHERE `pattern`='"+pattern+"'")
        results = cmd.fetchall()

        cmd.execute("SELECT * FROM `dataset`  WHERE `crime_type`='"+pattern+"'")
        results1 = cmd.fetchall()

        roww=[]
        for i in results:
            roww.append(i)
            print(i)
        for i in results1:
            rr = [i[2], i[3], i[1]]
            print(rr,i[4])
            for jj in range(int(i[4])):
                rr=[i[2],i[3],i[1]]
                roww.append(rr)
        print(len(roww))
        ap = aprioris()
        accident = ap.apriori1(roww)

        ss = list(accident.split("frozenset"))
        print("-------------")

        print(ss)
        li = []
        i = 0
        for s in ss:

            sss = s.split(',')
            if len(sss) > 2:
                s1 = s.replace(']', '')
                li.append(s1)
            i = i + 1
        print(li)
        lii = str(li)
        ha = []
        ha = lii.replace('"', '')

        ha1 = []
        ha1 = ha.replace('{', '')

        ha2 = []
        ha2 = ha1.replace('}', '')

        ha3 = ha2.replace('[', '')

        ha4 = ha3.replace(']', '')
        print("ha4444", ha4)
        hh = []
        hh = ha4.split(', ,')

        print("hhhhh", hh)

        return render_template('result2.html', val=hh)

@app.route('/add_crime_type',methods=['get','post'])
def add_crime_type():
    return render_template("add crimetype.html")


@app.route('/add_crime_typee',methods=['get','post'])
@login_required
def add_crime_typee():
    return render_template("add crimetype.html")


@app.route('/add_crime_typeenew',methods=['get','post'])
def add_crime_typeenew():
    crime=request.form['textfield']
    description = request.form['textarea']
    cmd.execute("INSERT INTO `crime_type` VALUES(NULL,'"+crime+"','"+description+"')")
    con.commit()
    return '''<script>alert("success");window.location="/manage_crimetype"</script>'''

@app.route('/manage_crimetype',methods=['get','post'])
@login_required
@login_required
def manage_crimetype():
    cmd.execute("SELECT * FROM `crime_type`")
    s=cmd.fetchall()

    return render_template("manage crimetype.html",val=s)

@app.route('/dlttype',methods=['get','post'])
def dlttype():
    id=request.args.get('id')
    cmd.execute("DELETE FROM `crime_type` WHERE `id`='"+str(id)+"'")
    con.commit()
    return '''<script>alert("success");window.location="/manage_crimetype"</script>'''

@app.route('/view_reported_criminal',methods=['get','post'])
@login_required
def view_reported_criminal():

    cmd.execute("SELECT `signup`.*,`criminal_list`.* FROM `criminal_list` JOIN `report_criminal` ON `report_criminal`.`criminalid`=`criminal_list`.`criminal_id` JOIN `signup` ON `signup`.`login_id`=`report_criminal`.`userid`")
    s=cmd.fetchall()
    return render_template("view_reported_criminals.html",val=s)

@app.route('/viewcases')
def viewcases():
    cmd.execute("SELECT complaint . * , `police_statiion` . NAME,`request`.`request`,`request`.`date`,request.id FROM complaint JOIN allocation ON complaint.complaint_id=allocation.complaint_id JOIN `police_statiion` ON `police_statiion`.login_id=allocation.police_id JOIN login ON `police_statiion`.login_id=login.id JOIN request ON `allocation`.`complaint_id`=`request`.cid WHERE `request`.fid='"+str(session['lid'])+"'")
    s=cmd.fetchall()
    return render_template('case.html',v=s)

@app.route('/send_request_update',methods=['get','post'])
def send_request_update():
    status=request.form['textfield']
    cmd.execute("UPDATE `request` SET `status`='"+status+"' WHERE `id`='"+str(session['rid'])+"'")
    con.commit()
    return '''<script>alert("success");window.location="/viewcases"</script>'''




@app.route('/statusupdate')
def statusupdate():
    id=request.args.get('id')
    session['rid']=id
    return render_template('status.html')

@app.route('/home')
def home():
    return render_template('home.html')

@app.route('/reportupload')
def reportupload():
    return render_template('uploadreport.html')
@app.route('/reports')
def reports():
    return render_template('report.html')
@app.route('/historyview')
def historyview():
    return render_template('viewhistory.html')
@app.route('/allocatepolice')
def allocatepolice():
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="criminal face identification")
    cmd = con.cursor()
    id=request.args.get('id')
    session['cid']=id
    cmd.execute("select * from police_statiion join login on login.id=police_statiion.login_id where login.type='police'")
    s=cmd.fetchall()
    return render_template('allocate police.html',val=s)

@app.route('/add_allocate_police',methods=['get','post'])
def add_allocate_police():
    Police=request.form['select']
    cmd.execute("INSERT INTO `allocation` VALUES(NULL,'"+session['cid']+"','"+Police+"','pending',curdate())")
    con.commit()
    cmd.execute("update COMPLAINT set reply='assigned' where complaint_id='"+str(session['cid'])+"'")
    con.commit()
    return '''<script>alert("success");window.location="/COMPLAINT"</script>'''


@app.route('/view_allocated_case')
def view_allocated_case():
    cmd.execute("SELECT `complaint`.*,`signup`.`fname`,`signup`.`lname`,`signup`.`phone_no` FROM `complaint` JOIN `allocation` ON `complaint`.`complaint_id`=`allocation`.`complaint_id` JOIN `signup` ON `signup`.`login_id`=`complaint`.`u_id` WHERE `allocation`.`police_id`='"+str(session['lid'])+"'")
    res=cmd.fetchall()
    return render_template('view allocated case.html',val=res)

@app.route('/assign_forensic')
def assign_forensic():
    id=request.args.get('id')
    session['cid']=id
    cmd.execute("SELECT police_statiion.* FROM police_statiion JOIN login ON police_statiion.login_id=login.id WHERE login.type='forensic'")
    res=cmd.fetchall()
    return render_template('assign forensic.html', val=res)

@app.route('/request_to_forensic',methods=['get','post'])
@login_required
def request_to_forensic():
    forensic=request.form['select']
    req=request.form['textarea']
    cmd.execute("insert into request values(null,'"+str(session['cid'])+"','"+str(forensic)+"','"+req+"',curdate(),'pending')")
    con.commit()
    cmd.execute("UPDATE `complaint` SET `reply`='assigned' WHERE `complaint_id`='"+str(session['cid'])+"'")
    con.commit()
    return '''<script>alert("Assigned");window.location="/view_allocated_case"</script>'''

@app.route('/upld_evidence')
@login_required
def upld_evidence():
    id=request.args.get('id')
    session['cid']=id
    return render_template('police evidence upload.html')
@app.route('/upld_evidence1',methods=['get','post'])
@login_required
def upld_evidence1():
    evidence=request.files['file']
    fn=secure_filename(evidence.filename)
    path=r'./static/evidence'
    evidence.save(os.path.join(path,fn))
    des=request.form['textarea']
    cmd.execute("INSERT INTO `evidence` VALUES(NULL,'"+str(session['cid'])+"','"+fn+"','"+des+"',CURDATE())")
    cid=con.insert_id()
    typee="police evidence"
    report=fn
    con.commit()

    with open(compiled_contract_path) as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
        date = datetime.now().strftime("%Y-%m-%d")
        contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.report_info(blocknumber + 1, int(cid),typee,report, date).transact()
        print(blocknumber,"++++++++++++++++++======")
        print(message2)


    return '''<script>alert("Evidence Uploaded");window.location="/view_allocated_case"</script>'''

@app.route('/view_history')
def view_history():
    cmd.execute("SELECT `complaint`.`complaint`,`request`.`request`,`police_statiion`.`name`,`request`.`date`,`request`.`status`,`report`.`report` FROM `complaint` JOIN `request` ON `request`.`cid`=`complaint`.`complaint_id`  JOIN `allocation` ON `allocation`.`complaint_id`=`complaint`.`complaint_id`   JOIN `police_statiion` ON `police_statiion`.`login_id`=`allocation`.`police_id` JOIN `report` ON `report`.`compid`=`complaint`.`complaint_id`")
    res=cmd.fetchall()
    print(res)
    return render_template("view history.html",val=res)

@app.route('/upload_report')
def upload_report():
    cmd.execute(
        "SELECT `complaint`.`complaint`,`request`.`request`,`police_statiion`.`name`,`request`.`date`,`request`.`status`,`complaint`.`complaint_id` FROM `complaint` JOIN `request` ON `request`.`cid`=`complaint`.`complaint_id`  JOIN `allocation` ON `allocation`.`complaint_id`=`complaint`.`complaint_id`   JOIN `police_statiion` ON `police_statiion`.`login_id`=`allocation`.`police_id`")
    res = cmd.fetchall()
    print(res)
    return render_template("uploadreport.html", val=res)

@app.route('/uploadreport')
def uploadreport():
    id=request.args.get('id')
    session['compid']=id
    return render_template("upload report.html")

@app.route('/uploadreport1',methods=['post'])
def uploadreport1():
    report=request.files['file']
    imgnm=secure_filename(report.filename)
    report.save(os.path.join('static/report',imgnm))
    cmd.execute("INSERT INTO `report` VALUES(NULL,'"+session['compid']+"','"+imgnm+"',CURDATE())")
    cid=con.insert_id()
    typee="forensic report"
    report=imgnm
    con.commit()




    with open(compiled_contract_path) as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
        date = datetime.now().strftime("%Y-%m-%d")
        contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.report_info(blocknumber + 1, int(cid),typee,report, date).transact()
        print(blocknumber,"++++++++++++++++++======")
        print(message2)


    return '''<script>alert("uploaded");window.location="/upload_report"</script>'''




if (__name__=="__main__"):
    app.run(debug=True)











