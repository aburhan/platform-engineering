output "cluster_info" {
  value = {
    name     = data.google_container_cluster.cluster1.name
    endpoint = data.google_container_cluster.cluster1.endpoint
    location = data.google_container_cluster.cluster1.location
    master_version = data.google_container_cluster.cluster1.master_version

  }
}