import pymysql
from flask import *
from src.newcnn import predictcnn
from src.sample import sent
from werkzeug.utils import secure_filename

app = Flask(__name__)
con=pymysql.connect(host='localhost',port=3306,user='root',password='',db='public complaint')
cmd=con.cursor()
app.secret_key="qwer"
@app.route('/login',methods=['post'])
def login():
    username=request.form['uname']
    password=request.form['psd']
    cmd.execute("select * from login where username='" + username + "' and password='" + password + "' AND `type`='user'")
    S = cmd.fetchone()
    print(S)
    if S is None:
        return jsonify({'task':"invalid"})
    else:
        return jsonify({'task':str(S[0])})
@app.route('/register',methods=['post'])
def register():
    try:
        con = pymysql.connect(host='localhost', port=3306, user='root', password='', db='public complaint')
        cmd = con.cursor()
        print(request.form)
        fname=request.form['fname']
        lname=request.form['lname']
        dob=request.form['dob']
        gender=request.form['gender']
        place=request.form['place']
        post=request.form['post']
        pin=request.form['pin']
        phone=request.form['phone']
        email=request.form['email']
        aadharno=request.form['aadharno']
        username=request.form['username']
        password=request.form['password']
        cmd.execute("insert into login values(null, '" + username + "','" + password + "','user')")
        id = con.insert_id()
        cmd.execute("insert into user values(null,'" + str(
            id) + "','" + fname + "','" + lname + "','" + dob + "','" + gender + "','" + place + "','" + post + "','" + pin + "','" + phone + "','" + email + "','" + aadharno + "')")
        con.commit()
        return jsonify({'task': "success"})
    except Exception as e:
        return jsonify({'task': "already exist"})
@app.route('/complaint',methods=['post'])
def complaint():
    lid=request.form['lid']
    print(lid)
    lid=request.form['lid']
    lati=request.form['lattitude']
    longi=request.form['longitude']
    complaint=request.files['files']
    fname=secure_filename(complaint.filename)
    print(fname)
    # fname=complaint.secure_filename(complaint.filename)

    complaint.save(r'D:\PCS\public complaint\public complaint\src\static\complaints\\'+fname)
    # res=predict('D:\\public_complaint\\public complaint\\public complaint\\src\\static\\complaints\\'+fname)
    # res=detect_dept('D:\\public_complaint\\public complaint\\public complaint\\src\\static\\complaints\\'+fname)
    res = predictcnn(r'D:\PCS\public complaint\public complaint\src\static\complaints\\' + fname)
    print("res",res)
    dept="0"
    if res==0:
        dept="1"
    elif res==1:
        dept="3"
    elif res==2:
        dept="5"
    elif res==3:
        dept="0"
    elif res==4:
        dept="4"
    elif res==5:
        dept="2"

    if dept!="0":
        print("ok")


        cmd.execute("insert into complaint values(null,'"+lid+"','"+dept+"',curdate(),'"+fname+"','pending','"+lati+"','"+longi+"')")
        con.commit()
        return jsonify({'task': "success"})
    else:
        print("not")
        return jsonify({'task': "not"})


@app.route('/feedback',methods=['post'])
def feedback():
    lid=request.form['lid']
    feedback=request.form['feedback']
    cmd.execute("insert into feedback values(null,'" + lid + "',curdate(),'" + feedback + "')")
    con.commit()
    return jsonify({'task': "success"})

@app.route('/stafffeedback',methods=['post'])
def stafffeedback():
    lid=request.form['lid']
    sid=request.form['sid']
    stafffeedback=request.form['feedback']
    res=sent(stafffeedback)
    cmd.execute("insert into staff_feedback values(null,'" + lid + "','"+sid + " ','"+stafffeedback+"',curdate(),'"+str(res)+"')")
    con.commit()
    return jsonify({'task': "success"})


@app.route ('/viewreply',methods=['post'])
def viewreply():
    login_id = request.form['lid']
    print(login_id)
    cmd.execute("SELECT `complaint`.*,`department`.* FROM `complaint` JOIN `department` ON `department`.`dpid`=`complaint`.`dp id` WHERE `complaint`.`lid`='"+str(login_id)+"' ")
    row_headers = [x[0] for x in cmd.description]
    results = cmd.fetchall()
    print(login_id)
    json_data = []
    for result in results:
        json_data.append(dict(zip(row_headers, result)))
    con.commit()
    print(json_data)
    return jsonify(json_data)



app.run(host="0.0.0.0",port=5000)