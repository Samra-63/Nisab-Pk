from fastapi import FastAPI, HTTPException, status, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session

from app.models.user import Base, User
from app.schemas.user_schema import UserRegister, UserLogin, TokenResponse
from app.core.security import get_password_hash, verify_password, create_access_token
from app.services.textbook_rag import TextbookRAG

# SQLite for rapid local testing
DATABASE_URL = "sqlite:///./nisab_pk.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base.metadata.create_all(bind=engine)

app = FastAPI(title="Nisab PK Backend Engine", version="1.0.0")

# Enable CORS for Flutter Android emulator and physical devices
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dependency for clean DB sessions
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Root test endpoint
@app.get("/")
def read_root():
    return {"status": "online", "system": "Nisab PK Backend Engine"}

# Initialize Textbook RAG Engine once on startup
rag_engine = TextbookRAG(data_base_path="data/textbooks")


# ==========================================
# 1. AUTHENTICATION ENDPOINTS
# ==========================================

@app.post("/api/v1/auth/register", response_model=TokenResponse)
def register(user_data: UserRegister, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == user_data.email).first()
    if existing:
        raise HTTPException(status_code=400, detail="An account with this email already exists.")
    
    new_user = User(
        full_name=user_data.full_name,
        email=user_data.email,
        hashed_password=get_password_hash(user_data.password),
        board=user_data.board,
        grade=user_data.grade
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    token = create_access_token({"sub": new_user.email, "id": new_user.id})
    user_dict = {
        "id": new_user.id,
        "full_name": new_user.full_name,
        "email": new_user.email,
        "board": new_user.board,
        "grade": new_user.grade
    }
    return {"access_token": token, "user": user_dict}


@app.post("/api/v1/auth/login", response_model=TokenResponse)
def login(login_data: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == login_data.email).first()
    if not user or not verify_password(login_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, 
            detail="Invalid email or password."
        )
    
    token = create_access_token({"sub": user.email, "id": user.id})
    user_dict = {
        "id": user.id,
        "full_name": user.full_name,
        "email": user.email,
        "board": user.board,
        "grade": user.grade
    }
    return {"access_token": token, "user": user_dict}


# ==========================================
# 2. ACADEMIC TUTOR (FULL BOOK RAG) ENDPOINTS
# ==========================================

class TutorQueryRequest(BaseModel):
    query: str
    board: str = "FBISE"
    grade: int = 9
    subject: str = "islamiat"

class TutorQueryResponse(BaseModel):
    status: str
    answer: str
    citations: List[int]
    board: str
    grade: int
    subject: str

@app.post("/api/v1/tutor/ask", response_model=TutorQueryResponse)
def ask_academic_tutor(payload: TutorQueryRequest):
    """
    Directly answers student queries using the full-book JSON corpus.
    Grounds answers in official textbook content with page number citations.
    """
    try:
        result = rag_engine.generate_board_answer(
            query=payload.query,
            board=payload.board,
            grade=payload.grade,
            subject=payload.subject
        )
        return {
            "status": "success",
            "answer": result["answer"],
            "citations": result["citations"],
            "board": result["board"],
            "grade": result["grade"],
            "subject": result["subject"]
        }
    except FileNotFoundError as fnf:
        raise HTTPException(status_code=404, detail=f"Textbook corpus file missing: {str(fnf)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating answer: {str(e)}")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)