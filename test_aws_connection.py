import boto3
import pandas as pd

# Test AWS connection
try:
    sts = boto3.client('sts')
    identity = sts.get_caller_identity()
    print(f"✅ Connected to AWS as: {identity['Arn']}")
    print(f"   Account: {identity['Account']}")
    print(f"   Region: Using default or configured region")

    # Test S3 access
    s3 = boto3.client('s3')
    buckets = s3.list_buckets()
    print(f"✅ Found {len(buckets['Buckets'])} S3 buckets")

    # Test Security Hub access
    securityhub = boto3.client('securityhub', region_name='us-east-1')
    print("✅ Security Hub client created")

except Exception as e:
    print(f"❌ Error: {e}")