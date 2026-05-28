#!/bin/bash
terraform init
terraform fmt -check

terraform validate

checkov -d . --external-checks-dir policies
