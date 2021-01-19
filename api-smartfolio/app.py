#import os
#
#from flask import Flask
#from flask_jwt import JWT
#from flask_restful import Api
#
#app = Flask(__name__)
#app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///data.db')
#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
#app.config['PROPAGATE_EXCEPTIONS'] = True
#app.secret_key = 'diego'
#api = Api(app)
#
# jwt = JWT(app, authenticate, identity) # aqui já vai criar a rota /auth também
#
# if __name__ == '__main__':
#    from db import db
#    db.init_app(app)
#    app.run(port=5000, debug=True)

from flask import Flask
server = Flask(__name__)


@server.route("/")
def hello():
    return "Hello World 222!"


if __name__ == "__main__":
    server.run(host='0.0.0.0')
