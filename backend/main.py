from fastapi import FastAPI
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
        return {
            "message": f"{user_create.username} already exists."
        }

    user_data: User = User(**user_create.model_dump())
    users[user_create.username] = user_data.model_dump()

    return {
        "message": f"{user_create.username} registered!"
    }


@app.put("/user/{username}")
def update_score(username: str, score: int):
    if username not in users:
        return {
            "message": f"{username} not found."
        }
    
    users[username]["score_history"].append(score)
    return users[username]