# Deploying an Azure Devops Agent on AWS Elastic Container Service

## Docker walk through

variables between {{}}

```
aws ecr get-login-password --region us-east-1 --profile inframanager  | sudo docker login --username AWS --password-stdin 520743652918.dkr.ecr.us-east-1.amazonaws.com
```

```
sudo docker build --tag cloud-base:0.1 --file "./cloudbase.dockerfile" .
```

```
sudo docker tag cloud-base:0.1 520743652918.dkr.ecr.us-east-1.amazonaws.com/devopsecr:cloud-base
```

```
docker push 520743652918.dkr.ecr.us-east-1.amazonaws.com/devopsecr:cloud-base
```

```
docker push 520743652918.dkr.ecr.us-east-1.amazonaws.com/devopsecr:azpagent0.1
```

```
docker run -e AZP_URL="<Azure DevOps instance>" -e AZP_TOKEN="<Personal Access Token>" -e AZP_POOL="<Agent Pool Name>" -e AZP_AGENT_NAME="Docker Agent - Linux" --name "azp-agent-linux" azp-agent:linux
```

520743652918.dkr.ecr.us-east-1.amazonaws.com/devopsecr:azpagent0.1