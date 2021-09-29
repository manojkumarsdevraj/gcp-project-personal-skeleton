resource "google_compute_instance_template" "instance_template" {
  name        = "appserver-template"
  description = "This template is used instances in mig."

  tags = ["templateinstances"]

  labels = {
    environment = "dev"
  }

  instance_description = "description assigned to instances"
  machine_type         = "e2-medium"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-9"
    auto_delete       = true
    boot              = true
    disk_size_gb      = "100"
    disk_type         = "pd-ssd"
    // backup the disk every day
    //resource_policies = [google_compute_resource_policy.daily_backup.id]
  }

  network_interface {
    subnetwork_project = var.project_id
    subnetwork         = var.subnet
  }
}