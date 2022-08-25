import os
from random import random

from flask import *
from werkzeug.utils import secure_filename
from src.dbconnector import *
import pymysql
import Crypto
import Crypto.Random
import binascii
from Crypto.Hash import SHA
from Crypto.PublicKey import RSA
from collections import OrderedDict
from Crypto.Signature import PKCS1_v1_5

class Transaction:
    def __init__(self, sender_address, sender_private_key, recipient_address, value):
        self.sender_address = sender_address
        self.sender_private_key = sender_private_key
        self.recipient_address = recipient_address
        self.value = value
    def __getattr__(self, attr):
        return self.data[attr]
    def to_dict(self):
        return OrderedDict({'sender_address': self.sender_address,
                            'recipient_address': self.recipient_address,
                            'value': self.value
                            })
    def sign_transaction(self):
        """
        Sign transaction with private key
        """
        private_key = RSA.importKey(binascii.unhexlify(self.sender_private_key))
        signer = PKCS1_v1_5.new(private_key)
        h = SHA.new(str(self.to_dict()).encode('utf8'))
        return binascii.hexlify(signer.sign(h)).decode('ascii')
app=Flask(__name__)
@app.route('/login',methods=['post'])
def login():
    uname=request.form['uname']
    pword=request.form['pwd']
    qry="SELECT * FROM `login` WHERE `username`=%s AND `password`=%s AND type='stakeholder'"
    val=(uname,pword)
    res=selectone(qry,val)
    if res is None:
        return jsonify({'task':'invalid'})
    else:
        return jsonify({'task':str(res[0])})
@app.route('/viewprojects',methods=['post'])
def viewprojects():

    q="SELECT `pro_id` FROM `project` WHERE  `status`='requested' and `pro_id` IN (SELECT `pid` FROM `lastdate` WHERE `lastdate`<CURDATE())"
    res=select(q)
    print(res)
    for r in res:
        qry="UPDATE `project` SET `status`='rejected' WHERE `pro_id`=%s"
        val=(str(r[0]))
        print(val)
        iud(qry,val)
        qry="DELETE FROM `pvalet` WHERE `id`=%s"
        iud(qry, val)
        qry="SELECT * FROM `project_allocation` WHERE `pid`=%s"
        ress=selectall(qry,val)
        print(ress, "==================")
        for rr in ress:

            qry="UPDATE `valet` SET `balance`=`balance`+%s WHERE `uid`=%s"
            val=(str(rr[3]),str(rr[2]))
            iud(qry,val)

    q="SELECT `project`.*,`manager`.* FROM `project` JOIN `manager` ON `project`.`mid`=`manager`.`loginid` WHERE `project`.`status`='requested'"
    # q="SELECT `project`.*,`manager`.* FROM `project` JOIN `manager` ON `project`.`mid`=`manager`.`loginid` WHERE `project`.`status`='accept'"
    res=androidselectallnew(q)
    return jsonify(res)
@app.route('/sndrqst',methods=['post'])
def sndrqst():
    pid=request.form['pid']
    sid=request.form['lid']
    amt=request.form['amt']
    q1="SELECT `amount` FROM `project` WHERE `pro_id`=%s"
    v1=(str(pid))
    pamt=selectone(q1,v1)
    print(pamt)
    q2="SELECT `amount` FROM `project_allocation` WHERE `pid`=%s"
    samt=selectall(q2,v1)
    tot=0
    for i in samt:
        tot=tot+i[0]
    print(tot,"tot=============")
    qqqq="SELECT `balance` FROM `valet` WHERE `uid`=%s"
    valbal=(sid)
    resbal=selectone(qqqq,valbal)
    if resbal is None:
        resbal=[0]
    print(resbal,"balllllllllllllllll")
    print(int(pamt[0]),int(tot))
    balamtproject=int(pamt[0])-int(tot)
    if (int(pamt[0])!=int(tot)):
        q="SELECT `id` FROM `project_allocation` WHERE `shid`=%s and pid=%s"
        v = (str(sid),pid)
        s = selectone(q, v)
        print(s,"sssssssssssssssssssssssssssssss")
        if s is None:
            if float(amt)<=float(resbal[0]):
                if int(amt)>=balamtproject:
                    amt=balamtproject
                    qry="UPDATE `project` SET `status`='accept' WHERE  `pro_id`=%s"
                    val = (str(pid))
                    iud(qry,val)

                print("okkkkkkkkkkkkkkkkkkkkkkkk")
                qry="insert into `project_allocation` values(null,%s,%s,%s,curdate())"
                val = (str(pid),str(sid), amt)
                iud(qry,val)
                qq="UPDATE valet SET `balance`=balance-%s WHERE uid=%s"
                vv=(int(amt),str(sid))
                iud(qq,vv)
                print(vv,"=000000000000000")
                qry=" SELECT * FROM `pvalet` WHERE `id`=%s"
                val = (str(pid))
                r=selectone(qry,val)
                if r is None:
                    qry="insert into pvalet values(%s,%s)"
                    val=(pid,amt)
                    iud(qry,val)
                else:
                    qry=" UPDATE `pvalet` SET `balance`=balance+"+str(amt)+" WHERE `id`=%s"
                    val=(str(pid))
                    iud(qry,val)
                return jsonify({'task':'Requested...'})
            else:
                print("mmmmmmmmmmmmmmmmmmmmmmmmmmmm")
                return jsonify({'task': 'No balance'})
        else:
            return jsonify({'task': 'Already requested!!!'})
    else:
        return jsonify({'task': 'Got the required amount...'})
@app.route('/reqstatus',methods=['post'])
def reqstatus():
    print(request.form)
    sid = request.form['lid']
    q = "SELECT `project`.*,`request`.* FROM `project` JOIN `request` ON `project`.`pro_id`=`request`.`pid` JOIN `project_allocation` ON `project_allocation`.`pid`=`request`.`pid` WHERE `project`.`status`='accept' AND `project_allocation`.`shid`= '" + str(
        sid) + "'"
    res = androidselectallnew(q)
    return jsonify(res)
@app.route('/viewreq',methods=['post'])
def viewreq():
    print(request.form)
    sid=request.form['lid']
    q="SELECT `project`.*,`request`.* FROM `project` JOIN `request` ON `project`.`pro_id`=`request`.`pid` JOIN `project_allocation` ON `project_allocation`.`pid`=`request`.`pid` WHERE `project`.`status`='accept' AND `project_allocation`.`shid`= '"+str(sid)+"'"
    res = androidselectallnew(q)
    print(res)
    return jsonify(res)

@app.route('/viewreq1',methods=['post'])
def viewreq1():
    print(request.form)
    rid=request.form['rid']
    q="SELECT `request`.`reason`,`request`.`date`,`request`.`amount`,`project`.`project`,`project`.`amount` AS pamount FROM `request` JOIN `project` ON `request`.`pid`=`project`.`pro_id` WHERE `request`.`id`='"+str(rid)+"'"
    print(q)
    res = androidselectallnew(q)
    print(res)
    return jsonify(res)


@app.route('/voteaccept',methods=['post'])
def voteaccept():
    rid=request.form['rid']
    sid=request.form['lid']
    q="SELECT `vote` FROM `vote` WHERE `shid`=%s and rid=%s"
    v=(str(sid),rid)
    s=selectone(q,v)
    if s is None:
        qry="insert into `vote` values(null,%s,%s,'1')"
        val = (str(rid), str(sid))
        iud(qry,val)
        val=(str(rid),)
        qry="SELECT COUNT(*) FROM `project_allocation` WHERE pid IN(SELECT `pid` FROM `request` WHERE `id`=%s)"
        tvot=selectone(qry,val)
        qry="SELECT SUM(`vote`),COUNT(`vote`) FROM `vote` WHERE `rid`=%s"
        dvot=selectone(qry,val)
        print(dvot)
        print(int(dvot[1]),int(tvot[0]),"+++++++++++++++++++++++++++++++++++++++++++++++++++")
        if (int(dvot[1]) == int(tvot[0])):
            if int(dvot[0])>(int(tvot[0])/2):
                qry="UPDATE `request` SET `status`='accepted' WHERE `id`=%s"
                iud(qry,val)
                qry1=" SELECT `request`.`amount`,`project`.`pro_id`,`project`.`mid` FROM `request` JOIN `project` ON `project`.`pro_id`=`request`.`pid` WHERE `request`.`id`=%s"
                r=selectone(qry1,val)

                qry2="UPDATE `pvalet` SET `balance`=balance-"+str(r[0])+" WHERE `id`=%s"
                val = (str(r[1]))
                iud(qry2,val)

                q1 = "SELECT * FROM `valet` WHERE `uid`=%s"
                val = (str(r[2]))
                print(q1,val)
                sval = selectone(q1, val)
                print(sval,"=============================================")

                if sval is not None:
                    qry3=" UPDATE `valet` SET `balance`=`balance`+"+str(r[0])+" WHERE `uid`=%s"
                    val=(str(r[2]))
                    iud(qry3,val)
                else:
                    qry3 = " INSERT INTO `valet` VALUES(NULL,%s,%s)"
                    val = (str(r[2]),str(r[0]))
                    iud(qry3, val)



            else:
                qry = "UPDATE `request` SET `status`='rejected' WHERE `id`=%s"
                iud(qry, val)

        generate1(sid)
        con = pymysql.connect(host='localhost', port=3306, user='root', passwd='', db='cloudfunding')
        cmd = con.cursor()
        cmd.execute("SELECT * FROM `cipher` WHERE id='" + str(sid) + "'")
        rse = cmd.fetchone()
        sender_address = rse[1]
        sender_private_key = rse[2]
        transaction = Transaction(sender_address, sender_private_key, str(rid) + "#" + str(sid), 'Yes')
        # response = {'transaction': transaction.to_dict()}
        d = transaction.to_dict()
        d['signature'] = transaction.sign_transaction()
        print(d)
        import requests
        re = requests.post("http://127.0.0.1:8080/transactions/new", data=d)
        print(re.status_code)
        return jsonify({'task': 'Accepted'})
    else:
        return jsonify({'task': 'Already voted'})


@app.route('/votereject',methods=['post'])
def votereject():
    rid=request.form['rid']
    sid=request.form['sid']
    q="SELECT `vote` FROM `vote` WHERE `shid`=%s and rid=%s"
    v=(str(sid),str(rid))
    s=selectone(q,v)
    print(s,"sssssssssss")
    if s is None:
        qry = "insert into `vote` values(null,%s,%s,'0')"
        val = (str(rid), str(sid))
        iud(qry, val)
        val = (str(rid),)
        qry = "SELECT COUNT(*) FROM `project_allocation` WHERE pid IN(SELECT `pid` FROM `request` WHERE `id`=%s)"
        tvot = selectone(qry, val)
        qry = "SELECT SUM(`vote`),COUNT(`vote`) FROM `vote` WHERE `rid`=%s"
        dvot = selectone(qry, val)
        print(tvot,dvot)
        if (int(dvot[1]) == int(tvot[0])):
            if int(dvot[0]) > (int(tvot[0]) / 2):

                qry = "UPDATE `request` SET `status`='accepted' WHERE `id`=%s"
                iud(qry, val)
                qry1 = " SELECT `request`.`amount`,`project`.`pro_id`,`project`.`mid` FROM `request` JOIN `project` ON `project`.`pro_id`=`request`.`pid` WHERE `request`.`id`=%s"
                r = selectone(qry1, val)

                qry2 = "UPDATE `pvalet` SET `balance`=balance-" + str(r[0]) + " WHERE `id`=%s"
                val = (str(r[1]))
                iud(qry2, val)

                q1 = "SELECT * FROM `valet` WHERE `uid`=%s"
                val = (str(r[2]))
                sval = selectone(q1, val)
                print(sval,"========================================")
                if sval is not None:
                    qry3 = " UPDATE `valet` SET `balance`=`balance`+" + str(r[0]) + " WHERE `uid`=%s"
                    val = (str(r[2]))
                    iud(qry3, val)
                else:
                    qry3 = " INSERT INTO `valet` VALUES(NULL,%s,%s)"
                    val = (str(r[2]), str(r[0]))
                    iud(qry3, val)





            else:
                qry = "UPDATE `request` SET `status`='rejected' WHERE `id`=%s"
                iud(qry, val)
        generate1(sid)
        con = pymysql.connect(host='localhost', port=3306, user='root', passwd='', db='cloudfunding')
        cmd = con.cursor()
        cmd.execute("SELECT * FROM `cipher` WHERE id='" + str(sid) + "'")
        rse = cmd.fetchone()
        sender_address = rse[1]
        sender_private_key = rse[2]
        transaction = Transaction(sender_address, sender_private_key, str(rid)+"#"+str(sid), 'No')
        # response = {'transaction': transaction.to_dict()}
        d = transaction.to_dict()
        d['signature'] = transaction.sign_transaction()
        print(d)
        import requests
        re = requests.post("http://127.0.0.1:8080/transactions/new", data=d)
        print(re.status_code)
        return jsonify({'task':'Rejected'})
    else:
        return jsonify({'task': 'Already voted'})


def generate1(id):
    con = pymysql.connect(host='localhost', port=3306, user='root', passwd='', db='cloudfunding')
    cmd = con.cursor()
    random_gen = Crypto.Random.new().read
    private_key = RSA.generate(1024, random_gen)
    public_key = private_key.publickey()
    response = {
        'private_key': binascii.hexlify(private_key.exportKey(format='DER')).decode('ascii'),
        'public_key': binascii.hexlify(public_key.exportKey(format='DER')).decode('ascii'),

    }
    cmd.execute("SELECT public_key,private_key FROM cipher where id='"+id+"' ")
    a = cmd.fetchone()
    if a is None:
        cmd.execute("insert into cipher values('"+id+"','" + str(response['public_key']) + "','" + str(
            response['private_key']) + "')")
        con.commit()
    # else:
    #     cmd.execute("update cipher set public_key='" + str(response['public_key']) + "',private_key='" + str(
    #         response['private_key']) + "' where  id='"+id+"'")
    #     con.commit()
@app.route('/wallet',methods=['post'])
def wallet():
    lid=request.form['lid']
    amt=request.form['amt']
    bnk=request.form['bnk']
    ifsc=request.form['ifsc']
    pin=request.form['pin']
    acc=request.form['acc']
    q1="SELECT * FROM `valet` WHERE `uid`=%s"
    v1=(str(lid))
    s=selectone(q1,v1)
    if s is None:
        q="INSERT INTO valet VALUES(NULL,%s,%s)"
        val=(str(lid),amt)
        iud(q,val)
        q1="UPDATE `bank` SET `amount`=`amount`-%s WHERE `uid`=%s AND `account_no`=%s AND `ifsc`=%s AND `pin`=%s AND `bank`=%s"
        print(q1)
        v=(amt,str(lid),acc,ifsc,pin,bnk)
        print(v)
        iud(q1,v)
        return jsonify({'task': 'success'})
    else:
        q = "update valet set balance=balance+%s where uid=%s"
        val = (amt,str(lid))
        iud(q, val)
        q1 = "UPDATE `bank` SET `amount`=amount-%s WHERE `uid`=%s AND `account_no`=%s AND `ifsc`=%s AND `pin`=%s AND `bank`=%s"
        print(q1)
        v = (amt, str(lid), acc, ifsc, pin, bnk)
        print(v)
        iud(q1, v)
        return jsonify({'task': 'success'})
@app.route('/view_wallet',methods=['post'])
def view_wallet():
    print("okkkkkkkkkkkk")
    lid=request.form['lid']
    print(lid,"=================")
    q="SELECT `bank`.*,`stockholder`.`fname`,`stockholder`.`lname`,`valet`.`balance`  FROM `stockholder` JOIN `bank` ON `bank`.`uid`=`stockholder`.`loginid` left JOIN `valet` ON `stockholder`.`loginid`=`valet`.`uid` WHERE `stockholder`.`loginid`='"+str(lid)+"'"
    s=androidselectallnew(q)
    print(s)
    return jsonify(s)
@app.route('/sreg',methods=['post'])
def sreg():
    try:
        fname=request.form['fname']
        lname=request.form['lname']
        place=request.form['place']
        post=request.form['post']
        pin=request.form['pin']
        email=request.form['email']
        contact=request.form['contact']
        uname=request.form['uname']
        password=request.form['password']
        photo = request.files['files']
        acc=request.form['accno']
        ifsc=request.form['ifsc']
        bnk=request.form['bnk']
        qry="insert into login values(null,%s,%s,'pending')"
        val=(uname,password)
        lid=iud(qry,val)
        val1=(str(lid),fname,lname,place,post,pin,email,contact,bnk,acc,ifsc)
        path = r"./static/pic/" + str(lid) + ".png"
        photo.save(path)
        qry1="insert into stockholder values(null,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        val1=(str(lid),fname,lname,place,post,pin,email,contact,bnk,acc,ifsc)
        iud(qry1,val1)
        q2="INSERT INTO `bank` VALUES(NULL,%s,%s,%s,%s,%s,%s)"
        import random
        pin=random.randint(1000,9999)
        v2=(str(lid),acc,ifsc,str(pin),'5000000',bnk)
        iud(q2,v2)
        qry="insert into `valet` VALUES(NULL,%s,0)"
        val=(str(lid))
        iud(qry,val)
        return jsonify({'task': 'success'})
    except:
        return jsonify({'task': 'username already exists'})


app.run(host='0.0.0.0',port=5000)
