#!/bin/bash

set -e

clear

echo "========================================="
echo " TERRAFORM STATE LOSS SIMULATOR"
echo "========================================="
echo

read -p "Enter S3 State Bucket Name: " STATE_BUCKET
read -p "Enter Terraform State File Key: " STATE_FILE

echo
echo "WARNING!"
echo "This will permanently remove the current state file."
echo

read -p "Continue? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo
    echo "Operation cancelled."
    exit 0
fi

echo
echo "Deleting state file..."
echo

aws s3 rm "s3://${STATE_BUCKET}/${STATE_FILE}"

echo
echo "========================================="
echo " STATE LOSS SIMULATION COMPLETED"
echo "========================================="
echo
echo "Next Step:"
echo "Run restore-state.sh to recover state."
echo
