#!/bin/bash
set -e

echo "=========================================="
echo "Packaging Lambda Function"
echo "=========================================="

# Create a clean build directory
echo "Creating build directory..."
rm -rf build
mkdir -p build

# Install dependencies to build directory
echo "Installing dependencies..."
pip3 install -r requirements.txt -t build/ --upgrade

# Copy Lambda function
echo "Copying enhanced Lambda function..."
cp lambda_function_enhanced.py build/lambda_function.py

# Create ZIP file
echo "Creating deployment package..."
cd build
zip -r ../lambda-source.zip . -q
cd ..

# Get file size
SIZE=$(ls -lh lambda-source.zip | awk '{print $5}')
echo ""
echo "=========================================="
echo "✅ Package created successfully!"
echo "=========================================="
echo "File: lambda-source.zip"
echo "Size: $SIZE"
echo ""
