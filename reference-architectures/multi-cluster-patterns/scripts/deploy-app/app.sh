#!/bin/bash
gcloud container clusters get-credentials $CLUSTER_1_NAME --zone=$CLUSTER_1_ZONE --project=$PROJECT_ID
gcloud container clusters get-credentials $CLUSTER_2_NAME --zone=$CLUSTER_2_ZONE --project=$PROJECT_ID

# Set Kubernetes context
kubectl config rename-context gke_${PROJECT_ID}_${CLUSTER_1_ZONE}_${CLUSTER_1_NAME} ${CLUSTER_1_NAME}
kubectl config rename-context gke_${PROJECT_ID}_${CLUSTER_2_ZONE}_${CLUSTER_2_NAME} ${CLUSTER_2_NAME}


kubectl apply --context ${CLUSTER_1_NAME} -f https://raw.githubusercontent.com/GoogleCloudPlatform/gke-networking-recipes/main/gateway/gke-gateway-controller/multi-cluster-gateway/store.yaml
kubectl apply --context ${CLUSTER_2_NAME}  -f https://raw.githubusercontent.com/GoogleCloudPlatform/gke-networking-recipes/main/gateway/gke-gateway-controller/multi-cluster-gateway/store.yaml

# --- envsubst approach ---

# Apply Service and ServiceExport
export SUFFIX="a"
envsubst < ./deploy-app/service_export.yaml | kubectl apply --context ${CLUSTER_1_NAME} -f -

export SUFFIX="b"
envsubst < ./deploy-app/service_export.yaml | kubectl apply --context ${CLUSTER_2_NAME} -f -

kubectl get serviceexports --context $CLUSTER_1_NAME --namespace store
kubectl get serviceexports --context $CLUSTER_2_NAME --namespace store

# Deploying the Gateway and HTTPRoute
kubectl apply --context ${CLUSTER_1_NAME} -f ./deploy-app/gateway.yaml
kubectl apply --context ${CLUSTER_1_NAME} -f ./deploy-app/gateway_regional_internal.yaml
kubectl apply --context ${CLUSTER_1_NAME} -f ./deploy-app/http_route.yaml
kubectl apply --context ${CLUSTER_1_NAME} -f ./deploy-app/http_route_internal.yaml

kubectl describe gateways.gateway.networking.k8s.io external-http --context ${CLUSTER_1_NAME}  --namespace store
kubectl get events --field-selector involvedObject.kind=Gateway,involvedObject.name=internal-http --context=${CLUSTER_1_NAME} --namespace store
export VIP=$(kubectl get gateways.gateway.networking.k8s.io internal-http -o=jsonpath="{.status.addresses[0].value}" --context $CLUSTER_1_NAME --namespace store)
curl -H "host: store.example.internal" -H "env: canary" http://${VIP}