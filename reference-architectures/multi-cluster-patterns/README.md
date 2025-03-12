# Google Cloud Infrastructure Deployment Script

This script automates the deployment of a Google Cloud infrastructure, including:

*   Enabling necessary Google Cloud services.
*   Creating a Virtual Private Cloud (VPC) network.
*   Provisioning Google Kubernetes Engine (GKE) clusters.
*   Setting up Multi-Cluster Services (MCS).
*   Enabling and configuring Multi-Cluster Gateway (MCG).

## Prerequisites

Before running the script, ensure you have the following:

*   A Google Cloud Platform (GCP) account.
*   The Google Cloud SDK installed and configured.
*   Necessary IAM permissions for creating and managing GCP resources.
*   The required APIs enabled in your project (listed in `infra/services.sh`).

## Directory Structure

├── deploy-app
│   ├── app.sh
│   ├── gateway.yaml
│   ├── http_route.yaml
│   └── service_export.yaml
├── deploy.sh
├── infra
│   ├── artifact_registry.sh
│   ├── cluster.sh
│   ├── services.sh
│   ├── utils.sh
│   └── vpc.sh
├── multi-cluster-lb
│   └── setup_mcg.sh
├── multi-cluster-service
│   └── setup_mcs.sh
├── pipeline
│   ├── cloud_deploy.sh
│   ├── delievery_pipeline.yaml
│   ├── service_account.sh
│   └── skaffold.yaml
└── README.md

## Environment Variables

The script relies on the following environment variables:

*   `PROJECT_ID`: Your Google Cloud project ID.
*   `CLUSTER_1_ZONE`: The zone for the first GKE cluster (e.g., `us-west1-a`).
*   `CLUSTER_2_ZONE`: The zone for the second GKE cluster (e.g., `us-west1-b`).
*   `CLUSTER_1_REGION`: The region for the first GKE cluster (e.g., `us-west1`).
*   `CLUSTER_2_REGION`: The region for the second GKE cluster (e.g., `us-west1`).
*   `CLUSTER_1_NAME`: Name of the first GKE cluster, if not set it will be `gke-a`.
*   `CLUSTER_2_NAME`: Name of the second GKE cluster, if not set it will be `gke-b`.

## Usage

1.  Set environment variables and make scripts executable.

```sh
export PROJECT_ID=your-project-id
export CLUSTER_1_ZONE=us-west1-a
export CLUSTER_2_ZONE=us-west1-b
export CLUSTER_1_REGION=us-west1
export CLUSTER_2_REGION=us-west1
export CLUSTER_1_NAME=my-cluster-1
export CLUSTER_2_NAME=my-cluster-2

chmod +x deploy.sh infra/*.sh multi-cluster-service/*.sh \
         deploy-app/*.sh multi-cluster-lb/*.sh pipeline/*.sh

```

1.  Run the deploy script script:

```sh

./deploy.sh

```

### Script Breakdown

*   deploy.sh: The main script that orchestrates the deployment.

The deploy script does the following script:

*   Handles environment variable checks and setup.
*   Enables required Google Cloud services.
*   Creates the VPC network and firewall rules.
*   Provisions the GKE clusters.
*   Configures Multi-Cluster Services.
*   Enables and sets up Multi-Cluster Gateway.
*   Creates a Cloud Deploy pipeline
*   Deploy a sample app
