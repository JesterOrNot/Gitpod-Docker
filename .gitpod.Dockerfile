FROM gitpod/workspace-full-vnc@sha256:22bfcdd143f9b32f1d3821ab7ce3f83f2458725feaa4366456e5f8bc312354fc
RUN apt-get update && \
    apt-get install apt-transport-https=1.0.9.8.5 \
    ca-certificates=20190110 \
    software-properties-common=0.96.20.2-2 --yes --no-install-recommends && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install docker-ce --yes --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN curl -L "https://github.com/docker/machine/releases/download/v0.16.0/docker-machine-$(uname -s)-$(uname -m)" >/tmp/docker-machine && mv /tmp/docker-machine /usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine
