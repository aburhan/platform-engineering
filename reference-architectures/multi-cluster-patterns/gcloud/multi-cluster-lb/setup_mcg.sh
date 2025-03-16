#!/bin/bash

# Get project number
PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")

if [ -z "$PROJECT_NUMBER" ]; then
  echo "Error: Failed to retrieve project number."
  exit 1
fi

# Enable Fleet Ingress
echo "Enabling Fleet Ingress..."
gcloud container fleet ingress enable \
    --config-membership="projects/$PROJECT_ID/locations/$CLUSTER_1_REGION/memberships/$CLUSTER_1_NAME" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to enable Fleet Ingress."
  exit 1
fi

# Add IAM policy binding
echo "Adding IAM policy binding..."
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member "serviceAccount:service-$PROJECT_NUMBER@gcp-sa-multiclusteringress.iam.gserviceaccount.com" \
    --role "roles/container.admin" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to add IAM policy binding."
  exit 1
fi

# Describe Fleet Ingress
echo "Describing Fleet Ingress..."
gcloud container fleet ingress describe --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to describe Fleet Ingress."
  exit 1
fi

# Get GatewayClasses
echo "Getting GatewayClasses from $CLUSTER_1_NAME..."
kubectl get gatewayclasses --context="$CLUSTER_1_NAME"

if [ $? -ne 0 ]; then
  echo "Failed to get GatewayClasses."
  exit 1
fi

echo "Fleet Ingress setup complete."