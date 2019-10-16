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
    apt-get clean

