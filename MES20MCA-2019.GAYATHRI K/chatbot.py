
import pymysql
from werkzeug.utils import secure_filename
import re, math
from src.dbconnect import *
def cb(qus):
    WORD = re.compile(r'\w+')

    from collections import Counter
    def text_to_vector(text):
        words = WORD.findall(text)
        return Counter(words)

    def get_cosine(vec1, vec2):
        intersection = set(vec1.keys()) & set(vec2.keys())
        numerator = sum([vec1[x] * vec2[x] for x in intersection])
        sum1 = sum([vec1[x] ** 2 for x in vec1.keys()])
        sum2 = sum([vec2[x] ** 2 for x in vec2.keys()])
        denominator = math.sqrt(sum1) * math.sqrt(sum2)

        if not denominator:
            return 0.0
        else:
            return float(numerator) / denominator

    vector1 = text_to_vector(qus)
    import  pymysql
    con = pymysql.connect(host="localhost", user="root", password="", port=3306, db="intelligent chatbot")
    cmd = con.cursor()
    cmd.execute("select questions,id from chatbot_ds")
    s =cmd.fetchall()
    srs=s
    print("s--" ,s)
    res = []
    for d in s:
        print(d[1])
        vector2 = text_to_vector(str(d))
        cosine = get_cosine(vector1, vector2)
        # print("cosine",cosine)

        res.append(cosine)

    print("res---" ,res)

    ss = 0
    cnt = -1
    i = 0
    for s in res:
        if s > 0.3:
            if ss <= float(s):
                cnt = i
                ss = s
        i = i + 1

    print("ss", ss)
    print("cnt", cnt)
    if cnt==-1:
        return "I can not understand the question"
    cmd.execute("select * from chatbot_ds where id='" + str(srs[cnt][1]) + "'")
    aa =cmd.fetchone()
    print(aa)
    if aa is None:
        return "I can not understand the question"
    else:
        info = sent(qus)
        print(info,"+++++++++++++++++++++++++++++++++++++++")
        if info == "negative":
            qry = "select * from `chatbot_ds` WHERE id='" + str(srs[cnt][1]) + "'"
            outs = selectone(qry)
            print(outs,"_______________________________")
            print(outs[3])
            return outs[3]
        else:
            print(aa[2])
            return aa[2]


def sent(k):
    import nltk
    from nltk.sentiment.vader import SentimentIntensityAnalyzer
    pstv=0
    ngtv=0
    ntl=0
    sid = SentimentIntensityAnalyzer()
    ss = sid.polarity_scores(k)
    a = float(ss['pos'])
    c = float(ss['neg'])
    b = float(ss['neu'])
    print(ss)
    if c >b or  c>a:
        res = "negative"
    else:
        res="positive"
    return  res

# cb("heee")


