#!/bin/sh
set -xe
tfenv install
cd terraform
terraform init -input=false
terraform get
terraform validate && echo

CI_COMMIT_SHORT_SHA=$(echo ${CIRCLE_SHA1:0:8})

if [ "$CIRCLE_BRANCH" = "master" ];
 then
    terraform plan -input=false -out="terraform-$CI_COMMIT_SHORT_SHA.plan" -detailed-exitcode
 else
    terraform plan -input=false -out="terraform-$CI_COMMIT_SHORT_SHA.plan"
fi

tar -czf "terraform-$CI_COMMIT_SHORT_SHA.tar.gz" .terraform
