from datetime import date
from typing import Optional
from sqlmodel import SQLModel, Field

# --- DATABASE MODELS ---

class User(SQLModel, table=True):
    username: str = Field(primary_key=True, index=True)
    # In a real app, you'd add hashed_password here. 
    # Kept to just username per your requirement.

class Task(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    title: str
    description: str
    due_date: date
    status: str = Field(default="To-Do")
    
    # Relationships
    owner_username: str = Field(foreign_key="user.username")
    blocked_by_id: Optional[int] = Field(default=None, foreign_key="task.id")

# --- API SCHEMAS (For Request/Response) ---

class TaskCreate(SQLModel):
    title: str
    description: str
    due_date: date
    status: str = "To-Do"
    blocked_by_id: Optional[int] = None

class TaskUpdate(SQLModel):
    title: Optional[str] = None
    description: Optional[str] = None
    due_date: Optional[date] = None
    status: Optional[str] = None
    blocked_by_id: Optional[int] = None

class Token(SQLModel):
    access_token: str
    token_type: str