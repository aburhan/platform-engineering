variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "services" {
  description = "Service APIs to enable"
  type        = list(string)
  default = [
    "gkehub.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "trafficdirector.googleapis.com",
    "trafficdirector.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "multiclusteringress.googleapis.com",
    "dns.googleapis.com"]
}
# Define a map with cluster names and their respective zones
variable "clusters" {
  type = map(string)
  default = {
    "cluster-1" = "us-central1-a"
    "cluster-2" = "us-central1-b"
  }
}

variable "region" {
  description = "GCP Region"
  type        = string
  default = "us-central1"
}

variable "namespace_name" {
  type = string
  default = "store"
}
variable "app_name" {
  type = string
  default = "store"
}
variable "app_version" {
  type = string
  default = "v1"
}
variable "app_service_name"{
    type = string
  default = "store"
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "proxy_subnet_name" {
  description = "Name of the proxy subnet"
  type        = string
}

variable "proxy_subnet_cidr" {
  description = "CIDR range for the proxy subnet"
  type        = string
}


variable "mcs_name" {
  description = "Name for the multi-cluster service"
  type        = string
}

variable "mcs_target_proxy" {
  description = "Target proxy resource for MCS"
  type        = string
}

variable "mcg_name" {
  description = "Name for the multi-cluster gateway"
  type        = string
}

variable "url_map" {
  description = "URL map for the gateway"
  type        = string
}

variable "ssl_certificates" {
  description = "List of SSL certificate IDs"
  type        = list(string)
}

variable "pipeline_name" {
  description = "Name of the Cloud Deploy pipeline"
  type        = string
}

variable "pipeline_target_id" {
  description = "Target ID for the Cloud Deploy stage"
  type        = string
}

variable "pipeline_profile" {
  description = "Deployment profile for Cloud Deploy"
  type        = string
}

variable "membership_name" {
  description = "Name for the GKE Hub membership (fleet)"
  type        = string
}
