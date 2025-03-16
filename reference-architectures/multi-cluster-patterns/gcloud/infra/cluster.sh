#!/bin/bash

# GKE version (you can set this as an environment variable or define it here)
export VERSION="latest" # Or a specific version like "1.28.2-gke.100"

# Fleet name
export FLEET_NAME="my-fleet"

# Create fleet
echo "Creating fleet '$FLEET_NAME'..."
#gcloud container fleet create --display-name=$FLEET_NAME --project=$PROJECT_ID

if [ $? -ne 0 ]; then
  echo "Failed to create fleet."
  exit 1
fi

# 2 Zonal cluster setup
echo "Creating cluster '$CLUSTER_1_NAME' in zone '$CLUSTER_1_ZONE'..."
gcloud container clusters create "$CLUSTER_1_NAME" \
    --gateway-api=standard \
    --zone="$CLUSTER_1_ZONE" \
    --workload-pool="$PROJECT_ID.svc.id.goog" \
    --cluster-version="$VERSION" \
    --enable-fleet \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to create cluster '$CLUSTER_1_NAME'."
  exit 1
fi

echo "Creating cluster '$CLUSTER_2_NAME' in zone '$CLUSTER_2_ZONE'..."
gcloud container clusters create "$CLUSTER_2_NAME" \
    --gateway-api=standard \
    --zone="$CLUSTER_2_ZONE" \
    --workload-pool="$PROJECT_ID.svc.id.goog" \
    --cluster-version="$VERSION" \
    --enable-fleet \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to create cluster '$CLUSTER_2_NAME'."
  exit 1
fi

echo "Listing clusters..."
gcloud container clusters list

echo "Listing fleet memberships..."
gcloud container fleet memberships list --project="$PROJECT_ID"

echo "Getting credentials for '$CLUSTER_1_NAME'..."
gcloud container clusters get-credentials "$CLUSTER_1_NAME" --zone="$CLUSTER_1_ZONE" --project="$PROJECT_ID"

echo "Getting credentials for '$CLUSTER_2_NAME'..."
gcloud container clusters get-credentials "$CLUSTER_2_NAME" --zone="$CLUSTER_2_ZONE" --project="$PROJECT_ID"

# Set Kubernetes context
echo "Renaming Kubernetes context for '$CLUSTER_1_NAME'..."
kubectl config rename-context "gke_${PROJECT_ID}_${CLUSTER_1_ZONE}_${CLUSTER_1_NAME}" "$CLUSTER_1_NAME"

echo "Renaming Kubernetes context for '$CLUSTER_2_NAME'..."
kubectl config rename-context "gke_${PROJECT_ID}_${CLUSTER_2_ZONE}_${CLUSTER_2_NAME}" "$CLUSTER_2_NAME"

echo "Listing Kubernetes contexts..."
kubectl config list

echo "GKE cluster setup complete."