#!/bin/sh
set -xe
tfenv install
cd terraform
terraform fmt -check=true -write=false -diff=true -list=true -recursive
