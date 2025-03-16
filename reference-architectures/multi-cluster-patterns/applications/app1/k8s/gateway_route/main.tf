resource "kubernetes_manifest" "external_http_gateway" {
  manifest = {
    apiVersion = var.gateway_config.api_version
    kind       = var.gateway_config.kind
    metadata = {
      name      = var.gateway_config.name
      namespace = var.namespace_name
    }
    spec = {
      gatewayClassName = var.gateway_config.gateway_class_name
      listeners = [
        {
          name     = var.gateway_config.listener_name
          protocol = var.gateway_config.listener_protocol
          port     = 80
          allowedRoutes = {
            kinds = [
              {
                kind = "HTTPRoute"
              }
            ]
          }
        }
      ]
    }
  }
}
resource "kubernetes_manifest" "public_store_http_route" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1beta1"
    kind       = "HTTPRoute"
    metadata = {
      name      = var.http_route_name
      namespace = var.namespace_name
      labels = {
        gateway = var.http_route_parent_ref_name
      }
    }
    spec = {
      hostnames = [
        var.http_route_hostname
      ]
      parentRefs = [
        {
          name = var.http_route_parent_ref_name
        }
      ]
      rules = [
        for rule in var.http_route_rules : {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = rule.path_prefix
              }
            }
          ]
          backendRefs = [
            {
              group = "net.gke.io"
              kind  = "ServiceImport"
              name  = rule.backend_name
              port  = rule.backend_port
            }
          ]
        }
      ]
    }
  }
}