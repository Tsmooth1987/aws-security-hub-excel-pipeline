import boto3
import pandas as pd
from datetime import datetime

def get_security_findings():
    """Fetch recent Security Hub findings"""
    try:
        client = boto3.client('securityhub', region_name='us-east-1')

        # Get findings from last 24 hours
        response = client.get_findings(
            Filters={
                'RecordState': [{'Value': 'ACTIVE', 'Comparison': 'EQUALS'}]
            },
            MaxResults=10
        )

        findings = response.get('Findings', [])
        print(f"✅ Found {len(findings)} active security findings")

        return findings

    except Exception as e:
        print(f"❌ Error fetching findings: {e}")
        return []

def analyze_findings(findings):
    """Analyze and categorize findings"""
    if not findings:
        print("No findings to analyze")
        return

    # Create DataFrame for analysis
    df = pd.json_normalize(findings)

    print(f"\n📊 Analysis Summary:")
    print(f"Total findings: {len(df)}")

    if 'Severity.Label' in df.columns:
        severity_counts = df['Severity.Label'].value_counts()
        print(f"\nSeverity breakdown:")
        for severity, count in severity_counts.items():
            print(f"  {severity}: {count}")

    if 'Title' in df.columns:
        print(f"\nSample finding titles:")
        for title in df['Title'].head(3):
            print(f"  - {title}")

def main():
    print("🔍 Starting Security Hub Analysis")
    print(f"⏰ Started at: {datetime.now()}")

    findings = get_security_findings()
    analyze_findings(findings)

    print(f"\n✅ Analysis complete at: {datetime.now()}")

if __name__ == "__main__":
    main()