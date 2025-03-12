#!/bin/bash
kubectl apply --context ${CLUSTER_1_NAME} -f https://raw.githubusercontent.com/GoogleCloudPlatform/gke-networking-recipes/main/gateway/gke-gateway-controller/multi-cluster-gateway/store.yaml
kubectl apply --context ${CLUSTER_2_NAME}  -f https://raw.githubusercontent.com/GoogleCloudPlatform/gke-networking-recipes/main/gateway/gke-gateway-controller/multi-cluster-gateway/store.yaml

# --- envsubst approach ---

# Apply Service and ServiceExport
export SUFFIX="a"
envsubst < service_export.yaml | kubectl apply --context ${CLUSTER_1_NAME} -f 

export SUFFIX="b"
envsubst < service_export.yaml | kubectl apply --context ${CLUSTER_2_NAME} -f 

kubectl get serviceexports --context $CLUSTER_1_NAME --namespace store
kubectl get serviceexports --context $CLUSTER_2_NAME --namespace store

# Deploying the Gateway and HTTPRoute
kubectl apply --context ${CLUSTER_1_NAME} -f gateway.yaml
kubectl apply --context ${CLUSTER_1_NAME} -f route.yaml

kubectl describe gateways.gateway.networking.k8s.io external-http --context ${CLUSTER_1_NAME}  --namespace store