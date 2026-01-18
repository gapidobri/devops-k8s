
# Installation

## Traefik
```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update
kubectl create namespace traefik

helm install traefik --namespace traefik traefik/traefik --wait \
  --set ingressRoute.dashboard.enabled=true \
  --set ingressRoute.dashboard.matchRule='Host(`traefik.localhost`)' \
  --set ingressRoute.dashboard.entryPoints={web} \
  --set providers.kubernetesGateway.enabled=true \
  --set gateway.listeners.web.namespacePolicy.from=All
```

## App
### Manual

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
  -f app-deployment.yaml \
  -f app-httproute.yaml \
  -f app-service.yaml \
  -f postgres-deployment.yaml \
  -f postgres-pvc.yaml \
  -f postgres-service.yaml
```

### Helm
```bash
kubectl create namespace todo-app

helm install todo-app --namespace todo-app \
  --set app.replicas=3 \
  --set app.gateway.hosts={app.devops.gapi} \
  ./app/deployments/helm
```


## Observability

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

# Setup for blue/green deployment

