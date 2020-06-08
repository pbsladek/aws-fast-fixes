#!/bin/bash
# ./multi-account.sh "aws s3 ls"
# ./multi-account.sh "python3 enable-guardduty.py --accept-invite 987569341137"

cmd=$1
region=${2:-us-west-2}

[ "$#" -eq 1 ] || exit "1 argument required, $# provided"

IFS=$'\n'
for aws_profile in $(awsp)
do
    export AWS_PROFILE="$aws_profile"
    export AWS_REGION="$region"
    echo "Using $aws_profile aws profile"
    echo "Running: $cmd"
    eval "$cmd"
done