
## Banned Terraform Resources:
- google_project_iam_policy
- google_project_iam_binding targeting Primitive Roles or Roles given to mgcp-support
- google_compute_shared_vpc_host_project and google_compute_shared_vpc_service_project
- google_project => Create projects via Janus
- All organizational resources except in the single project designated for Organization management. 

## Required Practices:
- The resource google_container_cluster must have an empty node pool as shown in the TF Docs: https://www.terraform.io/docs/providers/google/r/container_cluster.html
- The resource google_compute_instance_template must have a lifecycle policy of create before destroy.
- All credentials must be encrypted with KMS/Secret Manager and the binary blob commited to git.
- One project per repository per state. The only exception is a single project per customer that is used to manage organisational resources.
- The terraform state must be in a GCS Bucket in the Shared VPC Project. This project must not have any other service accounts with access to buckets.
- Use the terraform-docs to generate module readme's
- You will need to use this skeleton repository to initialize all new terraform builds.
- Use the [modules from Google](https://registry.terraform.io/modules/terraform-google-modules) over manual deployment. For example, use the vpc module from Google instead of manually creating the network resources.
- For customers that will have modules being deployed to multiple environments(projects), you need to adhere to the following:
	- Modules need to be in the Shared Repository.
	- A dev aviator project is required for terraform r&d
	- Follow the versioning and release section below.
    - PRs are welome from customers but will still require rackers approvals
- For customers with large units of repeated infrastrucure across multiple projects, you will need to use modules and version them as mentioned in the Modules Section.

## Module Management

### Versioning
Modules will be versioned inline with the Semver Versioning system. https://semver.org/

For our purposes: XX.YY.ZZ

XX is a major version where extensive state manipulation, module refactor or resource deletion is required.

YY is a minor version where new variables and resources are introduced but no state manipulation.

ZZ is a patch version where the module is changed but no changes to the module parameters is required.

In short:
- Patch changes can be applied without changing the module parameters
- Minor version changes can be applied without amending the terraform state.

### Releases
Master branch should be deployable at all times. Test your changes in a dev branch on a dev project. Raise a PR to merge to master.

Staging must always be deployed from master. If it performs well, a new version/git tag is released.

Prod is deployed from a version that was successful in UAT and Prod must never be deployed from master.

Changes need to be promoted in the correct order. Dev => Staging => Production.


## Acceptance Rules from Professional Services:

Some customers will contract Pro Serv to do some work, but if Manage and Operate is in scope, then it must comply with the standards in this document for the projects to be assumed into support.

MGCP doesn't manage resources outside of projects today as defined by Google's resource hierachy [here](https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy#resource-hierarchy-detail). Please don't include such resources in any project except the single project designated for organizational management. Usually this is the project with the service account that is given org permissions.

It is a requirement that MGCP Cloud Engineers can execute succesful `terraform plan` with roles that are avaiable in a project. 