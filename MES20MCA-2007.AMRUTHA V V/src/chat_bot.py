@app.route('/insertchatbot',methods=['GET','POST'])
def insertchatbot():
    con = pymysql.connect(host="localhost", port=3306, user="root", password="", db="retinal_disease")
    cmd = con.cursor()
    qus=request.form['msg']
    lid=request.form['lid']
    res = cb(qus)
    cmd.execute("INSERT INTO `chatbot` VALUES(NULL,'" + qus + "','" + res + "',curdate(),'"+ str(lid)+"')")
    con.commit()
    # print(fn,"======================================fn")
    return jsonify({'task': 'success'})
@app.route("/response",methods=['post'])
def response():
    con = pymysql.connect(host="localhost", port=3306, user="root", password="", db="retinal_disease")
    cmd = con.cursor()
    st_id=request.form['lid']
    # qry="SELECT doubt,st_id,reply,date  FROM doubt where st_id=%s "
    cmd.execute("SELECT questions,lid,answer FROM `chatbot` WHERE `lid`='"+str(st_id)+"'")
    s=cmd.fetchall()
    print("ss",s)
    # val=(st_id)
    # s=select1(qry,val)
    row_headers = ['frmid','toid','msg']
    json_data = []
    for result in s:
        print(result)
        row=[]
        row.append(st_id)
        row.append(0)
        row.append(result[0])
        json_data.append(dict(zip(row_headers, row)))
        row = []
        row.append(0)
        row.append(st_id)
        row.append(result[2])
        json_data.append(dict(zip(row_headers, row)))
    print(json_data)
    return jsonify(json_data)

app.run(host="0.0.0.0",port="5000")
