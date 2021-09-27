resource "google_storage_bucket" "backup-data" {
  name          = "backups-crocus"
  location      = "US"
  storage_class = "Nearline"

  uniform_bucket_level_access = "true"
  versioning {
    enabled = false
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

}

resource "google_storage_bucket" "store-images" {
  name          = "images-crocus"
  location      = "US"
  storage_class = "STANDARD"

  uniform_bucket_level_access = "true"
  versioning {
    enabled = false
  }
}