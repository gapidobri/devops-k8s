
# Installation

### Traefik
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

### App
```bash
helm install todo-app --namespace todo-app
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