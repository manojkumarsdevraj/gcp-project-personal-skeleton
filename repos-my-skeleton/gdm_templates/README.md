Terraform Customer's project skeleton repository
======================================

This repository contains a skeleton of a project repository which contains the Terraform templates and GCE configuration.

If you are building out a new environment in terraform please review the [standards](standards.md) guide before starting the build.

Usage instructions
------------------

1. Replace this file with [README.template.md](README.template.md) and update its content.

```
$ rm standards.md
$ mv README.template.md README.md
```

There is some prework that needs to be done to enable the Terraform Pipeline for this project:

1. Replace PROJECT_NAME with correct project id
1. Enable Secret Manager, Cloud Storage and Cloud Storage JSON APIs for the Shared VPC
    `gcloud --project PROJECT_NAME services enable storage-component.googleapis.com storage-api.googleapis.com compute.googleapis.com secretmanager.googleapis.com`
1. Create a bucket in the EU region in the format 000000-tfstate where 000000 is the customer account number. Can be found in the README of all new Github repositories.
    ```
    gsutil mb -c standard -l eu -p PROJECT_NAME gs://000000-tfstate
    gsutil versioning set on gs://000000-tfstate
    ```
1. Amend the provider.tf to use the new bucket. Each project has it is own tfstate file so the prefix will correspond to project_id
1. Create a service account and its key in the Shared VPC Project and assign it Owner and Storage Admin role on all projects managed by Terraform
    ```
    gcloud --project PROJECT_NAME iam service-accounts create ci-sva --display-name "CircleCI Service Account"

    gcloud --project PROJECT_NAME iam service-accounts keys create --iam-account ci-sva@PROJECT_NAME.iam.gserviceaccount.com key.json
    
    gcloud --project PROJECT_NAME secrets create circleci-key --data-file key.json --replication-policy automatic

    cat key.json | base64 --wrap=0 && echo

    If using a Mac: cat key.json | base64 && echo
    ```


1. In CircleCI, create these environment variables:
    - GCLOUD_SERVICE_KEY="base64 of the key"
    - GOOGLE_APPLICATION_CREDENTIALS=/tmp/gcloud-service-key.json
1. Amend the tfvars file with the correct values.
1. Delete the kms.tf file if this project is not a Shared VPC Project
1. Fix the chmod errors with the scripts by running:
    ```
    cd bin
    git update-index --chmod=+x apply.sh
    git update-index --chmod=+x plan.sh
    git update-index --chmod=+x lint.sh
    ```

All secrets/sensitive values must be encrypted with Cloud KMS or Secret Manager as show in the example below.
Create secrets using this command:
```
echo "P4SSW0RD" | gcloud --project PROJECT_NAME kms encrypt --key deploy --keyring terraform --location global --plaintext-file - --ciphertext-file - | base64 --wrap=0 && echo

If using a Mac command is: echo "P4SSW0RD" | gcloud --project PROJECT_NAME kms encrypt --key deploy --keyring terraform --location global --plaintext-file - --ciphertext-file - | base64  && echo
```

For certificates:

```
gcloud --project maha4472-shared-vpc kms encrypt --key deploy --keyring terraform --location global --plaintext-file cert.key --ciphertext-file expiredborgkey.enc

```

Use it in terraform:

```
resource "google_compute_ssl_certificate" "certificate" {
  name        = "somecert"
  description = "*.borg.dev Wildcard Certificate"
  private_key = chomp(data.google_kms_secret.expiredborgkey.plaintext)
  certificate = file("secrets/expiredborg.crt")

  lifecycle {
    create_before_destroy = true
  }
}

data "google_kms_secret" "expiredborgkey" {
  crypto_key = "projects/maha4472-shared-vpc/locations/global/keyRings/terraform/cryptoKeys/deploy"
  ciphertext = filebase64("secrets/expiredborgkey.enc")
}
```
