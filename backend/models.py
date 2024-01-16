from pydantic import BaseModel


class UserCreate(BaseModel):
    username: str
    password: str

    class Config:
        extra = "forbid"


class User(UserCreate):
    score_history: list[int] = []