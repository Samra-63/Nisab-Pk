import json
import os
from typing import List, Dict, Any
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import google.generativeai as genai
from dotenv import load_dotenv

load_dotenv()


class TextbookRAG:
    def __init__(self, data_base_path: str = "data/textbooks", api_key: str = None):
        self.data_base_path = data_base_path

        # Priority: Passed key -> Environment Variable
        self.api_key = api_key or os.getenv("GEMINI_API_KEY")
        if not self.api_key:
            raise ValueError("GEMINI_API_KEY nahi mili! Ya to .env check karein ya api_key pass karein.")

        genai.configure(api_key=self.api_key)
        self.model = genai.GenerativeModel("gemini-3.6-flash")
        
        # Performance Cache: Bar bar disk I/O avoid karne ke liye
        self._corpus_cache: Dict[str, Dict[str, Any]] = {}

    def _normalize_board_name(self, board: str) -> str:
        """User input (Federal, FBISE, Rawalpindi, Pindi) ko exact folder name mein map karta hai."""
        b = board.strip().lower()
        if "federal" in b or "fbise" in b:
            return "federal"
        elif "rawalpindi" in b or "pindi" in b:
            return "rawalpindi"
        elif "punjab" in b or "ptb" in b or "lahore" in b:
            return "punjab"
        elif "sindh" in b or "karachi" in b:
            return "sindh"
        elif "kpk" in b or "peshawar" in b:
            return "kpk"
        return b.replace(" ", "_")

    def load_book_corpus(self, board: str, grade: int, subject: str) -> Dict[str, Any]:
        """Loads and caches extracted full book JSON textbook corpus."""
        normalized_board = self._normalize_board_name(board)
        cache_key = f"{normalized_board}_{grade}_{subject.lower()}"

        if cache_key in self._corpus_cache:
            return self._corpus_cache[cache_key]

        filename = f"{subject.lower()}_{grade}_full_book.json"
        path = os.path.join(
            self.data_base_path,
            normalized_board,
            f"class_{grade}",
            filename,
        )
        if not os.path.exists(path):
            raise FileNotFoundError(f"Corpus file not found at: {path}")

        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
            self._corpus_cache[cache_key] = data
            return data

    def retrieve_relevant_pages(
        self, query: str, pages_data: List[Dict[str, Any]], top_k: int = 2
    ) -> List[Dict[str, Any]]:
        """Finds top relevant textbook pages and trims content to keep prompt lightweight and fast."""
        if not pages_data:
            return []

        # Shuruati front-matter (copyright/committee) filter
        academic_pages = [p for p in pages_data if p.get("page_no", 0) > 4]
        search_pool = academic_pages if academic_pages else pages_data

        documents = [p.get("content", "") for p in search_pool]

        # Fast tokenization for Urdu/English
        vectorizer = TfidfVectorizer(analyzer="word", token_pattern=r"(?u)\b\w+\b")
        tfidf_matrix = vectorizer.fit_transform(documents + [query])

        query_vec = tfidf_matrix[-1]
        doc_vecs = tfidf_matrix[:-1]

        scores = cosine_similarity(query_vec, doc_vecs).flatten()
        top_indices = scores.argsort()[-top_k:][::-1]

        results = []
        for idx in top_indices:
            raw_text = search_pool[idx].get("content", "")
            # Latency reduction: Context ko compact rakhne ke liye 1200 characters limit
            trimmed_text = raw_text[:1200] if len(raw_text) > 1200 else raw_text

            results.append({
                "page_no": search_pool[idx].get("page_no", 0),
                "content": trimmed_text,
                "score": float(scores[idx]),
            })
        return results

    def generate_board_answer(
        self, query: str, board: str, grade: int, subject: str
    ) -> Dict[str, Any]:
        """Generates authentic textbook answer within 2-4 seconds."""
        book_data = self.load_book_corpus(board, grade, subject)
        pages = book_data.get("pages", [])

        relevant_pages = self.retrieve_relevant_pages(query, pages, top_k=2)

        context_text = "\n\n".join(
            [f"--- PAGE {p['page_no']} ---\n{p['content']}" for p in relevant_pages]
        )
        pages_cited = [str(p["page_no"]) for p in relevant_pages if p["score"] > 0.0]

        if not pages_cited and relevant_pages:
            pages_cited = [str(relevant_pages[0]["page_no"])]

        prompt = f"""
Aap Nisab PK ke ba-zabita Academic Board Tutor hain.
Pakistani Board ({board}), Class {grade}, Subject: {subject.capitalize()} ke student ke sawal ka textbook ke mutabiq to-the-point jawab dein.

Textbook Content:
{context_text}

Student Question:
{query}

HIDAYAT:
1. Jawab seedha textbook ki mukhtasir headings aur points mein dein (120-180 alfaz).
2. Saaf Urdu rasm-ul-khat mein likhein.
3. Ghair zaroori tamheed ke baghair direct jawab shuru karein.
4. Aakhir mein lazmi likhein: [Source: {board} Class {grade} {subject.capitalize()}, Pages: {', '.join(pages_cited)}]
"""
        generation_config = genai.types.GenerationConfig(
            max_output_tokens=700,
            temperature=0.2,
        )

        response = self.model.generate_content(
            prompt,
            generation_config=generation_config,
            request_options={"timeout": 30.0},
        )

        return {
            "answer": response.text,
            "citations": [int(p) for p in pages_cited],
            "board": board,
            "grade": grade,
            "subject": subject,
        }