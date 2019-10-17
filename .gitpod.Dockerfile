FROM gitpod/workspace-full-vnc
RUN apt-get update && \
    apt-get install apt-transport-https && \
    apt-get install ca-certificates && \
    apt-get install software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install docker-ce --yes --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
RUN curl -L https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && mv /tmp/docker-machine /usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine
