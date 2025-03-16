variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
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

variable "region" {
  description = "GCP region for the resources"
  type        = string
}
