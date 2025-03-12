#!/bin/bash

# Main deployment script

# --- Source environment variables ---
source ./infra/env_utils.sh

# Check environment variables
if ! check_env_vars; then
  exit 1
fi

# --- Enable services ---
echo "Enabling required services..."
source ./infra/services.sh

if [ $? -ne 0 ]; then
  echo "Failed to enable services."
  exit 1
fi

# --- Create VPC ---
echo "Creating VPC..."
source ./infra/vpc.sh

if [ $? -ne 0 ]; then
  echo "Failed to create VPC."
  exit 1
fi

# --- Create clusters ---
echo "Creating clusters..."
source ./infra/cluster.sh

if [ $? -ne 0 ]; then
  echo "Failed to create clusters."
  exit 1
fi

# --- Setup Multi-Cluster Services (MCS) ---
echo "Setting up Multi-Cluster Services..."
source ./multicluster_service/setup_mcs.sh

if [ $? -ne 0 ]; then
  echo "Failed to setup MCS."
  exit 1
fi

# --- Setup Multi-Cluster Gateway (MCG) ---
echo "Setting up Multi-Cluster Gateway..."
source ./loadbalancing/setup_mcg.sh

if [ $? -ne 0 ]; then
  echo "Failed to setup MCG."
  exit 1
fi

echo "Deployment complete."