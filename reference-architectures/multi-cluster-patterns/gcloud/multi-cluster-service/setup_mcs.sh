#!/bin/bash

# Enable Multi-Cluster Services
echo "Enabling Multi-Cluster Services..."
gcloud container fleet multi-cluster-services enable \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to enable Multi-Cluster Services."
  exit 1
fi

# Add IAM policy binding
echo "Adding IAM policy binding..."
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member "serviceAccount:$PROJECT_ID.svc.id.goog[gke-mcs/gke-mcs-importer]" \
    --role "roles/compute.networkViewer" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to add IAM policy binding."
  exit 1
fi

# Describe Multi-Cluster Services
echo "Describing Multi-Cluster Services..."
gcloud container fleet multi-cluster-services describe --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "Failed to describe Multi-Cluster Services."
  exit 1
fi

echo "Multi-Cluster Services setup complete."