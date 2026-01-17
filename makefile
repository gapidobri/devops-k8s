deploy:
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
		-f loki-service.yaml \
