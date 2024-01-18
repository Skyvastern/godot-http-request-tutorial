from fastapi import FastAPI, HTTPException, status
from models import User, UserCreate

app = FastAPI()
users: dict[str, dict] = {}


@app.get("/")
def read_root():
    return {"message": "Hello, world!"}


@app.get("/user")
def get_users():
    return users


@app.get("/user/{username}")
def get_users(username: str):
    return users[username]


@app.post("/signup")
def signup(user_create: UserCreate):
    if user_create.username in users:
        raise HTTPException(status.HTTP_409_CONFLICT, f"{user_create.username} already exists.")

    user_data: User = User(**user_create.model_dump())
    users[user_create.username] = user_data.model_dump()

    return {
        "message": f"{user_create.username} registered!"
    }


@app.post("/login")
def signup(user: UserCreate):
    if user.username not in users:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "User not found.")
    
    if user.password != users[user.username]["password"]:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Incorrect password.")
    
    return {
        "message": f"Successfully logged in!"
    }


@app.put("/score/{score}")
def update_score(user: UserCreate, score: int):
    if user.username not in users:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "User not found.")
    
    if user.password != users[user.username]["password"]:
        raise HTTPException(status.HTTP_401_UNAUTHORIZED, "Incorrect password.")
    
    users[user.username]["score_history"].append(score)
    return users[user.username]