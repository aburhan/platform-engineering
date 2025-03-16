variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
variable "cluster_name" {
  description = "Name of the Standard GKE cluster"
  type        = string
}

variable "location" {
  description = "location for the GKE cluster"
  type        = string
}

variable "network_id" {
  description = "Network ID for the GKE cluster"
  type        = string
}

variable "enable_autopilot" {
  description = "Enable Autopilot"
  type = bool
  default = false
}
variable "gke_editon" {
  description = "GKE tier, STANDARD or ENTERPRISE"
  type = string
  default = "STANDARD"
}
