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
	  	-f app-service.yaml

delete-app:
	kubectl delete \
		-f app-deployment.yaml \
		-f app-httproute.yaml \
		-f app-service.yaml

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