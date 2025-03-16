resource "google_gke_hub_feature" "feature" {
  name = "multiclusteringress"
  location = "global"
  spec {
    multiclusteringress {
      config_membership = "projects/${var.project_id}/locations/${var.region}/memberships/${var.membership}"
    }
  }
}