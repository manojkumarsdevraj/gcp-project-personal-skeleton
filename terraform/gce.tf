resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "g1-small"
  zone         = var.zones[1]

  boot_disk {
    initialize_params {
      image = "debian-9"
    }
    auto_delete = false
  }


  network_interface {
    subnetwork_project = var.project_id
    subnetwork         = var.subnet
    access_config {
    }
  }

  labels = {
    autoscaled = "false"
    monitored  = "true"
  }

  tags = ["bastioninstance"]
}