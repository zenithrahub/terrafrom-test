#!/bin/bash

terraform workspace select staging

terraform init

terraform plan

terraform apply -auto-approve
