
data "google_client_config" "default" {}
data "google_container_cluster" "cluster1" {
  name     = var.cluster_name
  location = var.cluster_zone
}

/*
provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.cluster1.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster1.master_auth[0].cluster_ca_certificate)
  alias = var.cluster_name
}
resource "kubernetes_manifest" "namespace" {
  manifest = {
    apiVersion = "v1"
    kind       = "Namespace"
    metadata = {
      name = var.namespace_name
    }
  }
}
resource "kubernetes_manifest" "store_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = var.app_name
      namespace = var.namespace_name
    }
    spec = {
      replicas = 2
      selector = {
        matchLabels = {
          app     = var.app_name
          version = var.app_version
        }
      }
      template = {
        metadata = {
          labels = {
            app     = var.app_name
            version = var.app_version
          }
        }
        spec = {
          containers = [
            {
              name  = "whereami"
              image = "us-docker.pkg.dev/google-samples/containers/gke/whereami:v1.2.20"
              ports = [
                {
                  containerPort = 8080
                }
              ]
            }
          ]
        }
      }
    }
  }
}
resource "kubernetes_manifest" "service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = var.app_name
      namespace = var.namespace_name
    }
    spec = {
      selector = {
        app = var.app_name
      }
      ports = [
        {
          port       = 8080
          targetPort = 8080
        },
      ]
    }
  }
}
*/