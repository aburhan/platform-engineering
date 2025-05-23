
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
# variables.tf

variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone_1" {
  type    = string
  default = "us-central1-a"
}

variable "zone_2" {
  type    = string
  default = "us-central1-b"
}

variable "zone_3" {
  type    = string
  default = "us-central1-c"
}

variable "vpc_name" {
  type    = string
  default = "gke-vpc"
}
