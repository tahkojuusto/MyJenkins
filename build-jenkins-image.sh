#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: ./build-jenkins-image <version>"
    exit 1
fi

if [ -z $IMAGE ]
then
    echo 'Set $IMAGE environment variable.'
    exit 1
fi

VERSION=$1

# Update the version number.
echo $VERSION > VERSION

# Create Jenkins image with the given version.
docker build -t ${IMAGE}:${VERSION} .
