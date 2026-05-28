#!/bin/bash

terraform workspace select production

terraform init

terraform plan

terraform apply -auto-approve
