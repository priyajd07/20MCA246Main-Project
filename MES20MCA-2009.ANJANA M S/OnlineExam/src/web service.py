from datetime import datetime

from flask import *
from werkzeug.utils import secure_filename

from src.dbconnection import *
from datetime import datetime

from flask import *
from werkzeug.utils import secure_filename

from src.dbconnection import *
from src.recognize_face import *
from src.encode_faces import *
app=Flask(__name__)
# from web3 import Web3, HTTPProvider
blockchain_address = 'HTTP://127.0.0.1:7545'
# Client instance to interact with the blockchain
# web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
# web3.eth.defaultAccount = web3.eth.accounts[0]

compiled_contract_path = r'C:\Users\91989\PycharmProjects\forensic_evidence\src\node_modules\.bin\build\contracts\onlineexamination.json'
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0x95D727FdCa575Ee77EE83a769cAe3995eC103Aa8'


@app.route('/login',methods=['post'])
def login():
    username=request.form['username']
    password=request.form['password']
    qry='select * from login where username=%s and password=%s'
    val=(username,password)
    res=selectone (qry,val)
    if res is None:
        return jsonify({'task':'invalid'})
    else:
        return jsonify({'task':'success','id':str(res[0])})
@app.route('/addimg',methods=['post','get'])
def addimg():
    img=request.files['files']
    import time
    fn=time.strftime("%Y%m%d_%H%M%S")+".jpg"
    img.save("static/pic/"+fn)
    q="SELECT `student_table`.`login_id`,`student_table`.`first_name`,`pics`.`pic` FROM `student_table` JOIN `pics` ON `student_table`.`login_id`=`pics`.`stud_id`"
    s=selectall(q)
    enf("static/pic/"+fn)
    for r in s:
        res=rec_face_image("static/pic/"+r[2])
        if len(res)>0:
            return jsonify({"result":r[1]+"#"+str(r[0])})
    return jsonify({"result": "na" + "#" + fn})
@app.route('/view_time_schedule',methods=['post'])
def view_time_schedule():
    lid=request.form['lid']
    q="SELECT `subject_table`.`subject`,`subject_table`.`semester`,`timetable`.* FROM `timetable` JOIN `subject_table` ON `subject_table`.`id`=`timetable`.`sid` JOIN student_table ON `student_table`.`course`=`subject_table`.`course_id` AND `subject_table`.`semester`=`student_table`.`semester` WHERE `student_table`.login_id=%s"
    res=androidselectall(q,lid)
    return jsonify(res)

@app.route('/view_video_classes',methods=['post'])
def view_video_classes():
    q="SELECT `subject_table`.`subject`,`video`.* FROM `video` JOIN `subject_table` ON `subject_table`.`id`=`video`.`sub_id`"
    res = androidselectallnew(q)
    return jsonify(res)

@app.route('/view_study_material',methods=['post'])
def view_study_material():
    q="SELECT `subject_table`.`subject`,`study_material`.*FROM `study_material` JOIN `subject_table` ON `subject_table`.`id`=`study_material`.`id`"
    res = androidselectallnew(q)
    return jsonify(res)

@app.route('/view_attendance',methods=['post'])
def view_attendance():
    return jsonify()

@app.route('/view_exam_notification',methods=['post'])
def view_exam_notification():
    q="SELECT `subject_table`.`subject`,`exam`.* FROM `exam` JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid`"
    res = androidselectallnew(q)
    print(res)
    return jsonify(res)


@app.route('/upload_answer_paper',methods=['post'])
def upload_answer_paper():
    print(request.form)
    studid=request.form['lid']
    exmid=request.form['eid']
    anspaper=request.files['file']
    answerpaper= secure_filename(anspaper.filename)
    print("artyujk========",answerpaper)
    anspaper.save("static/anspaper/"+answerpaper)
    qry="SELECT HOUR(TIMEDIFF(CURTIME(),`time`)),MINUTE(TIMEDIFF(CURTIME(),`time`) ),`duration` FROM `exam` WHERE `id`=%s"
    val=(exmid)
    res=selectone(qry,val)
    dur=float(res[2])*60
    print(dur)
    ttime=str(res[0])+"."+str(res[1])
    ttime=float(ttime)
    print(ttime)
    if ttime<=dur:
        q="INSERT INTO`answer` VALUES (NULL,%s,%s,%s,CURDATE(),curtime())"
        val=(studid,exmid,answerpaper)
        iud(q,val)
        return jsonify({'task': 'success'})
    else:
        return jsonify({'task': 'time out'})

@app.route('/view_staff')
def view_staff():
    q="SELECT*FROM `staff_table`"
    res = androidselectallnew(q)
    return jsonify(res)

@app.route('/view_sub',methods=['post'])
def view_sub():
    lid=request.form['lid']
    q="SELECT `subject_table`.* FROM `subject_table` JOIN `student_table` ON `subject_table`.`course_id`=`student_table`.`course` WHERE `student_table`.`login_id`=%s "
    res = androidselectall(q,lid)
    return jsonify(res)

@app.route('/viewstaff',methods=['post'])
def viewstaff():
    print(request.form)
    lid=request.form['lid']
    qry="SELECT * FROM `staff_table`"

    res = androidselectallnew(qry)
    res11=[]
    for i in res:
        print(i)
        sid=i['login_id']
        qry="SELECT SUM(`status`) FROM `chat` WHERE `from_id`=%s AND `to_id`=%s"
        val=(sid,lid)
        res1=selectone(qry,val)
        re=str(res1[0])
        print(str(res1[0]))
        if re=="None":
            re="0"
        i["list"]=re
        res11.append(i)
    print(res11)
    print(res,"===============================")
    return jsonify(res)

#############################################################


@app.route('/addblockchain',methods=['post','get'])
def addblockchain():
    eid="122"
    sid="33"
    score="a"
    with open(compiled_contract_path) as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
        date = datetime.now().strftime("%Y-%m-%d")
        contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.report_info(blocknumber + 1, int(eid), int(sid), score,date).transact()
        print(message2)

app.run(host='0.0.0.0',port=5000)




