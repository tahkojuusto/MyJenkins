#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: ./deploy-jenkins-image <version>"
    exit
fi

if [[ -z "$IMAGE" || -z "$ECR" || -z "$AWS" ]]
then
    echo 'Set $IMAGE, $ECR, and $AWS environment variables.'
    exit
fi

VERSION=$1

# Remote AWS IMAGE (ECR) for images.
REMOTE="${ECR}/${IMAGE}"

# Login to AWS.
aws --profile=${AWS} ecr get-login --no-include-email --region eu-west-1 > temp.txt
bash temp.txt
rm temp.txt

# Add 'latest' tag to the image.
docker tag ${IMAGE}:${VERSION} ${REMOTE}:${VERSION}
docker tag ${IMAGE}:${VERSION} ${REMOTE}:latest

# Push the image to ECR.
docker push ${REMOTE}:${VERSION}
docker push ${REMOTE}:latest
