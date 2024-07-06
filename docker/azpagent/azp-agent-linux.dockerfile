FROM 520743652918.dkr.ecr.us-east-1.amazonaws.com/devopsecr:cloud-base
ENV TARGETARCH="linux-x64"

RUN echo | openssl s_client -showcerts -connect registry.terraform.io:443 2>/dev/null | awk '/-----BEGIN CERTIFICATE-----/, /-----END CERTIFICATE-----/' >> /usr/local/share/ca-certificates/ca-certificates.crt

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
# ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT [ "./start.sh" ]