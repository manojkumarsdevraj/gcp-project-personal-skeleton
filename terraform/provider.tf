provider "google" {
  project = var.project_id
  region  = var.region
  version = "2.19"
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  version = "2.19"
}

# terraform {
#   required_version = "0.12.16"

#   backend "gcs" {
#     bucket = "REPLACE_ME"
#     prefix = "PROJECT_ID"
#   }
# }