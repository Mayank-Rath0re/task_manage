import asyncio
import jwt
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from sqlmodel import Session, select, SQLModel
from typing import List

from database import engine, get_session
from models import User, Task, TaskCreate, TaskUpdate, Token
from contextlib import asynccontextmanager

# Define the lifespan context manager
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Load the ML model or create DB tables
    SQLModel.metadata.create_all(engine)
    yield
    # Clean up the ML models and release the resources (if any)
    pass

# --- AUTHENTICATION CONFIG ---
SECRET_KEY = "super-secret-assessment-key" # Change in production
ALGORITHM = "HS256"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

def create_access_token(data: dict):
    return jwt.encode(data, SECRET_KEY, algorithm=ALGORITHM)

def get_current_user(token: str = Depends(oauth2_scheme), session: Session = Depends(get_session)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise Exception("Credentials Not Matching")
    except jwt.PyJWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user = session.get(User, username)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


# Initialize FastAPI with the lifespan
app = FastAPI(title="Task Management API with Auth", lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Allow Flutter to connect
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# --- AUTH ENDPOINTS ---
@app.post("/login", response_model=Token)
def login(form_data: OAuth2PasswordRequestForm = Depends(), session: Session = Depends(get_session)):
    """
    Simple username-based login. 
    If the username doesn't exist, we create it to make testing easy.
    """
    user = session.get(User, form_data.username)
    if not user:
        user = User(username=form_data.username)
        session.add(user)
        session.commit()
    
    access_token = create_access_token(data={"sub": user.username})
    return {"access_token": access_token, "token_type": "bearer"}


# --- CRUD ENDPOINTS ---
@app.post("/tasks", response_model=Task)
async def create_task(
    task_in: TaskCreate, 
    current_user: User = Depends(get_current_user),
    session: Session = Depends(get_session)
):
    await asyncio.sleep(2) # Assessment Requirement: 2s delay
    
    # Merge the request data with the current authenticated user
    db_task = Task(**task_in.model_dump(), owner_username=current_user.username)
    session.add(db_task)
    session.commit()
    session.refresh(db_task)
    return db_task

@app.get("/tasks", response_model=List[Task])
def read_tasks(
    current_user: User = Depends(get_current_user), 
    session: Session = Depends(get_session)
):
    # Only return tasks belonging to the logged-in user
    statement = select(Task).where(Task.owner_username == current_user.username)
    return session.exec(statement).all()

@app.put("/tasks/{task_id}", response_model=Task)
async def update_task(
    task_id: int, 
    task_in: TaskUpdate, 
    current_user: User = Depends(get_current_user),
    session: Session = Depends(get_session)
):
    await asyncio.sleep(2) # Assessment Requirement: 2s delay
    
    db_task = session.get(Task, task_id)
    if not db_task or db_task.owner_username != current_user.username:
        raise HTTPException(status_code=404, detail="Task not found or unauthorized")
    
    # Update only fields that were provided
    task_data = task_in.model_dump(exclude_unset=True)
    for key, value in task_data.items():
        setattr(db_task, key, value)
        
    session.add(db_task)
    session.commit()
    session.refresh(db_task)
    return db_task

@app.delete("/tasks/{task_id}")
def delete_task(
    task_id: int, 
    current_user: User = Depends(get_current_user),
    session: Session = Depends(get_session)
):
    db_task = session.get(Task, task_id)
    if not db_task or db_task.owner_username != current_user.username:
        raise HTTPException(status_code=404, detail="Task not found or unauthorized")
        
    session.delete(db_task)
    session.commit()
    return {"message": "Task deleted successfully"}