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
 
  lifecycle {
    ignore_changes = [attached_disk]
  }
  
  metadata = {
    startup-script-url = "https://storage.googleapis.com/rs-gce-instances-scripts-master/linux/startup_scripts/rackspace_gcp_sysprep_v1.sh"
    install-stackdriver-agent = "true"
    install-stackdriver-logging = "true"
    install-default-packages = "true"
    //custom-startup-script-url = "https://storage.googleapis.com/bucket/path/to/script.sh"
  }
}

resource "google_compute_disk" "tmp-disk-data" {
  name = "tmp-disk-data"
  type = "pd-ssd"
  zone = var.zones[1]
  size = "200"
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "tmp-disk-data_attachment" {
  disk     = google_compute_disk.tmp-disk-data.id
  instance = google_compute_instance.bastion.id
}
