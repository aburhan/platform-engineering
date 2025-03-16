terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.25.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7"
    }
  }

  provider_meta "google" {
    module_name = "cloud-solutions/platform-engineering-multipattern-zonal-mcs-mcg-v1"
  }
}
provider "google" {
  project = var.project_id
  region = var.region
}


