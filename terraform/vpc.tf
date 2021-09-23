resource "google_compute_network" "Crocus-Shared-VPC" {
  name = "mgcp-1180845-svpc"
  auto_create_subnetworks = false
}

resource "google_compute_network" "Social-Media-App" {
  name = "mgcp-1180845-sma"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "GKE-Cluster-Services" {
  name = "sma-subnet-services"
  ip_cidr_range = "10.128.0.0/18"
  region = var.region[1]
  network = "mgcp-1180845-svpc"
}

resource "google_compute_subnetwork" "GKE-Cluster-Pods" {
  name = "sma-subnet-pods"
  ip_cidr_range = "10.128.128.0/17"
  region = var.region[1]
  network = "mgcp-1180845-svpc"
}

resource "google_compute_subnetwork" "GKE-Cluster-Nodes" {
  name = "sma-subnet-nodes"
  ip_cidr_range = "10.128.64.0/18"
  region = var.region[0]
  network = "mgcp-1180845-sma"
}

resource "google_compute_subnetwork" "Other-services" {
  name = "sma-subnet-misc"
  ip_cidr_range = "10.129.0.0/16"
  region = var.region[0]
  network = "mgcp-1180845-sma"
}
