cd contract-intelligence-portal
mkdir infra
cd infra
touch docker-compose.yml
mkdir k8s
cd k8s
touch backend-deployment.yaml backend-service.yaml frontend-deployment.yaml frontend-service.yaml postgres-statefulset.yaml prometheus-grafana.yaml
cd ..
mkdir terraform
cd terraform
touch main.tf variables.tf
