#!/usr/bin/env bash
# Deploys Jobaance static site directly to S3

set -euo pipefail

REGION=us-east-1
DOMAIN_NAME=$1

# Create bucket if it does not exist
if ! aws s3api head-bucket --bucket "$DOMAIN_NAME" 2>/dev/null; then
  if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket --bucket "$DOMAIN_NAME" --region "$REGION"
  else
    aws s3api create-bucket --bucket "$DOMAIN_NAME" --region "$REGION" \
      --create-bucket-configuration LocationConstraint="$REGION"
  fi
fi

# Enable static website hosting
aws s3 website s3://"$DOMAIN_NAME"/ --index-document index.html --error-document index.html

# Allow public reads
aws s3api put-public-access-block --bucket "$DOMAIN_NAME" \
  --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

cat > /tmp/bucket_policy.json <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::${DOMAIN_NAME}/*"
  }]
}
POLICY
aws s3api put-bucket-policy --bucket "$DOMAIN_NAME" --policy file:///tmp/bucket_policy.json

# Upload files
aws s3 sync . s3://"$DOMAIN_NAME" \
  --exclude "infra/*" \
  --exclude "deploy.sh" \
  --exclude ".git/*" \
  --exclude "README.md" \
  --exclude "LICENSE"

