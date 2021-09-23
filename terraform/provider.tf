provider "google" {
  credentials = file("key.json")
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

terraform {
  //required_version = "0.14.7"

  backend "gcs" {
    bucket = "1180845-tfstate"
    prefix = "caramel-spot-326810"
  }
}
