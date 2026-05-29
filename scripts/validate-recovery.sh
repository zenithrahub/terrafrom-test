#!/bin/bash

set -e

clear

echo "========================================="
echo " TERRAFORM RECOVERY VALIDATION"
echo "========================================="
echo

echo "[1/3] Initializing Terraform..."
terraform init

echo
echo "[2/3] Refreshing State..."
terraform refresh

echo
echo "[3/3] Checking Infrastructure Drift..."
terraform plan -detailed-exitcode

PLAN_EXIT_CODE=$?

echo

case $PLAN_EXIT_CODE in
    0)
        echo "No drift detected."
        ;;
    2)
        echo "Drift detected. Review required."
        ;;
    *)
        echo "Validation failed."
        exit 1
        ;;
esac

echo
echo "========================================="
echo " VALIDATION COMPLETED"
echo "========================================="
