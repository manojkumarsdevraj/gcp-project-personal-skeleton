variable "region" {
  description = "GCP region identifier"
  type        = string
}

variable "zones" {
  description = "GCP zone identifier"
  type        = list
}

variable "project_id" {
  description = "Project ID"
  type        = string
}
