<!--

# Pull Request Standards
1. Branch names should include the ticket number.
1. The Pull Request title should begin with ticket number.
1. All gcloud commands should specify the `--project` option.
1. A minimum of one approver is required to merge.
1. After successful deployment, the pull request should be `squash and merge` to master.

-->

# TICKET_NUMBER: Description
## Purpose
Description of the request

Terraform Config files:
- kms.tf


## Deployment Steps
Detailed deployment instructions.

Resource badging:
![example-created-resource (created)](https://img.shields.io/badge/example--created--resource-created-green.svg)
![example-updated-resource (updated)](https://img.shields.io/badge/example--updated--resource-updated-yellow.svg)
![example-deleted-resource (deleted)](https://img.shields.io/badge/example--deleted--resource-deleted-red.svg)

Terraform

**Terraform state file is located on `PROJECT_NAME` project. You will need to be authenticated to run terraform command.
To setup your local authentication , setup your gcloud default auth `gcloud auth application-default login`**

Circle CI
1. Circle CI Deployment Steps
   1. Check `terraform plan` output matches the desired outcome
   1. Release 'Hold' once you have verified plan
   1. Check apply step has completed successfully

Terraform (Manual Steps)
1. Ensure 'master' is truth
   1. `git fetch`
   1. `git checkout origin/master`
   1. `terraform init`
   1. `terraform plan`

1. Check out the PR branch and preview
   1. `git checkout origin/git_branch`
   1. `terraform init`
   1. `terraform plan`

GDM
1. Ensure 'master' is truth
   1. `git fetch`
   1. `git checkout origin/master`
   1. `gcloud --project PROJECT_NAME deployment-manager deployments update DEPLOY_NAME --config CONFIG_FILE --preview`

1. Check out the PR branch and preview
   1. `git checkout origin/git_branch`
   1. `gcloud --project PROJECT_NAME deployment-manager deployments update DEPLOY_NAME --config CONFIG_FILE --preview`

## Validation Steps
Description of validation and detailed instructions.

## Rollback
Description of rollback and detailed instructions.

1. Roll back to master (if applicable)
   1. `git fetch`
   1. `git checkout origin/master`
   1. `terraform init`
   1. `terraform plan`
   1. `terraform apply`