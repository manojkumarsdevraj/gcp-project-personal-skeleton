# CUSTOMER - PROJECT's GDM templates

GDM templates for project PROJECT.

# Only RS Bastion is deployed via GDM

## RS Support Bastion

### Create:

`gcloud --project PROJECT deployment-manager deployments create rs-support --config rs-bastion.yaml`

### Delete:

`gcloud --project PROJECT deployment-manager deployments delete rs-support`