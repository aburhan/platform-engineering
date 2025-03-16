

variable "namespace_name" {
  description = "Name of the Cloud Deploy pipeline"
  type        = string
}
variable "http_route_name" {
  
}
variable "http_route_parent_ref_name" {
  
}
variable "http_route_hostname" {
  
}
variable "gateway_config" {
  description = "Configuration for the Gateway resource"
  type = object({
    api_version         = string
    kind                = string
    name                = string
    gateway_class_name  = string
    listener_name       = string
    listener_protocol   = string
    listener_port       = number
  })
  /*
  default = {
    "default" = { # Add a key, as map(object) requires a key.
      api_version         = "gateway.networking.k8s.io/v1beta1"
      kind                = "Gateway"
      name                = "external-http"
      gateway_class_name  = "gke-l7-global-external-managed-mc"
      listener_name       = "http"
      listener_protocol   = "HTTP"
      listener_port       = 80
    }
  }*/
}
variable "http_route_rules" {
  description = "List of HTTPRoute rules"
  type = list(object({
    path_prefix     = string
    backend_name    = string
    backend_port    = number
  }))
  default = [
    {
      path_prefix     = "/west"
      backend_name    = "store-west-1"
      backend_port    = 8080
    },
    {
      path_prefix     = "/east"
      backend_name    = "store-east-1"
      backend_port    = 8080
    },
    {
      path_prefix     = "/" # Default rule
      backend_name    = "store"
      backend_port    = 8080
    }
  ]
}
