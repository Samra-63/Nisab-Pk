from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from app.models.user import Base, User
from app.schemas.user_schema import UserRegister, UserLogin, TokenResponse
from app.core.security import get_password_hash, verify_password, create_access_token

# SQLite for rapid local testing
DATABASE_URL = "sqlite:///./nisab_pk.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base.metadata.create_all(bind=engine)

app = FastAPI(title="Nisab PK Backend Engine", version="1.0.0")

# Enable CORS for Flutter Android emulator and devices
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/api/v1/auth/register", response_model=TokenResponse)
def register(user_data: UserRegister):
    db: Session = SessionLocal()
    existing = db.query(User).filter(User.email == user_data.email).first()
    if existing:
        db.close()
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
    db.close()
    return {"access_token": token, "user": user_dict}

@app.post("/api/v1/auth/login", response_model=TokenResponse)
def login(login_data: UserLogin):
    db: Session = SessionLocal()
    user = db.query(User).filter(User.email == login_data.email).first()
    if not user or not verify_password(login_data.password, user.hashed_password):
        db.close()
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid email or password.")
    
    token = create_access_token({"sub": user.email, "id": user.id})
    user_dict = {
        "id": user.id,
        "full_name": user.full_name,
        "email": user.email,
        "board": user.board,
        "grade": user.grade
    }
    db.close()
    return {"access_token": token, "user": user_dict}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)