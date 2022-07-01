from datetime import datetime

from flask import *
from werkzeug.utils import secure_filename

from src.dbconnection import *
from datetime import datetime

from flask import *
from werkzeug.utils import secure_filename
from scipy.ndimage import rotate

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
@app.route('/addimg',methods=['post'])
def addimg():
    print(request.form)
    print(request.files)
    img=request.files['files']
    lid=request.form['lid']
    import time
    fn=time.strftime("%Y%m%d_%H%M%S")+".jpg"
    img.save("static/pic/"+fn)
    img=cv2.imread("static/pic/"+fn)
    try:
        img=rotate(img,90)
        cv2.imwrite("static/pic/n"+fn,img)
    except Exception as e:
        print("=====",e)

    print("fname",fn)
    q="SELECT `student_table`.`login_id`,`student_table`.`first_name`,`pics`.`pic` FROM `student_table` JOIN `pics` ON `student_table`.`login_id`=`pics`.`stud_id` WHERE pics.stud_id=%s"
    s=selectall2(q,lid)
    enf("static/pic/n"+fn)
    for r in s:
        res,s=rec_face_image("static/pic/"+r[2])
        if len(res)>0:
            print("out",res)
            return jsonify({"result":r[1]+"#"+str(r[0])})
        else:
            print("hghg")
            if s==0:
                print("++++++++++++++++++++++")
                return jsonify({"result": "na" + "#" + fn})
            else:
                print ("******************************")
                return jsonify({"result": "out" + "#" + fn})

    return jsonify({"result": "na"})


@app.route('/addimg1',methods=['post'])
def addimg1():
    print(request.form)
    print(request.files)
    img=request.files['files']
    lid=request.form['lid']
    import time
    fn=time.strftime("%Y%m%d_%H%M%S")+".jpg"
    img.save("static/pic/"+fn)
    # img=cv2.imread("static/pic/"+fn)
    # try:
    #     img=rotate(img,90)
    #     cv2.imwrite("static/pic/n"+fn,img)
    # except Exception as e:
    #     print("=====",e)

    print("fname",fn)
    q="SELECT `student_table`.`login_id`,`student_table`.`first_name`,`pics`.`pic` FROM `student_table` JOIN `pics` ON `student_table`.`login_id`=`pics`.`stud_id` WHERE pics.stud_id=%s"
    s=selectall2(q,lid)
    enf("static/pic/"+fn)
    for r in s:
        res,_=rec_face_image("static/pic/"+r[2])
        if len(res)>0:
            print("out",res)
            return jsonify({"result":r[1]+"#"+str(r[0])})
        else:
            print("hghg")
            return jsonify({"result": "na" + "#" + fn})

    return jsonify({"result": "na"})





@app.route('/view_study_material',methods=['post'])
def view_study_material():
    q="SELECT `subject_table`.`subject`,`study_material`.*FROM `study_material` JOIN `subject_table` ON `subject_table`.`id`=`study_material`.`id`"
    res = androidselectallnew(q)
    return jsonify(res)


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
    print (res,"==========")
    return jsonify(res)

@app.route('/view_exam',methods=['post'])
def view_exam():
    lid=request.form['lid']
    print(lid)
    q="SELECT `exam`.*,`subject_table`.`subject` FROM `subject_table` JOIN `exam` ON `exam`.`sid`=`subject_table`.`id` WHERE `subject_table`.`course_id` IN(SELECT `course` FROM `student_table` WHERE `login_id`=%s) AND `subject_table`.`semester` IN(SELECT `semester` FROM `student_table` WHERE `login_id`=%s) AND exam.date=CURDATE() and (TIME_TO_SEC(TIMEDIFF(`time`,CURTIME())) BETWEEN -10000 AND 10000)"
    # q="SELECT `exam`.*,`subject_table`.`subject` FROM `subject_table` JOIN `exam` ON `exam`.`sid`=`subject_table`.`id` WHERE `subject_table`.`course_id` IN(SELECT `course` FROM `student_table` WHERE `login_id`=%s) AND `subject_table`.`semester` IN(SELECT `semester` FROM `student_table` WHERE `login_id`=%s) AND exam.date=CURDATE()"
    val=(lid,lid)
    res = androidselectall(q,val)
    print(res)
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





@app.route('/viewQuestions',methods=['post'])
def viewQuestions():
    print(request.form)
    eid=request.form['eid']
    q="SELECT * FROM questions WHERE exam_id=%s ORDER BY RAND() LIMIT 5"
    val = (eid)
    res = androidselectall(q, val)
    print(res)
    return jsonify(res)

# @app.route('/markup',methods=['post'])
# def markup():
#     eid=request.form['eid']
#     lid=request.form['lid']
#     print(lid)
#     mark=request.form['mark']
#     q="INSERT INTO marks VALUES(NULL,%s,%s,%s)"
#     val=(lid,eid,mark)
#     iud(q,val)
#     with open(compiled_contract_path) as file:
#         contract_json = json.load(file)  # load contract info as JSON
#         contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
#         date = datetime.now().strftime("%Y-%m-%d")
#         contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
#         blocknumber = web3.eth.get_block_number()
#         message2 = contract.functions.report_info(blocknumber + 1, int(eid), int(lid), mark, date).transact()
#         print(message2)
#
#     return jsonify({'task': 'success'})


@app.route('/viewresult',methods=['post'])
def viewresult():
    lid = request.form['lid']
    qry="SELECT `subject_table`.`subject`,`exam`.`exam_name`,`marks`.`marks` FROM `marks` JOIN `exam` ON `exam`.`id`=`marks`.`eid` JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid` WHERE `marks`.`lid`=%s"
    res=androidselectall(qry,lid)

    return jsonify(res)







@app.route('/viewsubforvideo', methods=['post'])
def viewsubforvideo():
    lid=request.form['lid']
    qry="SELECT `course` FROM `student_table` WHERE `login_id`=%s"
    res=selectone(qry,lid)
    cid=res[0]
    q="SELECT * FROM `subject_table` WHERE `course_id`=%s"
    re=androidselectall(q,cid)
    return jsonify(re)





@app.route('/view_video_classes',methods=['post'])
def view_video_classes():
    sub = request.form['sid']
    print (sub,"============")
    q="SELECT `subject_table`.`subject`,`video`.* FROM `video` JOIN `subject_table` ON `subject_table`.`id`=`video`.`subid`WHERE `subid`=%s"
    # q="SELECT `subject_table`.`subject`,`video`.* FROM `video` JOIN `subject_table` ON `subject_table`.`id`=`video`.subid"
    res = androidselectall(q,sub)
    print (res)
    return jsonify(res)



@app.route('/view_attendance',methods=['post'])
def view_attendance():
    lid = request.form['lid']
    print(lid)
    res = androidselectall("select * from attendance where sid = %s", lid)
    print (res)


    return jsonify(res)





# @app.route('/view_time_',methods=['post'])
# def view_time_schedule():
#     lid=request.form['lid']
#     q="SELECT `subject_table`.`subject`,`subject_table`.`semester`,`timetable`.* FROM `timetable` JOIN `subject_table` ON `subject_table`.`id`=`timetable`.`sid` JOIN student_table ON `student_table`.`course`=`subject_table`.`course_id` AND `subject_table`.`semester`=`student_table`.`semester` WHERE `student_table`.login_id=%s"
#     res=androidselectall(q,lid)
#     return jsonify(res)


@app.route('/chatviewstaff',methods=['post'])
def chatviewstaff():
    q = "SELECT * FROM staff"
    res = androidselectallnew(q)
    print(res)
    return jsonify(res)



@app.route('/view_message2',methods=['post'])
def view_message2():
    print("wwwwwwwwwwwwwwww")
    print(request.form)
    fromid=request.form['fid']
    print(fromid)
    toid=request.form['toid']
    print(toid)
    lmid = request.form['lastmsgid']
    print("msgggggggggggggggggggggg"+lmid)
    qry="SELECT `fromid`,`msg`,`date`,`toid`,id FROM `chat` WHERE `id`>%s AND ((`toid`=%s AND  `fromid`=%s) OR (`toid`=%s AND `fromid`=%s)  )  ORDER BY `id` ASC"
    val=(str(lmid),str(toid),str(fromid),str(fromid),str(toid))
    print("fffffffffffff",val)
    res = androidselectall(qry,val)
    print("resullllllllllll")
    print(res)
    if res is not None:
        return jsonify(status='ok', res1=res)
    else:
        return jsonify(status='not found')



@app.route('/in_message2',methods=['post'])
def in_message():
    print(request.form)
    fromid = request.form['fid']
    print("fromid",fromid)
    toid = request.form['toid']
    print("toid",toid)

    message=request.form['msg']
    print("msg",message)
    qry = "INSERT INTO `chat` VALUES(NULL,%s,%s,%s,CURDATE())"
    value = (fromid, toid, message)
    print("pppppppppppppppppp")
    print(value)
    iud(qry, value)
    return jsonify(status='send')





@app.route('/view_scorecard',methods=['post','get'])
def view_scorecard():
    lid = request.args.get('lid')
    q="SELECT `subject_table`.`subject`,`exam`.`exam_name`,`marks`.`marks` FROM `marks` JOIN `exam` ON `exam`.`id`=`marks`.`eid` JOIN `subject_table` ON `subject_table`.`id`=`exam`.`sid` WHERE `marks`.`lid`=%s"
    res = selectall2(q,lid)
    print(res)
    return render_template("staff/Scorecard.html", val=res)


app.run(host='0.0.0.0',port=5000)




