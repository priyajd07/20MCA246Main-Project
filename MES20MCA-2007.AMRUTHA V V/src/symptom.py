from sklearn.ensemble import RandomForestClassifier

import numpy as np
import pymysql



def pred(key):
    con = pymysql.connect(host="localhost", port=3306, user="root", password="", db="retinal_disease")
    cmd = con.cursor()
    cmd.execute("SELECT DISTINCT `sym` FROM `symptom` order by sym")
    s=cmd.fetchall()
    dsym=[]
    for i in s:
        dsym.append(i[0])
    cmd.execute("SELECT * FROM `disease` where `status`='ok'")
    s=cmd.fetchall()
    dataset=[]
    ansset=[]
    for i in s:
        cmd.execute("SELECT DISTINCT `sym` FROM `symptom` WHERE `did`="+str(i[0]))
        ss=cmd.fetchall()
        myrow=[]
        for ii in ss:
            myrow.append(ii[0])
        ansset.append(int(i[0]))
        row=[]
        for w in dsym:
            if w in myrow:
                row.append(1)
            else:
                row.append(0)
        dataset.append(row)


    rnd = RandomForestClassifier()
    rnd.fit(dataset,ansset)

    c = rnd.predict(np.array(key))
    print(c)
    return c[0]
# pred([[0,0,1]])