deploy-postgres:
	kubectl apply \
	  	-f postgres-deployment.yaml \
	  	-f postgres-pvc.yaml \
	  	-f postgres-service.yaml

delete-postgres:
	kubectl delete \
	  	-f postgres-deployment.yaml \
	  	-f postgres-pvc.yaml \
	  	-f postgres-service.yaml

deploy-app:
	kubectl apply \
	  	-f app-deployment.yaml \
	  	-f app-httproute.yaml \
	  	-f app-service.yaml \
	  	-f app-certificate.yaml \

delete-app:
	kubectl delete \
		-f app-deployment.yaml \
		-f app-httproute.yaml \
		-f app-service.yaml \
		-f app-certificate.yaml \

deploy-observability:
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
		-f grafana-certificate.yaml \
		-f loki-config.yaml \
		-f loki-deployment.yaml \
		-f loki-pvc.yaml \
		-f loki-service.yaml

delete-observability:
	kubectl delete \
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

deploy-bluegreen:
	kubectl apply \
	  	-f app-httproute.yaml \
	  	-f bluegreen/app-deployment-blue.yaml \
	  	-f bluegreen/app-deployment-green.yaml \
	  	-f bluegreen/app-service-blue.yaml

delete-bluegreen:
	kubectl delete \
	  	-f app-httproute.yaml \
		-f bluegreen/app-deployment-blue.yaml \
		-f bluegreen/app-deployment-green.yaml \
		-f bluegreen/app-service-blue.yaml \
		-f bluegreen/app-service-green.yaml

switch-blue:
	kubectl apply -f bluegreen/app-service-blue.yaml

switch-green:
	kubectl apply -f bluegreen/app-service-green.yaml