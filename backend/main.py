import uvicorn
from typing import Annotated
from fastapi import FastAPI, HTTPException, status, Depends
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta, timezone
from models import User, UserCreate, Token, TokenData


# region Initialization

db: dict[str, dict] = {}

SECRET_KEY = "1fea7ffb7abb5ebd60b2357543b2664aa3abfbc4b5ec9118f4b5e2cd693d1f60"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

app = FastAPI()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# endregion


# region Helper methods

def get_user(db, username: str):
    if username in db:
        user_data = db[username]
        return User(**user_data)


def get_password_hash(password: str):
    return pwd_context.hash(password)


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def authenticate_user(db, username: str, password: str):
    user = get_user(db, username)

    if not user:
        return False

    if not verify_password(password, user.password):
        return False
    
    return user


def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()

    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    
    to_encode.update({"exp": expire})

    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Credentials cannot be validated.",
        headers={"WWW-Authenticate": "Bearer"}
    )

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
        
        token_data = TokenData(username=username)

    except JWTError:
        raise credentials_exception
    
    user = get_user(db, username=token_data.username)
    if user is None:
        raise credentials_exception
    
    return user


def get_token(username: str, password: str):
    user = authenticate_user(db, username, password)
    if not user:
        return None
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username},
        expires_delta=access_token_expires
    )

    return Token(access_token=access_token, token_type="bearer")

# endregion


# region API Endpoints

@app.get("/")
def read_root():
    return {"message": "Hello, world!"}


@app.get("/user")
def get_all_users():
    return db


@app.get("/user/me")
async def read_user_me(current_user: Annotated[User, Depends(get_current_user)]):
    return current_user


@app.post("/signup")
def signup(user_create: UserCreate):
    # Setup user and add it to the database
    if user_create.username in db:
        raise HTTPException(status.HTTP_409_CONFLICT, f"{user_create.username} already exists.")

    user_data: User = User(
        username=user_create.username,
        password=get_password_hash(user_create.password),
        score_history=[]
    )

    db[user_data.username] = user_data.model_dump()

    # Create access token
    access_token = get_token(user_create.username, user_create.password)
    if not access_token:
        db.pop(user_data.username)

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Unable to create the account, try again.",
            headers={"WWW-Authenticate": "Bearer"}
        )

    # Send the response
    return {
        "message": "Success",
        "username": user_create.username,
        "access_token": access_token.access_token,
        "token_type": access_token.token_type
    }


@app.post("/token")
def login_for_access_token(form_data: Annotated[OAuth2PasswordRequestForm, Depends()]):
    access_token = get_token(form_data.username, form_data.password)

    if not access_token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password.",
            headers={"WWW-Authenticate": "Bearer"}
        )
    
    return {
        "message": "Success",
        "username": form_data.username,
        "access_token": access_token.access_token,
        "token_type": access_token.token_type
    }


@app.put("/score/{score}")
def update_score(user: Annotated[User, Depends(get_current_user)], score: int):
    db[user.username]["score_history"].append(score)

    return {
        "message": "Success",
        "user": db[user.username]
    }


@app.get("/score/leaderboard")
def get_leaderboard():
    users = []

    for key, value in db.items():
        score_history = value["score_history"]
        score_count = len(score_history)
        avg_score = 0

        if score_count > 0:
            sum_of_scores = sum(score_history)
            avg_score = sum_of_scores / score_count
        
        users.append((key, avg_score))
    
    ranked_users = sorted(
        users,
        key=lambda x: x[1],
        reverse=True
    )
    
    return {
        "message": "Success",
        "ranked_users": ranked_users
    }

# endregion


if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, log_level="info", reload=True)