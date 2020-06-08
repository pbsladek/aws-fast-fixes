#!/bin/bash
# ./enable-s3-multi-account-list.sh "aws s3 ls"
# ./enable-s3-multi-account-list.sh "python3 enable-s3-block-public-access.py --output-script enable-s3-block-public-access.log"

cmd=$1
region=${2:-us-west-2}

[ "$#" -eq 1 ] || exit "1 argument required, $# provided"

IFS=$'\n'
for aws_profile in $(awsp)
do
    export AWS_PROFILE="$aws_profile"
    export AWS_REGION="$region"
    echo "Using $aws_profile aws profile"
    echo "Running: $cmd-$aws_profile"
    eval "$cmd-$aws_profile"
done