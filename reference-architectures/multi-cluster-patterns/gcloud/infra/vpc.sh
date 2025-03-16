#!/bin/bash


# Create the default VPC network
echo "Creating default VPC network in project: $PROJECT_ID, region: $REGION..."
gcloud compute networks create default --subnet-mode=auto --project="$PROJECT_ID" --bgp-routing-mode=regional

# ... (rest of your script)
if [ $? -eq 0 ]; then
  echo "Default VPC network 'default' created successfully."
else
  echo "Failed to create default VPC network."
  exit 1
fi

# Create the default VPC network
echo "Creating proxy subnet: $PROJECT_ID, region: $REGION..."
gcloud compute networks subnets create proxy-subnet \
    --purpose=REGIONAL_MANAGED_PROXY \
    --role=ACTIVE \
    --region=$CLUSTER_1_REGION \
    --network=default \
    --range=10.0.0.0/23
    --project=$PROJECT_ID