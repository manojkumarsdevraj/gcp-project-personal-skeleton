variable "region" {
  description = "GCP region identifier"
  type        = list
}

variable "zones" {
 description = "GCP zone identifier"
 type        = list
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "subnet" {
  type = string
}

variable "network" {
 description = "GCP private Network"
 type        = string
}

//variable "cluster_secondary_range_name" {
  //description = "Cluster secondary CIDR range name(Pod CIDR)"
  //type        = list
//}

//variable "services_secondary_range_name" {
  //description = "Cluster secondary CIDR range name(Services CIDR)"
  //type        = list
//}

