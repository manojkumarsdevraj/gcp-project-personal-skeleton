resource "google_kms_key_ring" "terraform" {
  name     = "terraform"
  location = "global"
}

resource "google_kms_crypto_key" "terraform" {
  name     = "deploy"
  key_ring = google_kms_key_ring.terraform.self_link
}

# data "google_kms_secret" "tunnel-0" {
#   crypto_key = google_kms_crypto_key.terraform.self_link
#   ciphertext = "Base 64 secret"
# }


