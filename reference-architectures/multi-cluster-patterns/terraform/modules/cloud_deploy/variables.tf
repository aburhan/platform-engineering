variable "pipeline_name" {
  description = "Name of the Cloud Deploy pipeline"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for Cloud Deploy"
  type        = string
}

variable "target_id" {
  description = "Target ID for the deployment stage"
  type        = string
}

variable "profile" {
  description = "Deployment profile"
  type        = string
}
