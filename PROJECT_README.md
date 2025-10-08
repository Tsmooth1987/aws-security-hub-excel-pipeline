# Project 8: AWS Security Hub to Excel Pipeline

**Status:** ✅ COMPLETE  
**Date Completed:** October 7, 2025  
**Author:** Terence Webster

## 🎯 Project Overview

A production-ready serverless application that automatically extracts security findings from AWS Security Hub and generates professional, audit-ready Excel reports. This project demonstrates enterprise-level GRC automation using AWS Lambda, CloudFormation, and Python.

## 📊 Results

- **140 Security Hub findings** successfully extracted and processed
- **Professional Excel report** generated with formatted headers and color coding
- **Serverless architecture** deployed via Infrastructure as Code
- **16MB deployment package** with all dependencies
- **Sub-5-minute execution time** for complete report generation

## 🏗️ Architecture


## 🚀 Deployment Process

### Prerequisites Met
- ✅ AWS CLI configured with valid credentials
- ✅ Security Hub enabled in AWS account
- ✅ Python 3.11+ installed locally
- ✅ IAM permissions for Lambda, S3, Security Hub, CloudFormation

### Deployment Steps Completed

1. **Package Lambda Function**
   ```bash
   ./package-lambda.sh
   # Result: lambda-source.zip (16MB)
aws cloudformation deploy \
  --template-file cloudformation-template.yaml \
  --stack-name security-hub-excel-pipeline \
  --capabilities CAPABILITY_NAMED_IAM
# Result: Stack created successfully
aws lambda update-function-configuration \
  --function-name security-hub-excel-report \
  --handler lambda_function.lambda_handler

aws lambda update-function-code \
  --function-name security-hub-excel-report \
  --zip-file fileb://lambda-source.zip
# Result: Function updated with actual code
aws lambda invoke \
  --function-name security-hub-excel-report \
  --output json response.json
# Result: 200 OK, 140 findings processed
aws s3 cp s3://security-hub-excel-pipeline-reportbucket-whrdm3umxwij/reports/security_hub_20251008_063238.xlsx ./my-security-report.xlsx
# Result: Professional Excel report downloaded
cd /Users/terencewebster/Desktop/GRC/PYTHON/security-hub-excel-pipeline

# Initialize git
git init

# Create .gitignore to exclude unnecessary files
cat > .gitignore << 'ENDOFFILE'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
*.egg-info/
dist/
*.egg
venv/
.venv/

# AWS
*.pem
*.key
.aws/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Project specific
lambda-source.zip
response.json
my-security-report.xlsx
*.xlsx

# OS
.DS_Store
Thumbs.db
