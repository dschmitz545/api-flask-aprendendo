#import sqlite3
from ../db import db

class UserModel(db.Model):
    __tablename__='usuario'

    codigo_usu = db.Column(db.Integer,primary_key = True)
    login_usu = db.Column(db.String(250))
    senha_usu = db.Column(db.String(250))

    