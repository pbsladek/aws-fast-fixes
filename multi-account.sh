#!/bin/bash
# ./multi-account.sh "aws s3 ls"
# ./multi-account.sh "python3 enable-guardduty.py --accept-invite 987569341137"

cmd=$1
region=${2:-us-west-2}

if [ $# -le 1 ]; then
    echo "Usage: ./multi-account.sh \"aws s3 ls\""
    exit 1
fi

if [[ "$region" == "all" ]]; then
  for region in $(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)
  do
    IFS=$'\n'
    for aws_profile in $(awsp)
    do
      export AWS_PROFILE="$aws_profile"
      export AWS_REGION="$region"
      echo "Using $aws_profile aws profile"
      echo "Running: $cmd"
      echo "Running: $region"
      eval "$cmd"
    done
  done
else
  IFS=$'\n'
  for aws_profile in $(awsp)
  do
      export AWS_PROFILE="$aws_profile"
      export AWS_REGION="$region"
      echo "Using $aws_profile aws profile"
      echo "Running: $cmd"
      eval "$cmd"
  done
fi