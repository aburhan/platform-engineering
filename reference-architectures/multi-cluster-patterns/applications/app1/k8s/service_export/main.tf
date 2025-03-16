
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
resource "kubernetes_manifest" "namespace" {
  manifest = {
    apiVersion = "v1"
    kind       = "Namespace"
    metadata = {
      name = "store"
    }
  }
}
resource "kubernetes_manifest" "store_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = var.service_name
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

resource "kubernetes_manifest" "store_service_export" {
  manifest = {
    apiVersion = "net.gke.io/v1"
    kind       = "ServiceExport"
    metadata = {
      name      = var.app_name
      namespace = var.namespace_name
    }
  }
}

# Create Cluster specific service and service export
resource "kubernetes_manifest" "cluster_store_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = "${var.app_name}-${var.cluster_name}"
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

resource "kubernetes_manifest" "cluster_store_service_export" {
  manifest = {
    apiVersion = "net.gke.io/v1"
    kind       = "ServiceExport"
    metadata = {
      name      = "${var.app_name}-${var.cluster_name}"
      namespace = var.namespace_name
    }
  }
}