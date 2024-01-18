from pydantic import BaseModel


class UserCreate(BaseModel):
    username: str
    password: str

    class Config:
        extra = "forbid"


class User(UserCreate):
    score_history: list[int] = []


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str | None = None