provider "google" {
  credentials = file("../key.json")
  project = var.project_id
  region  = var.region[0]
}

provider "google-beta" {
  credentials = file("key.json")
  project = var.project_id
  region  = var.region[0]
}

terraform {
  //required_version = "0.14.7"

  backend "gcs" {
    bucket = "1180845-tfstate"
    prefix = "caramel-spot-326810"
  }
}
