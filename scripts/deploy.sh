#!/bin/bash

terraform workspace select production

terraform init

terrform plan

terraform apply -auto-approve
