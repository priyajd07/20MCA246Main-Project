from flask import *
from src.dbconnect import *
from src.chatbot import *
app=Flask(__name__)
@app.route('/login',methods=['post'])
def login():
    uname=request.form['uname']
    password=request.form['password']
    qry="select * from login where username=%s and password=%s and usertype='user'"
    val=(uname,password)
    res=selectonecond(qry,val)
    print(res)
    if res is None:
        return jsonify({'task':'invalid'})
    else:
        return jsonify({'task':'valid','id':res[0]})

@app.route('/reg',methods=['post'])
def reg():
    try:
        print(request.form)
        fname=request.form['fname']
        lname=request.form['lname']
        place=request.form['place']
        phone=request.form['phone']
        email = request.form['email']
        uname = request.form['uname']
        password = request.form['password']
        q="INSERT INTO `login` VALUES(NULL,%s,%s,'user')"
        v=(uname,password)
        lid=iud(q,v)
        q1="INSERT INTO `users` VALUES(NULL,%s,%s,%s,%s,%s,%s,'')"
        v1=(lid,fname,lname,place,phone,email)
        iud(q1,v1)
        return jsonify({'task': 'success'})
    except Exception as e:
        print(e)
        return jsonify({'task': 'already exist'})
@app.route('/sendfeedbacks',methods=['post'])
def sendfeedbacks():
    uid=request.form['lid']
    feedback=request.form['fbk']
    q="INSERT INTO `feedback` VALUES(NULL,%s,CURDATE(),%s)"
    v=(uid,feedback)
    iud(q,v)
    return jsonify({'task': 'success'})
@app.route('/complaints',methods=['post'])
def complaints():
    uid=request.form['lid']
    comp=request.form['complaint']
    q="INSERT INTO `complaint` VALUES(NULL,%s,CURDATE(),%s,'pending')"
    v=(uid,comp)
    iud(q,v)
    return jsonify({'task': 'success'})
@app.route('/complaintsreply',methods=['post'])
def complaintsreply():
    uid = request.form['lid']
    qry="select * from complaint where user_lid=%s"
    res=androidselectall(qry,uid)
    return jsonify(res)

@app.route('/insertchatbot',methods=['GET','POST'])
def insertchatbot():
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="intelligent chatbot")
    cmd = con.cursor()

    qus=request.form['msg']
    lid=request.form['lid']
    print(lid)
    res=cb(qus)
    print(res)
    cmd.execute( "INSERT INTO `chatbot_chat` VALUES(NULL,'"+str(lid)+"','"+qus+"','"+res+"',curdate())")
    con.commit()

    return jsonify({'task': "ok"})


@app.route("/response",methods=['post'])
def response() :
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="intelligent chatbot")
    cmd = con.cursor()
    st_id=request.form['lid']
    # qry="SELECT doubt,st_id,reply,date  FROM doubt where st_id=%s "

    cmd.execute("SELECT questions,user_id,answers FROM `chatbot_chat` WHERE `user_id`="+str(st_id))
    s=cmd.fetchall()

    # val=(st_id)
    # s=select1(qry,val)
    row_headers = ['frmid','toid','msg']
    json_data = []
    row = []
    row.append(1)
    row.append(0)
    row.append("Hi How can i help you...")
    json_data.append(dict(zip(row_headers, row)))
    for result in s:
        row=[]
        row.append(st_id)
        row.append(0)
        row.append(result[0])
        # row.append(result[3])
        json_data.append(dict(zip(row_headers, row)))
        row = []
        row.append(0)
        row.append(st_id)
        row.append(result[2])
        # row.append(result[3])
        json_data.append(dict(zip(row_headers, row)))
    print(json_data)
    return jsonify(json_data)


@app.route('/send_friend_request',methods=['post'])
def send_friend_request():
    fromid=request.form['fromid']
    toid=request.form['toid']
    qry="INSERT INTO `friendrequest` VALUES(NULL,%s,%s,CURDATE(),'pending')"
    val=(fromid,toid)
    iud(qry,val)
    return jsonify({'task': "ok"})
@app.route('/send_friendrequest',methods=['post'])
def send_friendrequest():
    uid=request.form['uid']
    print(uid,"=====")
    qry="SELECT * FROM `users` WHERE `lid`!=%s AND `lid` NOT IN (SELECT `Fromid` FROM `friendrequest` WHERE `Toid`=%s) AND `lid` NOT IN(SELECT `Toid` FROM `friendrequest` WHERE `Fromid`=%s)"
    val=uid,uid,uid
    res=androidselectall(qry,val)
    print(res,"==================")
    return jsonify(res)

@app.route('/view_friend_request',methods=['post'])
def view_friend_request():
    uid=request.form['uid']
    print(uid,"=====")
    qry="SELECT `users`.`fname`,`users`.`lname`,`users`.`image`,`users`.lid,`friendrequest`.`Fid` FROM  users JOIN `friendrequest` ON `friendrequest`.`Fromid`=`users`.`lid` WHERE `friendrequest`.`Status`='pending' AND `friendrequest`.`Toid`=%s"
    val=uid
    print(qry)
    res=androidselectall(qry,val)
    print(res,"==================")
    return jsonify(res)
@app.route('/accept_friend_request',methods=['post'])
def accept_friend_request():
    print(request.form)
    requestid=request.form['rid']
    qry="UPDATE `friendrequest` SET `Status`='accepted' WHERE `Fid`=%s"
    iud(qry,requestid)
    return jsonify({'task': "ok"})


@app.route('/reject_friend_request',methods=['post'])
def reject_friend_request():
    requestid=request.form['requestid']
    qry = "UPDATE `friendrequest` SET `Status`='rejected' WHERE `Fid`=%s"
    iud(qry,requestid)
    return jsonify({'task': "ok"})


@app.route('/view_friends',methods=['post'])
def view_friend():
    uid = request.form['uid']
    print(uid)
    qry="SELECT `users`.* FROM `users` JOIN `friendrequest` ON `friendrequest`.`Fromid`=`users`.`lid` WHERE `friendrequest`.`Toid`=%s AND `friendrequest`.`Status`='accepted' UNION SELECT `users`.* FROM `users` JOIN `friendrequest` ON `friendrequest`.`Toid`=`users`.`lid` WHERE `friendrequest`.`Fromid`=%s AND `friendrequest`.`Status`='accepted' "
    lid = request.form['uid']
    value = (lid, lid)
    print(qry,value)
    res = androidselectall(qry, value)
    print(res)
    return jsonify(res)
@app.route('/send_post',methods=['post'])
def send_post():
    userid=request.form['userid']
    post=request.form['post']
    qry="INSERT INTO `post` VALUES(NULL,%s,%s,CURDATE(),'pending')"
    val=(userid,post)
    iud(qry,val)
    return jsonify({'task': "valid"})
@app.route('/view_others_post',methods=['post'])
def view_others_post():
    userid = request.form['userid']
    qry="SELECT * FROM `post` WHERE  `Userid`!=%s"
    res = androidselectall(qry, userid)
    return jsonify(res)
@app.route('/view_my_post',methods=['post'])
def view_my_post():
    print(request.form)
    userid=request.form['uid']
    qry="SELECT * FROM `post` WHERE  `Userid`=%s"
    res=androidselectall(qry,userid)
    return jsonify(res)

@app.route('/delete_my_post',methods=['post'])
def delete_my_post():
    postid=request.form['uid']
    qry="DELETE FROM `post` WHERE `Pid`=%s"
    val=(postid)
    iud(qry,val)
    return jsonify({'task': "ök"})



@app.route('/send_comments_to_others',methods=['post'])
def send_comments_to_others():
    pid=request.form['pid']
    userid=request.form['userid']
    comment=request.form['comment']
    qry="INSERT INTO `comment` VALUES(NULL,%s,%s,%s)"
    val=(pid,userid,comment)
    iud(qry,val)

    return jsonify({'task': "ok"})

@app.route('/view_our_comments',methods=['post'])
def view_our_comments():
    userid = request.form['userid']
    qry="SELECT `comment`.* FROM `comment` JOIN `post` ON `post`.`Pid`=`comment`.`Pid` WHERE `post`.`Userid`=%s"
    res = androidselectall(qry, userid)
    return jsonify(res)



@app.route('/chat',methods=['post'])
def chat():
    fromid=request.form['fromid']
    toid=request.form['toid']
    message=request.form['message']
    qry="INSERT INTO `chat` VALUES(NULL,%s,%s,%s,CURDATE())"
    val=(fromid,toid,message)
    iud(qry,val)

    return jsonify({'task': "ok"})









app.run(host='0.0.0.0',port=5000)