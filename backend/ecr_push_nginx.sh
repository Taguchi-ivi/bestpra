#!/bin/zsh

# envファイル読み込み
source ../.env

# backend-nginxのイメージプッシュ
# latestでは分かりづらくなるため、tagにcommitIDを付与
GIT_COMMIT_ID=$(git log --format="%H" -n 1)
REPO_NAME=bestpra/backend-nginx

# 確認用
# echo $GIT_COMMIT_ID
# echo $REPO_NAME
# echo $ECR_REPOURL

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $ECR_REPOURL
docker build -t $REPO_NAME:$GIT_COMMIT_ID -f ./docker/nginx/Dockerfile.prod .
docker tag $REPO_NAME:$GIT_COMMIT_ID $ECR_REPOURL/$REPO_NAME:$GIT_COMMIT_ID
docker push $ECR_REPOURL/$REPO_NAME:$GIT_COMMIT_ID