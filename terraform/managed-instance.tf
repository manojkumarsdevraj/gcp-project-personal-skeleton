//resource "google_compute_health_check" "autohealing" {
  //name                = "autohealing-health-check"
  //check_interval_sec  = 5
  //timeout_sec         = 5
  //healthy_threshold   = 2
  //unhealthy_threshold = 10

  //http_health_check {
    //request_path = "/"
    //port         = "80"
  //}
//}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "instance-groupmanager"
  version {
    instance_template  = google_compute_instance_template.instance_template.id
  }
  base_instance_name = "instance-group-manager"
  project            = var.project_id
  zone               = var.zones[0]
  target_size        = "1"
  named_port {
    name = "http"
    port = 80
  }
  //auto_healing_policies {
    //health_check      = google_compute_health_check.autohealing.id
    //initial_delay_sec = 300
  //}
}

