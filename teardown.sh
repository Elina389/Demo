#!/usr/bin/env bash
# Deletes everything setup-aws.sh created. Irreversible: all submissions are lost.
set -euo pipefail
source ./aws-outputs.txt
ROLE="mentor-match-lambda-role"

read -r -p "Delete bucket $BUCKET, table $TABLE and function $FUNCTION? Type yes: " ok
[ "$ok" = "yes" ] || { echo "Cancelled."; exit 1; }

aws s3 rm "s3://$BUCKET" --recursive
aws s3api delete-bucket --bucket "$BUCKET" --region "$REGION"
aws lambda delete-function-url-config --region "$REGION" --function-name "$FUNCTION" || true
aws lambda delete-function --region "$REGION" --function-name "$FUNCTION"
aws dynamodb delete-table --region "$REGION" --table-name "$TABLE" >/dev/null
aws iam delete-role-policy --role-name "$ROLE" --policy-name MentorMatchTableAccess
aws iam detach-role-policy --role-name "$ROLE" \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam delete-role --role-name "$ROLE"
echo "All removed. (Delete any CloudFront distribution separately in the console.)"
