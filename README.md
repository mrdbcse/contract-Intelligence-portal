# 📄 Contract Intelligence Portal (RAG)

A **production-grade Retrieval-Augmented Generation (RAG)** system that ingests contracts, RFPs, and policy documents (PDF/DOCX), parses **text, tables, and images**, and enables **question answering, clause detection, and risk analysis** with **exact citations**.

This project demonstrates end-to-end **GenAI + cloud-native architecture**, designed for real-world Big 4 consulting use cases (contracts, compliance, due diligence, financial reports).

---

## 🚀 Features

- 📂 **Multi-format ingestion**
  Upload PDF/DOCX contracts and RFPs (native or scanned).

- 🔠 **OCR + parsing**

  - Text via `pdfplumber` / Textract
  - Tables via Camelot / Textract Table API
  - Images via Tesseract OCR + BLIP captioning

- 📊 **Table & image awareness**
  Answers can come from **tables** (exact row values) or **charts/images** (OCR/caption text).

- 🔍 **Hybrid retrieval**

  - Dense semantic search (FAISS / Pinecone)
  - Sparse search (BM25 for numbers & codes)
  - Merged results with provenance

- 🤖 **RAG with citations**

  - Powered by LangChain/LlamaIndex + LLM (OpenAI or local)
  - Always cites **page number, table ID, or image caption**

- ⚠️ **Clause detection & risk rules**

  - Auto-renewal, liability cap, termination notice

- 📝 **Executive summaries**
  Auto-generate one-page contract briefs (PDF/Excel export).

- 🖥️ **Frontend**
  React + Tailwind UI with:

  - Upload manager
  - Chat interface
  - Table/image viewer

- ☁️ **Production-ready infra**

  - FastAPI backend
  - Docker + docker-compose
  - Kubernetes (K8s) deployment
  - AWS-ready (Textract, S3, Fargate, Pinecone)
  - CI/CD with GitHub Actions

- 📈 **Monitoring**
  Prometheus + Grafana dashboards (latency, query hits, ingestion time).

---

## 🏗️ Architecture

```text
Frontend (React + Tailwind)
   │
   ▼
Backend API (FastAPI)
   ├── /ingest → PDF parser
   └── /query  → Hybrid retriever + LLM
         │
         ├─ Dense Retrieval (FAISS/Pinecone)
         ├─ Sparse Retrieval (BM25/Elastic)
         └─ Structured DB (Postgres: table rows)
   │
   ▼
Answer + Sources → UI
```

## 📂 Folder Structure

```text
contract-intelligence-portal/
├── backend/                     # FastAPI backend
│   ├── app/
│   │   ├── api/                 # API routes
│   │   │   ├── v1/
│   │   │   │   ├── ingest.py    # /ingest endpoint
│   │   │   │   ├── query.py     # /query endpoint
│   │   │   │   └── health.py    # health check
│   │   ├── core/                # Core configs
│   │   │   ├── config.py        # Settings (env vars, DB, API keys)
│   │   │   ├── logging.py       # Logging config
│   │   ├── services/            # Business logic
│   │   │   ├── parser.py        # PDF/Tables/Images parsing
│   │   │   ├── ocr.py           # Textract/Tesseract OCR
│   │   │   ├── embeddings.py    # OpenAI/SBERT embeddings
│   │   │   ├── retriever.py     # FAISS/Pinecone + BM25 retrieval
│   │   │   └── rag_chain.py     # LangChain/LlamaIndex orchestration
│   │   ├── models/              # Pydantic models
│   │   │   ├── ingest_models.py # Request/response schemas
│   │   │   ├── query_models.py
│   │   ├── db/                  # Database adapters
│   │   │   ├── postgres.py
│   │   │   └── vector_store.py
│   │   ├── utils/               # Helper functions
│   │   │   ├── chunking.py
│   │   │   └── file_utils.py
│   │   ├── main.py              # FastAPI entrypoint
│   │   └── __init__.py
│   ├── tests/                   # Pytest test cases
│   │   ├── test_ingest.py
│   │   ├── test_query.py
│   │   └── test_end2end.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── frontend/                    # React frontend
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   │   ├── ChatWindow.jsx   # Chat UI
│   │   │   ├── UploadBox.jsx    # File upload UI
│   │   │   ├── TableViewer.jsx  # Render extracted tables
│   │   │   └── ImageViewer.jsx  # Render extracted images
│   │   ├── pages/
│   │   │   ├── Home.jsx
│   │   │   └── Dashboard.jsx
│   │   ├── services/
│   │   │   └── api.js           # Axios API calls
│   │   ├── App.js
│   │   └── index.js
│   ├── package.json
│   └── Dockerfile
│
├── infra/                       # Infra & deployment
│   ├── docker-compose.yml       # Local multi-service dev
│   ├── k8s/                     # Kubernetes manifests
│   │   ├── backend-deployment.yaml
│   │   ├── backend-service.yaml
│   │   ├── frontend-deployment.yaml
│   │   ├── frontend-service.yaml
│   │   ├── postgres-statefulset.yaml
│   │   └── prometheus-grafana.yaml
│   ├── terraform/               # IaC for AWS
│   │   ├── main.tf
│   │   └── variables.tf
│   └── cdk/                     # AWS CDK infra
│       └── app.py
│
├── monitoring/                  # Observability
│   ├── prometheus.yml
│   └── grafana_dashboards/
│       └── rag_dashboard.json
│
├── scripts/                     # Utility scripts
│   ├── init_db.py
│   ├── load_embeddings.py
│   └── run_local.sh
│
├── docs/                        # Documentation
│   ├── architecture.png
│   ├── api_reference.md
│   └── roadmap.md
│
├── README.md
└── LICENSE
```

### Parsing Pipeline

- Text chunks → embeddings
- Table chunks → JSON + flattened text
- Image chunks → OCR + captions
- Metadata (doc_id, page, bbox, type) stored for provenance

### Query Flow

1. User asks a question
2. Hybrid retrieval pulls top-k chunks
3. LLM answers using context, citing tables/images/pages
4. Frontend displays answer + snippet/table/image

---

## 📦 Tech Stack

**Core**

- FastAPI (backend API)
- React + Tailwind (frontend)
- LangChain / LlamaIndex (RAG orchestration)
- SentenceTransformers / OpenAI embeddings
- FAISS / Pinecone (vector DB)
- BM25 (sparse retrieval)
- PostgreSQL (structured metadata, table rows)
- AWS Textract (OCR + table parsing)
- BLIP / Tesseract (image OCR + captioning)

**Infra**

- Docker + docker-compose
- Kubernetes (K8s)
- AWS S3 (document storage)
- AWS ECS/Fargate (deployment)
- AWS CDK / Terraform (IaC)
- GitHub Actions (CI/CD)

**Monitoring**

- Prometheus (metrics)
- Grafana (dashboards)

---

## ⚡ Quick Start (Local Dev)

### 1️⃣ Clone repo & install

```bash
git clone https://github.com/yourname/contract-intelligence-portal.git
cd contract-intelligence-portal/backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2️⃣ Run backend

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

### 3️⃣ Run frontend

```bash
cd ../frontend
npm install
npm start
```

### 4️⃣ Or with Docker

```bash
cd infra
docker-compose up --build
```

---

## 📂 API Endpoints

### Ingest

`POST /ingest/`
Upload a PDF/DOCX → parses text, tables, images, stores embeddings.

Response:

```json
{
  "doc_id": "123e4567",
  "filename": "contract.pdf",
  "pages": 12,
  "tables_extracted": 3,
  "images_extracted": 2
}
```

### Query

`POST /query/`
Ask a natural-language question with `doc_id`.

Request:

```json
{
  "doc_id": "123e4567",
  "question": "What is the initial response time for Severity-1?",
  "top_k": 6
}
```

Response:

```json
{
  "answer": "Severity-1 initial response is 5 minutes (working hours) / 30 minutes (non-working). Source: SLA Table, page 87",
  "sources": [{ "id": "123e4567_table_5", "page": 87, "type": "table" }]
}
```

---

## 🧪 Testing

```bash
pytest backend/app/tests
```

Includes:

- Ingestion tests (tables/images)
- Retrieval tests (known SLA queries)
- Golden-answer regression tests

---

## 📊 Monitoring

- Metrics: ingestion latency, embedding latency, retrieval recall, query latency
- Run:

```bash
docker-compose -f infra/monitoring.yml up
```

- View dashboards in Grafana → `http://localhost:3000`

---

## 🚀 Deployment

- **AWS ECS/Fargate**: containerized backend + React frontend
- **Kubernetes (K8s)**: scalable orchestration option
- **S3**: document storage
- **Textract**: OCR + tables
- **Pinecone/Milvus**: managed vector DB
- **Terraform/CDK**: reproducible infra
- **GitHub Actions**: CI/CD (tests → build → deploy)

---

## 📚 Sample Queries

- “Does this contract auto-renew?”
- “What’s the initial response time for Severity-1?”
- “Which reports can be exported from the system?”
- “What’s the penalty for downtime > 5 hours?”

---

## 📈 Business Impact

- ⏱️ Reduces **contract review time by \~80%**
- ⚖️ Flags **hidden risks automatically** (renewals, liability caps, SLA penalties)
- 📊 Generates **executive summaries** for partners/clients
- 🔍 Provides **auditable answers** (citations to exact clauses, tables, charts)

---

## 📌 Roadmap

- [ ] Fine-tune clause classifier (LayoutLMv3)
- [ ] Add diffing/version control (contract updates)
- [ ] Add role-based access control + PII redaction
- [ ] Deploy multimodal LLM for better chart/diagram Q\&A

---

## 👤 Author

Built by **Debjyoti Banerjee** — AI/ML Engineer (4+ years), **Tech Lead – Generative AI** at B4B Technologies LLC.

---

## 📝 License

MIT
