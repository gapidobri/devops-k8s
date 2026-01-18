deploy-bluegreen:
	kubectl apply \
		-f bluegreen/app-deployment-blue.yaml \
		-f bluegreen/app-deployment-green.yaml

switch-blue:
	kubectl apply -f bluegreen/app-service-blue.yaml

switch-green:
	kubectl apply -f bluegreen/app-service-green.yaml