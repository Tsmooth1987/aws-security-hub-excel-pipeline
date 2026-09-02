#!/bin/bash
set -e

echo "=========================================="
echo "Setting Up SNS Email Notifications"
echo "=========================================="

SNS_TOPIC_ARN="arn:aws:sns:us-east-1:291846646255:security-hub-report-notifications"

echo "SNS Topic: $SNS_TOPIC_ARN"
echo ""
echo "To subscribe to Security Hub report notifications, run:"
echo ""
echo "aws sns subscribe \\"
echo "  --topic-arn $SNS_TOPIC_ARN \\"
echo "  --protocol email \\"
echo "  --notification-endpoint YOUR_EMAIL_ADDRESS \\"
echo "  --region us-east-1"
echo ""
echo "Replace YOUR_EMAIL_ADDRESS with your actual email."
echo "You will receive a confirmation email to confirm the subscription."
echo ""
echo "=========================================="
echo "Current SNS Topic Info:"
echo "=========================================="

aws sns get-topic-attributes --topic-arn $SNS_TOPIC_ARN --region us-east-1