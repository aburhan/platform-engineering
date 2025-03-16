# Deployment Instructions for 2 Zonal Clusters

This configuration deploys:
- A VPC with a proxy subnet.
- **2 Zonal GKE Clusters** (using the Standard cluster module with a zonal configuration).
- Multi-Cluster Service (MCS) for east-west traffic.
- Multi-Cluster Gateway (MCG) for north-south traffic.
- Fleet Registration for Anthos (GKE Hub).

## Prerequisites
- Terraform (v1.0+)
- Google Cloud SDK (gcloud)
- Required GCP APIs enabled (Compute Engine, Kubernetes Engine, Cloud Deploy, GKE Hub)

## Setup Instructions

1. **Clone the Repository**

   \`\`\`bash
   git clone <repository-url>
   cd my-repo
   \`\`\`

2. **Configure Variables**

   Update \`terraform/terraform.tfvars\` with your settings. For zonal clusters, include:
   - \`zone1\` and \`zone2\` variables (if your module supports a zonal configuration).
   - Separate cluster names for each cluster (e.g., \`cluster1_name\`, \`cluster2_name\`).

   Example:
   \`\`\`hcl
   project_id         = "your-gcp-project-id"
   region             = "us-central1"
   zone1              = "us-central1-a"
   zone2              = "us-central1-b"
   vpc_name           = "my-vpc"
   proxy_subnet_name  = "my-proxy-subnet"
   proxy_subnet_cidr  = "10.10.0.0/16"
   cluster1_name      = "my-zonal-cluster-1"
   cluster2_name      = "my-zonal-cluster-2"
   mcs_name           = "my-mcs"
   mcs_target_proxy   = "my-target-proxy"
   mcg_name           = "my-mcg"
   url_map            = "my-url-map"
   ssl_certificates   = ["cert1", "cert2"]
   pipeline_name      = "my-cd-pipeline"
   pipeline_target_id = "my-target-id"
   pipeline_profile   = "default"
   membership_name    = "my-fleet-membership"
   \`\`\`

3. **Modify Root Module**

   In \`terraform/main.tf\`, instantiate two Standard GKE modules with appropriate zonal configurations.

4. **Initialize and Apply**

   \`\`\`bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   \`\`\`

5. **Deploy Applications**

   \`\`\`bash
   kubectl apply -f ../applications/app1/
   kubectl apply -f ../applications/app2/
   \`\`\`

