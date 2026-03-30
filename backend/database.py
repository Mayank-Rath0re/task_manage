import os
from sqlmodel import create_engine, Session

# Replace with your actual Postgres credentials if different
DATABASE_URL = os.getenv(
    "DATABASE_URL", 
    "postgresql://postgres:postgres@localhost:5432/taskdb"
)

# Connect args can be customized; echo=True helps debug SQL queries in the console
engine = create_engine(DATABASE_URL, echo=False)

def get_session():
    with Session(engine) as session:
        yield session