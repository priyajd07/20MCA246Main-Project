from flask import *
import os
from werkzeug.utils import secure_filename
from src.dbop import iud, selectall, selectone,selectalls
path="static//videos"
app = Flask(__name__)
import cv2

@app.route('/')
def main():

    return render_template('login.html')

@app.route('/login', methods=['post'])
def login():
    un = request.form['username']
    passwd = request.form['passwd']
    qry = "SELECT * FROM `login` WHERE `username`='" + un + "' AND `password`='" + passwd + "' and type='admin'"
    res = selectone(qry)
    if res is None:
        return ''' <script>alert('Invalid username or password');window.location='/'</script> '''
    else:
        return ''' <script>window.location='/adminhome'</script> '''


@app.route('/adminhome')
def adminhome():
    return render_template('Admin home.html')

@app.route('/addpolice')
def addpolice():
    qry = "SELECT * FROM `police`"
    res = selectall(qry)
    return render_template('Add police.html', val=res)


@app.route('/addcam')
def addcam():
    qry = "SELECT * FROM `camera`"
    value = selectall(qry)
    return render_template('Cam details.html', val=value)


@app.route('/policeregistration',methods=['post'])
def policeregistration():
    return render_template('Police Registration.html')

@app.route('/camregistration',methods=['get','post'])
def camregistration():
    return render_template('Cam Registration.html')



@app.route('/camreg', methods=['post'])
def camreg():
    Camerno=request.form['textfield']
    Landmark = request.form['textfield2']
    Place = request.form['textfield3']
    qry="insert into camera values(null,%s,%s,%s)"
    val=Camerno,Landmark,Place
    iud(qry,val)
    return '''<script>alert("registered");window.location="/addcam"</script>'''

@app.route('/videoup')
def videoup():
    qry="SELECT * FROM camera"
    res=selectall(qry)
    return  render_template('videoup.html',res=res)

@app.route('/videoup1', methods=['post'])
def videoup1():
    cid=request.form['cam']
    file=request.files['file']
    var=secure_filename(file.filename)
    file.save(os.path.join(path,var))
    qry="insert into videoup values(null,%s,%s,curdate(),curtime())"
    val=cid,var
    vid=iud(qry,val)

    cam = cv2.VideoCapture(os.path.join(path, var))

    currentframe = 0

    while (True):

        ret, frame = cam.read()

        if ret:
            if currentframe % 15 == 0:
                n = 'frame' + str(vid) + str(currentframe) + '.jpg';
                name = 'static/frame/frame' + str(vid) + str(currentframe) + '.jpg'

                print('creating...' + name)
                qry="INSERT INTO frame VALUES(NULL,%s,%s,'pending')"
                val = vid, n
                iud(qry,val)

                cv2.imwrite(name, frame)
            currentframe += 1

        else:
            break

    cam.release()
    cv2.destroyAllWindows()
    return '''<script>alert("uploaded successfully");window.location="/adminhome"</script>'''
@app.route('/searchpolice', methods=['post'])
def searchpolice():
    name=request.form['textfield']
    qry = "SELECT * FROM `police` where name=%s"
    res =selectalls(qry,name)
    return render_template('Add police.html', val=res)

@app.route('/viewassign')
def viewassign():
    qry="SELECT `police`.`Name`,`work`.`work`,`work`.`date`,`work`.`status` FROM `work` JOIN `police` ON `police`.`l_id`=`work`.uid"
    s=selectall(qry)
    return render_template('assignedwrks.html', val=s)
@app.route('/assign', methods=['post'])
def assign():
    qry="SELECT * FROM `police`"
    s=selectall(qry)
    return  render_template('assign.html',v=s)
@app.route('/assign1', methods=['post'])
def assign1():
    pid=request.form['slt']
    wrk=request.form['textarea']
    qry="insert into work values(null,%s,%s,curdate(),'pending')"
    value=(wrk,str(pid))
    iud(qry,value)
    return '''<script>alert(" success");window.location="/viewassign"</script>'''















app.run(debug=True)





