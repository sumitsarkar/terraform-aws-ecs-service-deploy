#!/usr/bin/env bash

# Create repository if it doesn't exist
aws ecr describe-repositories > repositories.json
jq ".repositories[] | select(.repositoryName==\"$SERVICE_NAME\").repositoryUri" repositories.json
export ECR_URL=$(jq ".repositories[] | select(.repositoryName==\"$SERVICE_NAME\").repositoryUri" repositories.json)
export ECR_URL=$(echo $ECR_URL | xargs)
if [ -z "$ECR_URL" ]; then aws ecr create-repository --repository-name $SERVICE_NAME; fi
export ECR_URL=$(jq ".repositories[] | select(.repositoryName==\"$SERVICE_NAME\").repositoryUri" repositories.json)
export ECR_URL=$(echo $ECR_URL | xargs)


echo ${ECR_URL} >> ecr_url

eval $(aws ecr get-login --no-include-email)

docker tag ${IMAGE}:${IMAGE_TAG} ${ECR_URL}:${IMAGE_TAG}
docker push ${ECR_URL}:${IMAGE_TAG}
terraform apply -var image_url=${ECR_URL}:${IMAGE_TAG} -var service_name=${SERVICE_NAME}

