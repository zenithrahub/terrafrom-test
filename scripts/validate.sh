#!/bin/bash

terraform fmt -check

terraform validate

checkov -d . --external-checks-dir policies
