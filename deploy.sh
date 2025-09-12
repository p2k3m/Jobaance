#!/usr/bin/env bash
# Deploys Jobaance static site using AWS CLI and CloudFormation

set -euo pipefail

STACK_NAME=jobaance-site
REGION=us-east-1
DOMAIN_NAME=$1
CERT_ARN=$2

aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file infra/cloudformation.yaml \
  --parameter-overrides DomainName="$DOMAIN_NAME" CertificateArn="$CERT_ARN" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$REGION"

aws s3 sync . s3://$DOMAIN_NAME \
  --exclude "infra/*" \
  --exclude "deploy.sh" \
  --exclude ".git/*" \
  --exclude "README.md" \
  --exclude "LICENSE"
