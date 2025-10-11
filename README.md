# Security Hub Excel Pipeline

Serverless Lambda function that transforms AWS Security Hub findings into professional, audit-ready Excel reports.

## 🎯 Overview

This production-ready serverless application automatically extracts security findings from AWS Security Hub and generates professional Excel reports with formatting, color coding, and audit-ready structure. Perfect for compliance teams and security auditors.

## ✨ Features

- **Automated Report Generation** - Serverless Lambda execution
- **Professional Excel Formatting** - Styled headers, color coding, auto-sized columns
- **140+ Findings Processed** - Real production deployment results
- **S3 Integration** - Automatic report storage with timestamped filenames
- **CloudFormation Deployment** - Infrastructure as Code
- **Comprehensive Logging** - CloudWatch Logs integration
- **Sub-5-Minute Execution** - Fast report generation

## 🚀 Quick Start

### Prerequisites

- Python 3.11+
- AWS CLI configured with appropriate credentials
- Security Hub enabled in your AWS account
- IAM permissions for Lambda, S3, Security Hub, CloudFormation

### Deployment

**1. Package Lambda Function:**
```bash
chmod +x package-lambda.sh
./package-lambda.sh
