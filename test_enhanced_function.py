import boto3
import os
import json
from datetime import datetime
from io import BytesIO
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill

# Test the enhanced function locally
bucket_name = "security-hub-excel-pipeline-reportbucket-whrdm3umxwij"

print("🔍 Testing Enhanced Security Hub Function")
print(f"⏰ Started at: {datetime.now()}")

try:
    # Import the enhanced function
    import lambda_function_enhanced
    
    # Simulate Lambda event
    event = {}
    context = {}
    
    # Set environment variables
    os.environ['S3_BUCKET_NAME'] = bucket_name
    os.environ['SNS_TOPIC_ARN'] = ""  # Empty for testing without SNS
    
    # Call the Lambda handler
    result = lambda_function_enhanced.lambda_handler(event, context)
    
    print(f"\n✅ Function executed successfully!")
    print(f"Status Code: {result['statusCode']}")
    
    if result['statusCode'] == 200:
        body = json.loads(result['body'])
        print(f"Findings Count: {body['findings_count']}")
        print(f"High/Critical Count: {body['high_severity_count']}")
        print(f"Report Location: s3://{bucket_name}/{body['report']}")
    
except Exception as e:
    print(f"❌ Error: {e}")
    import traceback
    traceback.print_exc()