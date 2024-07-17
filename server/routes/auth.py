
import uuid

import bcrypt
import jwt
from fastapi import APIRouter, Depends, Header, HTTPException
from sqlalchemy.orm import Session, joinedload

from database import get_db
from middleware.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_login import UserLogin

router = APIRouter()

# Signup


@router.post('/signup', status_code=201)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):

    # check if the user already exists in db
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400, 'User with the same email already exists!')
        return

    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(id=str(uuid.uuid4()), email=user.email,
                   password=hashed_pw, name=user.name,)

    # add the user to the db
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

# Login


@router.post('/login')
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # check if the user with same email already exists
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(400, 'User with this email does not exist!')

    # password matching or not
    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)

    if not is_match:
        raise HTTPException(400, 'Incorrect password!')

    token = jwt.encode({'id': user_db.id}, 'password_key')

    return {'token': token, 'user': user_db}

# Current user data


@router.get('/')
def current_user_data(db: Session = Depends(get_db),
                      user_dict=Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).options(
        joinedload(User.favorites)).first()

    if not user:
        raise HTTPException(404, 'User not found!')

    return user
