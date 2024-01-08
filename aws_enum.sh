#!/bin/bash

# Fetch the current IAM user details
currentUser=$(aws sts get-caller-identity --query 'Arn' --output text)
echo "Current IAM User ARN: $currentUser"

# Extract the username from the ARN
username=$(echo $currentUser | rev | cut -d'/' -f1 | rev)
echo "Extracted Username: $username"

# List attached policies
echo "Listing attached policies for user: $username"
attachedPolicies=$(aws iam list-attached-user-policies --user-name $username --query 'AttachedPolicies[].PolicyArn' --output text)
echo "Attached policies: $attachedPolicies"

# Get details of each attached policy
echo "Fetching policy details..."
for policyArn in $attachedPolicies; do
    echo "Policy ARN: $policyArn"

    # Fetch policy version
    policyVersion=$(aws iam get-policy --policy-arn $policyArn --query 'Policy.DefaultVersionId' --output text)
    echo "Policy Version: $policyVersion"

    # Fetch policy document
    echo "Policy Document for $policyArn (version $policyVersion):"
    aws iam get-policy-version --policy-arn $policyArn --version-id $policyVersion --query 'PolicyVersion.Document' --output json
    echo ""
done
