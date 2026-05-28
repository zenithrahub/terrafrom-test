#!/bin/bash

terraform workspace select dev
terraform init
terraform plan
terraform apply -auto-approve
