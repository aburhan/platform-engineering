/**
* Copyright 2025 Google LLC
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
data "google_client_config" "default" {}
resource "google_container_cluster" "default" {
  name               = var.cluster_name
  location           = var.location
  enable_autopilot   = var.enable_autopilot
  initial_node_count = 3
  enterprise_config {
    desired_tier = var.gke_editon
  }
  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  fleet {
    project = var.project_id
  }
  network             = var.network_id
  deletion_protection = false
}