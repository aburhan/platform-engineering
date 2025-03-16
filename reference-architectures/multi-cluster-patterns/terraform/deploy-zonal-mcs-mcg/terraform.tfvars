project_id         = "pe-multi-cluster-zonal14"

region             = "us-central1"

vpc_name           = "my-vpc"
proxy_subnet_name  = "my-proxy-subnet"
proxy_subnet_cidr  = "10.10.0.0/16"

mcs_name           = "my-mcs"
mcs_target_proxy   = "my-target-proxy"
mcg_name           = "my-mcg"
url_map            = "my-url-map"
ssl_certificates   = ["cert1", "cert2"]
pipeline_name      = "my-cd-pipeline"
pipeline_target_id = "my-target-id"
pipeline_profile   = "default"
membership_name    = "my-fleet-membership"
