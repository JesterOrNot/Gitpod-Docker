FROM gitpod/workspace-full

RUN sudo apt-get update \
    && sudo apt install -y \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    uidmap \
    kmod \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    xenial \
    stable" \
    && sudo apt-cache policy docker-ce \
    && sudo apt install -y docker-ce uidmap \
    && sudo service docker start \
    && sudo usermod -aG docker gitpod \
    && sudo go get github.com/rootless-containers/rootlesskit/cmd/rootlesskit \
    && sudo go get github.com/rootless-containers/rootlesskit/cmd/rootlessctl
USER gitpod
RUN curl -fsSL https://get.docker.com -o get-docker.sh
USER root
