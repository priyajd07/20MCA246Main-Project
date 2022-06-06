import os
from flask import *
from werkzeug.utils import secure_filename
from PIL import Image
from src.dbconnect import *
from src.emotion_find import emotioncheck


app=Flask(__name__)
path="static/emo/"
@app.route('/login',methods=['post'])
def login():
    uname=request.form['uname']
    pword=request.form['pass']
    q="select * from login where username=%s and password=%s"
    val=(uname,pword)
    s=selectonecond(q,val)
    if s  is None:
        return jsonify({"task":"invalid"})
    else:
        id=s[0]
        return jsonify({"task": "success","id":id})

@app.route('/register',methods=['post'])
def register():
    try:

        fname=request.form['fname']
        lname=request.form['lname']

        gender=request.form['gender']
        place = request.form['place']
        post = request.form['post']
        pin = request.form['pin']

        phone=request.form['phone']
        email = request.form['email']
        uname=request.form['uname']
        pswrd=request.form['psswd']
        qry="insert into login values(null,%s,%s,'user')"
        val=(uname,pswrd)
        id=iud(qry,val)
        qry2="insert into user_registration values(null,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val2=(str(id),fname,lname,gender,place,post,pin,phone,email)
        iud(qry2,val2)
        return jsonify({'task': 'success'})
    except Exception as e:
        return jsonify({'task': 'Duplicate Entry'})


@app.route('/viewbooks',methods=['post'])
def viewbooks():

    qry="SELECT * FROM books"
    res=androidselectallnew(qry)

    return jsonify(res)


@app.route('/reserve',methods=['post'])
def reserve():
    lid=request.form['lid']
    bookid=request.form['bookid']
    q="SELECT * FROM `reservebook` WHERE `userid`=%s AND `bookid`=%s AND `status`='reserved'"
    v=(str(lid),str(bookid))
    res=selectonecond(q,v)
    print(res)
    if res is None:

        qry="INSERT INTO `reservebook` VALUES(NULL,%s,%s,'reserved',CURDATE())"
        val=(lid,bookid)
        iud(qry,val)

        return jsonify({"task":"success"})
    else:
        return jsonify({"task": "Already reserved"})


@app.route('/booksreturn',methods=['post'])
def booksreturn():
    lid = request.form['lid']


    qry="SELECT `books`.`bookname`,`books`.`author`,`books`.`publis_date`,`books`.`price`,`reservebook`.`status`,`reservebook`.`date`,`reservebook`.`id` FROM `books` JOIN `reservebook` ON `books`.`id`=`reservebook`.`bookid` WHERE `reservebook`.`status`='reserved' AND `reservebook`.`userid`=%s"
    val=str(lid)
    res=androidselectall(qry,val)
    print (res)

    return jsonify(res)

@app.route('/returnbook',methods=['post'])
def returnbook():
    bookid=request.form['bookid']
    uid=request.form['lid']
    q="SELECT * FROM `reservebook` WHERE `userid`=%s AND `bookid`=%s AND `status`='returned'"
    v=str(uid),str(bookid)
    res=selectonecond(q,v)
    if res is None:

        qry="update reservebook set status='returned' where id=%s"
        val=(bookid)
        iud(qry,val)

        return jsonify({"task":"success"})
    else:
        return jsonify({"task": "Already reterned"})





@app.route('/emo',methods=['post'])
def emo():
    print(request.form)
    bid = request.form['bid']
    uid = request.form['id']
    filesnm = request.files['files']
    fname=secure_filename(filesnm.filename)
    print(fname)
    # print("------------------")
    # print(uid,fname)
    filesnm.save(os.path.join(path, fname))
    colorImage = Image.open(path+fname)

    # Rotate it by 45 degrees

    # rotated = colorImage.rotate(90)

    # Rotate it by 90 degrees

    transposed = colorImage.transpose(Image.ROTATE_90)

    # Display the Original Image

    # colorImage.show()

    # Display the Image rotated by 45 degrees

    # rotated.show()

    # Display the Image rotated by 90 degrees
    transposed.save(path+fname)
    fs= 'static/emo/'+fname
    res = emotioncheck(fs)
    print("res----",res)
    if res=="neutral":
        qry="INSERT INTO `rating` VALUES(NULL,%s,'4',CURDATE(),%s)"
        val=(str(bid),str(uid))
        iud(qry,val)

        return jsonify({"task":"success"})


    elif res == "happy":

        qry = "INSERT INTO `rating` VALUES(NULL,%s,'5',CURDATE(),%s)"
        val = (str(bid), str(uid))
        iud(qry, val)

        return jsonify({"task": "success"})
    elif res == "sad":

        qry = "INSERT INTO `rating` VALUES(NULL,%s,'1',CURDATE(),%s)"
        val = (str(bid), str(uid))
        iud(qry, val)

        return jsonify({"task": "success"})

    @app.route('/rating', methods=['post'])
    def rating():
        id=request.form["userid"]
        rating=request.form["rating"]
        bid=request.form['bid']
        qry="INSERT INTO `rating` VALUES(NULL,%s,%s,CURDATE(),%s)"
        val=(bid,rating,id)
        iud(qry,val)
        return jsonify({"task": "success"})



@app.route('/bookrecommendation',methods=['post'])
def bookrecommendation():
    print("-----------------------------------------")
    lid=request.form['lid']
    qry="SELECT `books`.* FROM `books` JOIN `rating` ON  rating.`book_id`=`books`.`id` WHERE `rating`.`rating`=5  AND `uid`=%s"
    val=(lid)
    res=selectcond(qry,val)
    ress=[]
    for i in res:


        qry = "SELECT `books`.* FROM `books`  WHERE `author`=%s AND id!=%s"
        val = (i[2],i[1])
        res1 = androidselectall(qry, val)
        print(res1)
        for i in res1:
            ress.append(i)

    return jsonify(ress)





app.run(host='0.0.0.0',port=5000)