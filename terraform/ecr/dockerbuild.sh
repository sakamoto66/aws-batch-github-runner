#!/bin/bash

# Docker login
aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build image
docker build -t $CONTAINER_NAME ../docker

# Tag
docker tag $CONTAINER_NAME:latest $REPO_URL:latest

# Push image
docker push $REPO_URL:latest