#!/bin/bash
set -e

echo "=========================================="
echo "Deploying Enhanced Security Hub Lambda"
echo "=========================================="

# Configuration
FUNCTION_NAME="security-hub-excel-report-enhanced"
S3_BUCKET="security-hub-excel-pipeline-reportbucket-whrdm3umxwij"
SNS_TOPIC_ARN="arn:aws:sns:us-east-1:291846646255:security-hub-report-notifications"
LAMBDA_ROLE="arn:aws:iam::291846646255:role/security-hub-excel-pipeline-LambdaRole-u0DxXzlrxV1g"
REGION="us-east-1"

echo "Function: $FUNCTION_NAME"
echo "S3 Bucket: $S3_BUCKET"
echo "SNS Topic: $SNS_TOPIC_ARN"
echo "Region: $REGION"
echo ""

# Check if function exists
echo "Checking if Lambda function exists..."
if aws lambda get-function --function-name $FUNCTION_NAME --region $REGION 2>/dev/null; then
    echo "✅ Function exists, updating code..."
    aws lambda update-function-code \
        --function-name $FUNCTION_NAME \
        --zip-file fileb://lambda-source.zip \
        --region $REGION

    echo "Updating environment variables..."
    aws lambda update-function-configuration \
        --function-name $FUNCTION_NAME \
        --environment Variables="{S3_BUCKET_NAME=$S3_BUCKET,SNS_TOPIC_ARN=$SNS_TOPIC_ARN}" \
        --region $REGION

    echo "✅ Function updated successfully!"
else
    echo "Function does not exist, creating new function..."
    aws lambda create-function \
        --function-name $FUNCTION_NAME \
        --runtime python3.11 \
        --role $LAMBDA_ROLE \
        --handler lambda_function.lambda_handler \
        --zip-file fileb://lambda-source.zip \
        --timeout 300 \
        --memory-size 512 \
        --environment Variables="{S3_BUCKET_NAME=$S3_BUCKET,SNS_TOPIC_ARN=$SNS_TOPIC_ARN}" \
        --region $REGION

    echo "✅ Function created successfully!"
fi

echo ""
echo "=========================================="
echo "Testing the function..."
echo "=========================================="

# Test the function
echo "Invoking Lambda function..."
aws lambda invoke \
    --function-name $FUNCTION_NAME \
    --payload '{}' \
    --region $REGION \
    response.json

echo ""
echo "Response:"
cat response.json | python -m json.tool

echo ""
echo "=========================================="
echo "✅ Deployment complete!"
echo "=========================================="
echo "Function: $FUNCTION_NAME"
echo "SNS Topic: $SNS_TOPIC_ARN"
echo ""
echo "Next steps:"
echo "1. Subscribe your email to the SNS topic:"
echo "   aws sns subscribe --topic-arn $SNS_TOPIC_ARN --protocol email --notification-endpoint YOUR_EMAIL"
echo ""
echo "2. Set up CloudWatch Events for scheduling (optional)"
echo ""