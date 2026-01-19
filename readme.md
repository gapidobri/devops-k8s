# DevOps Kubernetes Deployment

This repository contains kubernetes configurations for deploying a simple to-do app written in Go.

The app can be deployed manually or with a Helm chart located in [./app/deployments/helm](./app/deployments/helm).

## Services
- Traefik
- App
- Postgres
- Alloy
- Loki
- Grafana

## Zero-downtime demo
### Rolling update


### Blue/green deployment


## Installation

### Traefik
```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update
kubectl create namespace traefik

helm install traefik --namespace traefik traefik/traefik --wait -f traefik-values.yaml
```

### Cert Manager
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.19.2/cert-manager.yaml
```

### App
#### Manual

Create namespace
```bash
kubectl create namespace app
```

Create a postgres password secret
```bash
kubectl -n app create secret generic postgres-secret \
  --from-literal=password=changeme
```

Install
```bash
kubectl apply \
    -f certificate.yaml \
    -f app-namespace-yaml \
    -f app-deployment.yaml \
    -f app-httproute.yaml \
    -f app-service.yaml \
    -f postgres-deployment.yaml \
    -f postgres-pvc.yaml \
    -f postgres-service.yaml \
```

#### Helm
```bash
kubectl create namespace app

helm install app --namespace app \
    --set app.replicas=3 \
    --set app.gateway.hosts={app.devops-k8s.gapi.me} \
    ./app/deployments/helm
```


### Observability
```bash
kubectl apply \
    -f observability-namespace.yaml \
    -f observability-clusterrole.yaml \
    -f observability-clusterrolebinding.yaml \
    -f observability-sa.yaml \
    -f alloy-config.yaml \
    -f alloy-deployment.yaml \
    -f grafana-config.yaml \
    -f grafana-deployment.yaml \
    -f grafana-httproute.yaml \
    -f grafana-pvc.yaml \
    -f grafana-service.yaml \
    -f loki-config.yaml \
    -f loki-deployment.yaml \
    -f loki-pvc.yaml \
    -f loki-service.yaml
```

## Setup for blue/green deployment

Create two deployments
```bash
kubectl apply \
    -f bluegreen/app-deployment-blue.yaml \
    -f bluegreen/app-deployment-green.yaml
```

Activate blue deployment
```bash
kubectl apply -f bluegreen/app-service-blue.yaml
```

Activate green deployment
```bash
kubectl apply -f bluegreen/app-service-green.yaml
```