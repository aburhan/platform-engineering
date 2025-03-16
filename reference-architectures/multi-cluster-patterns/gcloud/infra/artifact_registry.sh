#!/bin/bash

# Artifact Registry variables
ARTIFACT_REGISTRY_NAME="my-artifact-registry" # Replace with your desired registry name
ARTIFACT_REGISTRY_LOCATION="$REGION" # Use the same region as the VPC, or another desired location
ARTIFACT_REGISTRY_FORMAT="docker" # Or "maven", "npm", "python", etc.

# Check if the registry already exists
if gcloud artifacts repositories describe "$ARTIFACT_REGISTRY_NAME" --location="$ARTIFACT_REGISTRY_LOCATION" --project="$PROJECT_ID" > /dev/null 2>&1; then
  echo "Artifact Registry '$ARTIFACT_REGISTRY_NAME' already exists in location '$ARTIFACT_REGISTRY_LOCATION'."
  exit 0
fi

# Create the Artifact Registry
echo "Creating Artifact Registry '$ARTIFACT_REGISTRY_NAME' in location '$ARTIFACT_REGISTRY_LOCATION'..."
gcloud artifacts repositories create "$ARTIFACT_REGISTRY_NAME" \
  --repository-format="$ARTIFACT_REGISTRY_FORMAT" \
  --location="$ARTIFACT_REGISTRY_LOCATION" \
  --project="$PROJECT_ID" \
  --description="My Artifact Registry"

if [ $? -eq 0 ]; then
  echo "Artifact Registry '$ARTIFACT_REGISTRY_NAME' created successfully."
else
  echo "Failed to create Artifact Registry '$ARTIFACT_REGISTRY_NAME'."
  exit 1
fi

exit 0