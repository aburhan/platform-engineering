#!/bin/bash

# env_utils.sh

check_env_vars() {
  if [[ -z "$PROJECT_ID" ]]; then
    echo "Error: PROJECT_ID environment variable is not set."
    echo "Please set your project ID using 'export PROJECT_ID=YOUR_PROJECT_ID'."
    return 1
  fi

  if [[ -z "$CLOUDSDK_COMPUTE_REGION" ]]; then
    echo "Warning: REGION environment variable is not set. Using default region."
    REGION="us-central1"
    gcloud config set compute/region $REGION
  fi

  if [[ -z "$CLUSTER_1_ZONE" ]]; then
    echo "Error: CLUSTER_1_ZONE environment variable is not set."
    echo "Please set your cluster 1 zone using 'export CLUSTER_1_ZONE=us-west1-a'."
    return 1
  fi

  if [[ -z "$CLUSTER_2_ZONE" ]]; then
    echo "Error: CLUSTER_2_ZONE environment variable is not set."
    echo "Please set your cluster 2 zone using 'export CLUSTER_2_ZONE=us-west1-b'."
    return 1
  fi

  if [[ -z "$CLUSTER_1_REGION" ]]; then
    echo "Error: CLUSTER_1_REGION environment variable is not set."
    echo "Please set your cluster 1 region using 'export CLUSTER_1_REGION=us-west1'."
    return 1
  fi

  if [[ -z "$CLUSTER_2_REGION" ]]; then
    echo "Error: CLUSTER_2_REGION environment variable is not set."
    echo "Please set your cluster 2 region using 'export CLUSTER_2_REGION=us-west1'."
    return 1
  fi

  if [[ -z "$CLUSTER_1_NAME" ]]; then
    export CLUSTER_1_NAME="gke-$CLUSTER_1_REGION"
  fi

  if [[ -z "$CLUSTER_2_NAME" ]]; then
    export CLUSTER_2_NAME="gke-$CLUSTER_2_REGION"
  fi

  return 0
}
