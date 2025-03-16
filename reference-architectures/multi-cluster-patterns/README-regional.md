# Deployment Instructions for 2 Regional Clusters

This configuration deploys:
- A VPC with a proxy subnet.
- **2 Regional GKE Clusters** (regional configuration spanning multiple zones).
- Multi-Cluster Service (MCS) for east-west traffic.
- Multi-Cluster Gateway (MCG) for north-south traffic.
- Fleet Registration for Anthos (GKE Hub).

## Prerequisites
- Terraform (v1.0+)
- Google Cloud SDK (gcloud)
- Required GCP APIs enabled (Compute Engine, Kubernetes Engine, Cloud Deploy, GKE Hub)

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd my-repo
   ```

2. **Configure Variables**

   Update `terraform/terraform.tfvars` for regional deployment. Example:
   ```hcl
   project_id               = "your-gcp-project-id"
   region                   = "us-central1"
   vpc_name                 = "my-vpc"
   proxy_subnet_name        = "my-proxy-subnet"
   proxy_subnet_cidr        = "10.10.0.0/16"
   regional_cluster1_name   = "my-regional-cluster-1"
   regional_cluster2_name   = "my-regional-cluster-2"
   mcs_name                 = "my-mcs"
   mcs_target_proxy         = "my-target-proxy"
   mcg_name                 = "my-mcg"
   url_map                  = "my-url-map"
   ssl_certificates         = ["cert1", "cert2"]
   pipeline_name            = "my-cd-pipeline"
   pipeline_target_id       = "my-target-id"
   pipeline_profile         = "default"
   membership_name          = "my-fleet-membership"
   ```

3. **Modify Root Module**

   In `terraform/main.tf`, instantiate two Standard (or dedicated regional) GKE modules configured for regional clusters.

4. **Initialize and Apply**

   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

5. **Deploy Applications**

   ```bash
   kubectl apply -f ../applications/app1/
   kubectl apply -f ../applications/app2/
   ```

