
# Installation

### Traefik
```bash
helm install traefik --namespace traefik traefik/traefik --wait \
  --set ingressRoute.dashboard.enabled=true \
  --set ingressRoute.dashboard.matchRule='Host(`traefik.localhost`)' \
  --set ingressRoute.dashboard.entryPoints={web} \
  --set providers.kubernetesGateway.enabled=true \
  --set gateway.listeners.web.namespacePolicy.from=All
```

### Cert Manager
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.19.2/cert-manager.yaml
```

```bash
kubectl apply \
  -f observability-namespace.yaml \
  -f grafana-deployment.yaml \
  -f grafana-pvc.yaml \
  -f grafana-service.yaml \
  -f  
```