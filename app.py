from flask import Flask,request,url_for,jsonify,send_from_directory
import decimal
import flask.json
import hashlib
import datetime 
import pymysql.cursors
import os

class MyJSONEncoder(flask.json.JSONEncoder):
    def default(self, obj):
        print(str(obj))
        if isinstance(obj, decimal.Decimal):
            # Convert decimal instances to strings.
            return str(obj)
        if isinstance(obj, (datetime.date, datetime.datetime,datetime.timedelta)):
            return ""+str(obj)+""
        return super(MyJSONEncoder, self).default(obj)
conn=cursor=None
UPLOAD_FOLDER = 'product-images'
uploadpath=os.path.join(os.getcwd(),UPLOAD_FOLDER)
def openDb():
    global conn,cursor
    conn=pymysql.connect(host="localhost",user="root",password="",database="rentall")
    cursor=conn.cursor(pymysql.cursors.DictCursor)
def closeDb():
    cursor.close()
    conn.close()
app=Flask(__name__)
app.json_encoder = MyJSONEncoder
@app.route('/')
def index():
    return "hola"
@app.route('/products')
def getFields():
   container=[]
   openDb()
   cursor.execute("Select * from product")
   data=cursor.fetchall()
   for field in data:
       cursor.execute("Select * from spec where id_products=%s",field['id_products'])
       field["spec"]=cursor.fetchone()
       container.append(field)
   closeDb()
   return jsonify(container)
@app.route('/profile/<id>/book')
def getBookList(id):
   
   container=[]
   openDb()
   cursor.execute("Select * from booking  where id_user=%s",(id))
   data=cursor.fetchall()
   for order in data:
     cursor.execute("select * from product where id_products =%s",(order["id_product"]))
     product=cursor.fetchone()
     order["product"]=product
     container.append(order)
   closeDb()
   return jsonify(container)
@app.route('/review/<id_product>')
def review(id_product):
   openDb()
   container=[]
   cursor.execute("Select id_booking from booking where id_product=%s",(id_product))
   dataid=cursor.fetchall()
   for id in dataid:
    cursor.execute("Select * from reviews where id_booking=%s",id["id_booking"])
    data=cursor.fetchone()
    if data!=None:
      container.append(data)
   closeDb()
   return jsonify(container)
@app.route('/review/create', methods=['POST'])
def addreview():
  map=request.form
  sql="REPLACE INTO `reviews` (`id_booking`, `review`, `rate`)"
  sql+=" VALUES (%s, %s, %s);"
  openDb()
  try:
    cursor.execute(sql,(map['id_booking'],map['review'],map['rate']))
    conn.commit()
    closeDb()
    return jsonify({
      "result":True,
      "message":"success add review"
    })
  except Exception as e:
    closeDb()
    return jsonify({
      "result":False,
      "message":"cannot process you\'re request, try later"
    })
@app.route('/auth/login', methods=['POST'])
def login():
   map=request.form
   password=hashlib.sha1(map['password'].encode()).hexdigest()
   sql="select count(*) as result,email,id_user as uid from user where email=%s AND password=%s"
   val=(map['email'],password)
   print("select count(*) as result,email,id_user as uid from user where email="+val[0]+" AND password="+val[1])
   openDb()
   cursor.execute(sql,val)
   result = cursor.fetchone()
   
   result['message']="Login Success" if result['result']>0 else "login not success"
   if(result['result']==1):
       result['data']={
           "email":result['email'],
           "uid":result['uid'],
       }
   closeDb()
   result['result']=True if result['result']>0 else False
   return jsonify(result)

@app.route('/auth/register', methods=['POST'])
def register():
   map=request.form
   sql="select count(*) as result from user where email=%s"
   val=(map['email'])

   openDb()
   cursor.execute(sql,val)
   result=cursor.fetchone()
   if (result['result']>0):
       closeDb()
       result['message']="email has been used"
       result['result']=False
       return jsonify(result)
   else:
       password=hashlib.sha1(map['password'].encode()).hexdigest()
       sql="INSERT INTO `user`"
       sql+="(`email`, `password`,`name`)"
       sql+=" VALUES (%s,%s,%s)"
       val=(map['email'],password,map['name'])
       cursor.execute(sql,val)
       conn.commit()
       sql="select count(email) as result,email,id_user as uid from user where email=%s AND password=%s"
       val=(map['email'],password)
       cursor.execute(sql,val)
       results={

       }
       result = cursor.fetchone()
       if(result['result']==1):
            results['data']={
                "email":result['email'],
                "uid":result['uid'],
            } 
       closeDb()
       results['result']=True
       results['message']="register success"
       return jsonify(results)

@app.route('/profile/<id>/details')
def getProfile(id):
   sql="SELECT * FROM `user` WHERE id_user=%s"
   openDb()
   cursor.execute(sql,(id))
   data=cursor.fetchone()
   data["password"]="*********"
   closeDb()
   if data==None:
       return jsonify({})
   return jsonify(data)

@app.route('/profile/<id>/order/make', methods=['POST'])
def makeorder(id):
   openDb()
   map=request.form
   sql="INSERT INTO `booking`( `id_user`, `id_product`, `date`, `rent_start`, `rent_end`, `total_fee`, `payment_type`, `notes`)"
   sql+=" VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
   val=(id,map['id_product'],map['date'],map['rent_start'],map['rent_end'],map['total_fee'],map['payment_type'],map['notes'])
   try:
      cursor.execute(sql,val)
      conn.commit()
      closeDb()
      return jsonify({
          "message":"success processing your order",
          "result":True
      })
   except Exception:
      return jsonify({
        "message":"cannot processing your order, please try again later",
        "result":False
      })
@app.route('/product/image/<filename>')
def geturlfile(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)
if __name__=="__main__":
    app.run(debug=True)

