deploy:
	kubectl apply \
	  	-f certificate.yaml \
	  	-f app-deployment.yaml \
	  	-f app-httproute.yaml \
	  	-f app-service.yaml \
	  	-f postgres-deployment.yaml \
	  	-f postgres-pvc.yaml \
	  	-f postgres-service.yaml \
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

delete:
	kubectl delete \
	  	-f certificate.yaml \
	  	-f app-deployment.yaml \
	  	-f app-httproute.yaml \
	  	-f app-service.yaml \
	  	-f postgres-deployment.yaml \
	  	-f postgres-pvc.yaml \
	  	-f postgres-service.yaml \
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

deploy-bluegreen:
	kubectl apply \
	  	-f bluegreen/app-deployment-blue.yaml \
	  	-f bluegreen/app-deployment-green.yaml \
	  	-f bluegreen/app-service-blue.yaml

delete-bluegreen:
	kubectl delete \
		-f bluegreen/app-deployment-blue.yaml \
		-f bluegreen/app-deployment-green.yaml \
		-f bluegreen/app-service-blue.yaml \
		-f bluegreen/app-service-green.yaml

switch-blue:
	kubectl apply -f bluegreen/app-service-blue.yaml

switch-green:
	kubectl apply -f bluegreen/app-service-green.yaml