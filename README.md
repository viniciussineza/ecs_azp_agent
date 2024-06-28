# Deploying an Azure Devops Agent on AWS Elastic Container Service

## Docker walk through

variables between {{}}

```
aws ecr get-login-password --region {{ region }}--profile {{ profile }}  | docker login --username AWS --password-stdin 520743652918.dkr.ecr.us-east-1.amazonaws.com
```

```
sudo docker build --tag cloud-base:0.1 --file "./cloudbase.dockerfile" .
```

```
docker tag devops-ecr:latest 520743652918.dkr.ecr.us-east-1.amazonaws.com/devops-ecr:latest
```