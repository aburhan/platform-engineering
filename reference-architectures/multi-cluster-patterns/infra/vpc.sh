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

# Create default firewall rules (allow SSH, ICMP, and internal)
echo "Creating default firewall rules..."

# Allow SSH
gcloud compute firewall-rules create default-allow-ssh \
    --allow tcp:22 \
    --source-ranges 0.0.0.0/0 \
    --target-tags ssh \
    --network default \
    --project="$PROJECT_ID"

# Allow ICMP
gcloud compute firewall-rules create default-allow-icmp \
    --allow icmp \
    --source-ranges 0.0.0.0/0 \
    --network default \
    --project="$PROJECT_ID"

# Allow internal traffic
gcloud compute firewall-rules create default-allow-internal \
    --allow tcp:0-65535,udp:0-65535,icmp \
    --source-ranges 10.128.0.0/9 \
    --network default \
    --project="$PROJECT_ID"

if [ $? -eq 0 ]; then
  echo "Default firewall rules created successfully."
else
  echo "Failed to create default firewall rules."
  exit 1
fi

echo "Default VPC and firewall rules setup complete."

# example to show how to set the default network.
gcloud config set compute/network default