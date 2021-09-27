resource "google_compute_router" "router" {
  name    = "my-router"
  region  = var.region[0]
  network = var.network
}

resource "google_compute_address" "address" {
  count  = 2
  name   = "nat-manual-ip-${count.index}"
  region =  var.region[0]
}

resource "google_compute_router_nat" "nat_manual" {
  name   = "my-router-nat"
  router = "${google_compute_router.router.name}"
  region = var.region[0]

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.address.*.self_link

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  //subnetwork {
    //name                    = var.subnet
    //source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  //}
}