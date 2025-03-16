
resource "google_project_service" "enable_services" {
  for_each               = toset(var.services)
  project                = var.project_id
  service                = each.value
  disable_on_destroy     = false
  disable_dependent_services = false
}

resource "time_sleep" "wait_for_services" {
  depends_on    = [google_project_service.enable_services]
  create_duration = "120s"
}

module "vpc" {
  source            = "../modules/vpc"
  vpc_name          = var.vpc_name
  project_id        = var.project_id
  proxy_subnet_name = var.proxy_subnet_name
  proxy_subnet_cidr = var.proxy_subnet_cidr
  region            = var.region
  depends_on        = [time_sleep.wait_for_services]
}

data "google_client_config" "default" {}

module "gke_clusters" {
  source     = "../modules/gke/standard"
  for_each   = var.clusters
  project_id = var.project_id
  cluster_name  = each.key
  location      = each.value
  network_id    = module.vpc.vpc_id
}
module "deploy_apps" {
  for_each       = var.clusters
  source         = "../modules/k8s/demo_app"
  app_name       = var.app_name
  app_version    = var.app_version
  namespace_name = var.namespace_name
  cluster_name   = each.key
  cluster_zone = each.value
}
/*
data "google_container_cluster" "gke_clusters" {
  for_each = module.gke_clusters
  name     = each.value.cluster_name
  location = each.value.location
}

provider "kubernetes" {
  alias                  = "cluster1"
  host                   = "https://${data.google_container_cluster.gke_clusters["cluster1"].endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_clusters["cluster1"].master_auth[0].cluster_ca_certificate)
}

provider "kubernetes" {
  alias                  = "cluster2"
  host                   = "https://${data.google_container_cluster.gke_clusters["cluster2"].endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_clusters["cluster2"].master_auth[0].cluster_ca_certificate)
}

module "deploy_apps" {
  source         = "../modules/k8s/demo_app"
  for_each       = data.google_container_cluster.gke_clusters
  app_name       = var.app_name
  app_version    = var.app_version
  namespace_name = var.namespace_name
  cluster_name   = each.value.name
  providers = {
    kubernetes = data
  }
}

/*
module "service_exports" {
  source         = "../modules/k8s/service_export"
  for_each       = data.google_container_cluster.gke_clusters
  cluster_name   = each.value.name
  service_name   = var.app_service_name
  app_name       = var.app_name
  namespace_name = var.namespace_name
  providers = {
    kubernetes = kubernetes[each.key]
  }
}

module "multi_cluster_service" {
  source     = "../modules/multi_cluster_service"
  project_id = var.project_id
  depends_on = [data.google_container_cluster.gke_clusters]
}

module "multi_cluster_gateway" {
  source     = "../modules/multi_cluster_gateway"
  project_id = var.project_id
  region     = var.region
  membership = var.cluster_names[1] # Assuming cluster2 is the membership cluster
  depends_on = [data.google_container_cluster.gke_clusters]
}


module "gateway_and_route" {
  source = "../modules/k8s/gateway_route"

  namespace_name             = var.namespace_name
  http_route_name            = "public-${var.app_name}-route"
  http_route_parent_ref_name = "external-http"
  http_route_hostname        = "${var.app_name}.example.com"
  gateway_config = {
      api_version          = "gateway.networking.k8s.io/v1beta1"
      kind                 = "Gateway"
      name                 = "external-http"
      gateway_class_name   = "gke-l7-global-external-managed-mc"
      listener_name        = "http"
      listener_protocol    = "HTTP"
      listener_port        = 80
  }
  http_route_rules = [
    {
      path_prefix  = "/${var.cluster1_name}"
      backend_name = "${var.app_name}-${var.cluster1_name}"
      backend_port = 8080
    },
    {
      path_prefix  = "/${var.cluster2_name}"
      backend_name = "${var.app_name}-${var.cluster2_name}"
      backend_port = 8080
    },
    {
      path_prefix  = "/"
      backend_name = var.app_name
      backend_port = 8080
    }
  ]
  providers = {
    kubernetes = kubernetes.cluster2
  }
  depends_on = [ data.google_container_cluster.cluster2 ]
}
*/
