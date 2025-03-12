#!/bin/bash

# Source the environment variable check function
source ./env_utils.sh

# Check environment variables
if ! check_env_vars; then
  exit 1
fi

# Cloud Deploy variables
PIPELINE_NAME="whereami-pipeline"
TARGET_1_NAME="gke-$CLUSTER_1_REGION"
TARGET_2_NAME="gke-$CLUSTER_2_REGION"
REGION="$CLUSTER_1_REGION" # Assuming both clusters are in the same region

# Git repository details (replace with your values)
GIT_REPO_URL="https://github.com/GoogleCloudPlatform/kubernetes-engine-samples.git"
GIT_REPO_DIR="kubernetes-engine-samples"
GIT_SOURCE_PATH="quickstarts/whereami/k8s"

# Create Cloud Deploy targets
echo "Creating Cloud Deploy target '$TARGET_1_NAME'..."
gcloud deploy targets create "$TARGET_1_NAME" \
    --gke-cluster="projects/$PROJECT_ID/locations/$CLUSTER_1_ZONE/clusters/$CLUSTER_1_NAME" \
    --location="$REGION" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
    echo "Failed to create target '$TARGET_1_NAME'."
    exit 1
fi

echo "Creating Cloud Deploy target '$TARGET_2_NAME'..."
gcloud deploy targets create "$TARGET_2_NAME" \
    --gke-cluster="projects/$PROJECT_ID/locations/$CLUSTER_2_ZONE/clusters/$CLUSTER_2_NAME" \
    --location="$REGION" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
    echo "Failed to create target '$TARGET_2_NAME'."
    exit 1
fi

# Create Cloud Deploy pipeline
echo "Creating Cloud Deploy pipeline '$PIPELINE_NAME'..."
gcloud deploy pipelines create "$PIPELINE_NAME" \
    --location="$REGION" \
    --source="$GIT_REPO_URL" \
    --repo="$GIT_REPO_DIR" \
    --dir="$GIT_SOURCE_PATH" \
    --project="$PROJECT_ID"

if [ $? -ne 0 ]; then
    echo "Failed to create pipeline '$PIPELINE_NAME'."
    exit 1
fi

echo "Cloud Deploy setup complete."