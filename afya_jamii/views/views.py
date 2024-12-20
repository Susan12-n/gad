from flask_restful import Resource, request
from functions import hash_verify, checkpassword, hash_password
from flask import Response, jsonify
import pymysql

class MemberSignup(Resource):
    def post(self):
        data = request.json
        sur_name = data["sur_name"]
        email = data["email"]
        others = data["others"]
        gender = data ["gender"]
        phone = data["phone"]
        DOB = data["DOB"]
        status = data["status"]
        password = data["password"]
        location_id = data["location_id"]
        # conect to db
        connection = pymysql.connect(host='localhost',user='root',password='',database='mediic')
        cursor = connection.cursor()

        response = checkpassword(password)
        if response == True:
            # it means the password is too strong
            sql = "insert into members (email,sur_name,others,gender,phone, DOB, status, password, location_id) values (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            data = (email,sur_name, others, gender, phone, DOB, status, hash_password(password), location_id)
            # try:
            cursor.execute(sql, data)
            connection.commit()
            return jsonify({ "message" : "Registration Successfuly" })

        # except:
        # # incase of an error
        # connection.rollback()
        # return jsonify({"message" : "Registration Failed"})
        else:
            return jsonify({ 'message' : response })


class MembersSignin(Resource):
    def post(self):
        data = request.json
        email = data["email"]
        password = data["password"]

        # connect to db
        connection = pymysql.connect(host='localhost', user='root', password='', database='afya_jamii')

        cursor = connection.cursor(pymysql.cursors.DictCursor)

        # check if user/email exists

        sql = 'select * from members where email = %s '

        cursor.execute(sql, email)

        # check row count to see if email exists
        if cursor.rowcount == 0:
            return jsonify( { "message": "  User does not exist"})
        
        else:
            # user exists
            member = cursor.fetchone()

            hashedpassword = member('password')

            if hash_verify(password, hashedpassword):
                # login successfull
                return jsonify({"message": "Login successfull"})


            else:
                jsonify({ "message": "Login failed"})
