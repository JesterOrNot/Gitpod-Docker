FROM gitpod/workspace-full-vnc
USER root
RUN apt-get update && \
    apt-get install apt-transport-https && \
    apt-get install ca-certificates && \
    apt-get install software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install docker-ce --yes && \
    apt-get clean && \
    sudo dockerd -H unix:///var/run/docker.sock -H tcp://192.168.59.106 -H tcp://10.10.10.2
RUN curl -L “https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)” -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
