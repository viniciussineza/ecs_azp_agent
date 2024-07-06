FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

LABEL maintainer="Cloud Varejo"

RUN \
    apt-get update; \
    apt-get install -y git jq libicu70 gnupg software-properties-common wget unzip ca-certificates curl

RUN \
    apt-get update; \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null; \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update; \
    apt-get install -y terraform

RUN \
    apt-add-repository ppa:ansible/ansible; \
    apt-get update; \
    apt-get install -y ansible

RUN \
    install -m 0755 -d /etc/apt/keyrings; \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc; \
    chmod a+r /etc/apt/keyrings/docker.asc ; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null ; \
    apt-get update ; \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin