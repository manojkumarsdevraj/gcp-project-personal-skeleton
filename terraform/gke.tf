resource "google_container_cluster" "gke_cluster" {
  provider           = google-beta
  name               = "cluster-sma-new"
  location           = var.region[0]
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  network            = var.network
  subnetwork         = var.subnet
  node_locations     = [var.zones[0], var.zones[1], var.zones[2]]
  
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = ""
    services_ipv4_cidr_block = ""
  }

  cluster_autoscaling {
    enabled = "false"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = "false"
    }
    http_load_balancing {
      disabled = "false"
    }
    network_policy_config {
      disabled = "false"
    }
    istio_config {
      disabled = "true"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "120.136.32.106/32"
      display_name = "manoj-rackspace"
    }
  }
  network_policy {
    enabled = "true"
  }
  initial_node_count       = 1
  remove_default_node_pool = true
}


resource "google_container_node_pool" "cluster1_nodes" {
  name       = "crocus-nodepool-test"
  location   = var.region[0]
  cluster    = "${google_container_cluster.gke_cluster.name}"
  node_count = 1

  node_config {
    preemptible     = false
    machine_type    = "n1-standard-2"
    disk_size_gb    = 20
    disk_type       = "pd-ssd"
    image_type      = "COS"
    tags            = ["prod-v1"]
    shielded_instance_config {
      enable_secure_boot = "true"
    }
  } 
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }
  management {
    auto_repair  = "true"
    auto_upgrade =  "true"
  }
}
