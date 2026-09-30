import os
import re
from app.services.textbook_rag import TextbookRAG

api_key = os.getenv("GEMINI_API_KEY")
rag = TextbookRAG(
    data_base_path="data/textbooks",
    api_key=API_KEY
)

BOARD = "federal"
GRADE = 9

# Auto-detect path: Pehle 'federal' check karega, agar purana 'fbise' ho to fallback lega
target_dir = os.path.join("data", "textbooks", BOARD.lower(), f"class_{GRADE}")
if not os.path.exists(target_dir):
    fallback_dir = os.path.join("data", "textbooks", "fbise", f"class_{GRADE}")
    if os.path.exists(fallback_dir):
        target_dir = fallback_dir
        BOARD = "fbise"
    else:
        print(f"⚠️ Directory nahi mili: {target_dir}")
        exit()

# 1. Folder mein se tamam textbook JSONs scan karein
available_books = []
for file in os.listdir(target_dir):
    if file.endswith(f"_{GRADE}_full_book.json"):
        subject_name = file.split(f"_{GRADE}_full_book.json")[0]
        available_books.append(subject_name)

print("=" * 65)
print(f"📚 Detected books in {BOARD.upper()} Class {GRADE} folder:")
for idx, b in enumerate(available_books, 1):
    print(f"  {idx}. {b.capitalize()}")
print("=" * 65)

# 2. Sample queries per subject
sample_queries = {
    "islamiat": "قرآن مجید کے فضائل اور اس کے حقوق پر نوٹ لکھیں۔",
    "english": "What is the central theme of the first unit or poem in the textbook?",
    "biology": "Define Biology and describe its main branches.",
    "physics": "What is the difference between base quantities and derived quantities?",
    "chemistry": "Define element, compound, and mixture with examples."
}

# 3. Har available book ko bari bari test karein
for subj in available_books:
    query = sample_queries.get(subj, f"Explain the key concepts and topics of {subj.capitalize()} textbook.")
    print(f"\n🚀 Testing Subject: [{subj.upper()}] ...")
    print(f"❓ Query: {query}")
    
    try:
        result = rag.generate_board_answer(
            query=query,
            board=BOARD,
            grade=GRADE,
            subject=subj
        )
        print(f"✅ Status: OK | Cited Pages: {result['citations']}")
        print("--- Answer Preview (First 250 chars) ---")
        print(result["answer"][:250] + "...\n")
    except Exception as e:
        print(f"❌ Error in {subj}: {str(e)}")

print("=" * 65)
print("🎉 Testing completed for all available books!")