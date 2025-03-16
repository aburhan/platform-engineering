output "gke_standard_cluster_name" {
  value = google_container_cluster.default
}
output "cluster_id" {
  description = "The ID of the GKE cluster."
  value       = google_container_cluster.default.id
}
output "endpoint" {
  value = google_container_cluster.default.endpoint
}

output "master_auth" {
  value = google_container_cluster.default.master_auth
}
