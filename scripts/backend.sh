cd backend
mkdir app tests
touch requirements.txt Dockerfile
cd app
mkdir api core services models db utils
touch main.py __init__.py
cd api
mkdir v1
cd v1
touch ingest.py query.py health.py
cd ..
cd ..
cd core
touch config.py logging.py
cd ..
cd services
touch parser.py ocr.py embeddings.py retriever.py rag_chain.py
cd ..
cd models
touch ingest_models.py query_models.py
cd ..
cd db
touch postgres.py vector_store.py
cd ..
cd utils
touch chunking.py file_utils.py
cd ..
cd ..
cd tests
touch test_ingest.py test_query.py test_end2end.py

echo "All backend folders created successfullly"

