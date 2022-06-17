import os
from flask import *
from werkzeug.utils import secure_filename

from src.dbconnect import *
from src.roadcrack.fcm import test_input
from src.rf import predictfn
app=Flask(__name__)

@app.route("/accident",methods=['post'])
def accident():
    userid=request.form['user_id']
    lattitude=request.form['lattitude']
    longitude = request.form['longitude']
    speed=request.form['speed']
    q="insert into accident values(null,%s,%s,%s,curdate(),%s)"
    val=(userid,lattitude,longitude,speed)
    iud(q,val)
    return jsonify({'task': 'success'})


@app.route("/login",methods=['post'])
def login():
    print(request.form)
    username=request.form['uname']
    password=request.form['pass']
    q="SELECT * FROM `login`WHERE `username`=%s AND`password`=%s"
    val=username,password
    res=selectonecond(q,val)
    print(res)
    if res is None:
        return jsonify({'task': 'unsuccessfull'})
    else:
        return jsonify({'task': 'valid','lid':res[0],'type':res[3]})

@app.route("/profile",methods=['post'])
def profile():
    id=request.form['uid']
    qry="SELECT * from `user`  where user_lid=%s"
    val=id
    res = androidselectall(qry,val)
    print(res)
    return jsonify(res)


@app.route("/userreg",methods=['post'])
def userreg():
    print(request.form)
    fname = request.form['fname']
    lname = request.form['lname']
    place = request.form['place']
    phone = request.form['phone']
    email = request.form['email']
    uname=request.form['uname']
    passd=request.form['password']
    qry="insert into login values(null,%s,%s,'user')"
    val=(uname,passd)
    id=iud(qry,val)
    qry="INSERT INTO `user` VALUE(null,%s,%s,%s,%s,%s,%s)"
    val=(id,fname,lname,place,phone,email)
    id=iud(qry,val)
    return jsonify({'task': 'success'})

@app.route("/editprofile",methods=['post'])
def editprofile():
    print(request.form)
    fname = request.form['fname']
    lname = request.form['lname']
    place = request.form['place']
    phone = request.form['phone']
    email = request.form['email']
    lid=request.form['uid']
    qry="update `user` set fname=%s,lname=%s,place=%s,phone=%s,email=%s where user_lid=%s"
    val=(fname,lname,place,phone,email,lid)
    id=iud(qry,val)
    return jsonify({'task': 'success','id':id})

@app.route("/viewroute",methods=['post'])
def viewroute():

    qry="SELECT * from route"

    res = androidselectallnew(qry)
    print(res)
    return jsonify(res)

@app.route("/feedback",methods=['post'])
def feedback():
    uid = request.form['lid']
    fd = request.form['feedback']
    qry="INSERT INTO `feedback` VALUE(null,%s,curdate(),%s)"
    val=(uid,fd)
    iud(qry,val)
    return jsonify({'task': 'success'})


@app.route("/capture",methods=['POST','GET'])
def capture():
    print(request.files)
    print(request.form)
    imei = request.form['imei']
    print(imei)
    lattitude = request.form['lattitude']
    longitude = request.form['longitude']
    print(lattitude,longitude)
    if longitude=='':
        longitude='10.8299'
        lattitude='76.0228'
    print(lattitude)
    path = 'static/photo'

    files = request.files['files']
    fname = secure_filename(files.filename)
    files.save(os.path.join(path, fname))

    try:
        res=test_input(path+"/"+fname)
        print("result",res)
        res="cracks"



        if res=="cracks":



            qry1=("insert into alert values(null,%s,%s,%s,%s,%s,now())")
            val=(imei,lattitude,longitude,fname,res,)
            iud(qry1,val)
            return jsonify({'result': res})
        else:
            return jsonify({'result':res})
    except Exception as e:
        return jsonify({'result': "error"})


@app.route('/loc',methods=['get','post'])
def loc():
    print(request.form)

    latitude = request.form['lati']
    longitude = request.form['longi']


    qry="SELECT `alert`.* ,(3959 * ACOS ( COS ( RADIANS(%s) * COS( RADIANS( lattitude) ) * COS( RADIANS( longitude ) - RADIANS(%s) + SIN ( RADIANS(%s) * SIN( RADIANS( lattitude ) )))))) AS user_distance FROM `alert` WHERE `alert`.`result`='cracks' HAVING user_distance  > 3.1068"

    val=(latitude,longitude,latitude)
    print(val)
    print(qry,val)
    s = selectonecond(qry,val)
    print(s)
    if len(s)==0:
        print("rrrr")
        return jsonify({'task': 'error'})

    else:
        print("ok")
        return jsonify({'task': 'some distrution are there please go slowly'})

@app.route("/viewnotification",methods=['post'])
def viewnotification():
    qry="select * from notification"
    res=androidselectallnew(qry)
    print(res,"=====================")
    return jsonify(res)

@app.route("/acccidentalert",methods=['post'])
def accidentalert():
    qry="select user.fname,user.lname,accident.date from user join accident on user.user_lid=accident.user_id"
    res=androidselectallnew(qry)
    print(res,"=======")
    return jsonify(res)
@app.route("/maxalert",methods=['post'])
def maxalert():
    qry="select max(id) from accident"
    res=selectone(qry)
    if res is not None:
        print(res[0])
        return jsonify({'task': res[0]})
    else:
        return jsonify({'task': "1"})


@app.route("/prediction",methods=['post'])
def prediction():
    print(request.form)


    ax_z=request.form['ax_z']
    ax_y=request.form['speed']
    res=predictfn([float(ax_z),float(ax_y)])
    print(res,"==================================================")
    if str(res)=="1.0":
        return jsonify({'task': 'ok'})
    return jsonify({'task': 'normal'})





@app.route('/predictblock',methods=['POST'])
def predictblock():

    # userid=request.form['uid']
    # lati=request.form['lati']
    # longi=request.form['longi']
    fuserlist=[]
    suserids=[]
    snearnos=[]
    tnearnos = []
    latis=[]
    longis=[]
    userid=10
    lati="11.348661"
    longi="75.7388215"
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="road damage")
    cmd = con.cursor()
    cmd.execute("SELECT `location`.`latitude` ,`longitude`,`user`.*, (3959 * ACOS ( COS ( RADIANS('" + str(lati) + "') ) * COS( RADIANS(location.latitude) ) * COS( RADIANS(location.longitude ) - RADIANS('" + str(longi) + "') ) + SIN ( RADIANS('" + str(lati) + "') ) * SIN( RADIANS( location.latitude ) ))) AS user_distance FROM `user`  JOIN `location` ON `location`.`uid`=`user`.`uid`  AND `location`.`uid`!='"+str(userid)+"' HAVING user_distance  < 0.5")
    s=cmd.fetchall()
    if len(s)>0:
        fnearnos=len(s)
        print(s)
    for i in s:
        fuserlist.append(i[3])
        latis.append(i[0])
        longis.append(i[1])
    for ii in range(len(fuserlist)):
        cmd.execute("SELECT `location`.`latitude` ,`longitude`,`user`.*, (3959 * ACOS ( COS ( RADIANS('" + str(latis[ii]) + "') ) * COS( RADIANS(location.latitude) ) * COS( RADIANS(location.longitude ) - RADIANS('" + str(longis[ii]) + "') ) + SIN ( RADIANS('" + str(latis[ii]) + "') ) * SIN( RADIANS( location.latitude ) ))) AS user_distance FROM `user`  JOIN `location` ON `location`.`uid`=`user`.`uid`  AND `location`.`uid`!='"+str(fuserlist[ii])+"' HAVING user_distance  < 0.5")
        s11 = cmd.fetchall()
        print(s11)
        if len(s11)>0:
            snearnos.append(len(s11))
            print(snearnos)
        for iii in range(len(s11)):
            # print(s11[0][0])
            if(s11[iii][3] not  in fuserlist and s11[iii][3] !=userid):
                print("out",s11[iii][3])

                cmd.execute("SELECT `location`.`latitude` ,`longitude`,`user`.*, (3959 * ACOS ( COS ( RADIANS('" + str(s11[iii][0]) + "') ) * COS( RADIANS(location.latitude) ) * COS( RADIANS(location.longitude ) - RADIANS('" + str(
                    s11[iii][1]) + "') ) + SIN ( RADIANS('" + str(s11[iii][0]) + "') ) * SIN( RADIANS( location.latitude ) ))) AS user_distance FROM `user`  JOIN `location` ON `location`.`uid`=`user`.`uid`  AND `location`.`uid`!='" + str(
                    s11[iii][3]) + "' HAVING user_distance  < 0.5")
                s112 = cmd.fetchall()
                # print(s112)
                if len(s112)>0:
                    tnearnos.append(len(s112))
    print(tnearnos)
    maxsecond=0
    if len(snearnos) > 0:
        maxsecond=max(snearnos)
    thrdno=0
    if len(tnearnos)>0:
        thrdno=max(tnearnos)
    print("first"+str(fnearnos))
    print("sec"+str(maxsecond))
    print("third"+str(thrdno))
    if maxsecond > fnearnos and thrdno >=maxsecond:
        # return "cong"
        return jsonify({"task": "traffic congestion ahead  take another route"})
    else:
        # return "not"
        return jsonify({"task": "no issues"})







if __name__=='__main__':
    app.run(host='0.0.0.0',port=5000)
