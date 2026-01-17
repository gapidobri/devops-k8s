deploy:
	kubectl apply \
		-f grafana-deployment.yaml \
		-f grafana-httproute.yaml \
		-f grafana-pvc.yaml \
		-f grafana-service.yaml \
		-f loki-config.yaml \
		-f loki-deployment.yaml \
		-f loki-pvc.yaml \
		-f loki-service.yaml \
		-f observability-namespace.yaml
