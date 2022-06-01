import pymysql
def iud(query,val):
    con=pymysql.connect(host='localhost',port=3306,user='root',password='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(query,val)
    con.commit()
    id=cmd.lastrowid
    return id
def selectall(query):
    con=pymysql.connect(host='localhost',port=3306,user='root',password='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(query)
    s=cmd.fetchall()
    return s
def selectsome(query,val):
    con=pymysql.connect(host='localhost',port=3306,user='root',password='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(query,val)
    s=cmd.fetchall()
    return s
def selectone(query,val):
    con=pymysql.connect(host='localhost',port=3306,user='root',password='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(query,val)
    s=cmd.fetchone()
    return s


def androidselectall(q,val):
    con=pymysql.connect(host='localhost',port=3306,user='root',passwd='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(q,val)
    s=cmd.fetchall()
    row_headers = [x[0] for x in cmd.description]
    json_data = []
    print(json_data)
    for result in s:
        json_data.append(dict(zip(row_headers, result)))
    return json_data

def androidselectallnew(q):
    con=pymysql.connect(host='localhost',port=3306,user='root',passwd='',db='retinal_disease')
    cmd=con.cursor()
    cmd.execute(q)
    s=cmd.fetchall()
    row_headers = [x[0] for x in cmd.description]
    json_data = []
    print(json_data)
    for result in s:
        json_data.append(dict(zip(row_headers, result)))
    return json_data