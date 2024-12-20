from flask import *
from flask_restful import Api

from datetime import timedelta

app = Flask(__name__)


api = Api(app)

from views.views import MembersSignin, MemberSignup

api.add_resource(MemberSignup, '/api/register')
api.add_resource(MembersSignin, '/api/member_signin')


if __name__ == "__main__":
    app.run(debug=True, port=5555)