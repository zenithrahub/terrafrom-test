#!/bin/bash

set -e

clear

echo "========================================="
echo " TERRAFORM STATE RECOVERY"
echo "========================================="
echo

read -p "Enter S3 State Bucket Name: " STATE_BUCKET
read -p "Enter Terraform State File Key: " STATE_FILE

echo
echo "Available Versions:"
echo

aws s3api list-object-versions \
    --bucket "$STATE_BUCKET" \
    --prefix "$STATE_FILE" \
    --query 'Versions[].{VersionId:VersionId,LastModified:LastModified}' \
    --output table

echo

read -p "Enter Version ID to Restore: " VERSION_ID

echo
echo "Downloading selected version..."
echo

aws s3api get-object \
    --bucket "$STATE_BUCKET" \
    --key "$STATE_FILE" \
    --version-id "$VERSION_ID" \
    restored.tfstate

echo
echo "Uploading recovered state..."
echo

aws s3 cp restored.tfstate "s3://${STATE_BUCKET}/${STATE_FILE}"

rm -f restored.tfstate

echo
echo "========================================="
echo " STATE RESTORED SUCCESSFULLY"
echo "========================================="
echo
