FROM gitpod/workspace-full

RUN sudo apt-get update \
    && sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    xenial \
    stable" \
    && apt-cache policy docker-ce \
    && sudo apt install -y docker-ce \
    && sudo service docker start \
    && sudo usermod -aG docker gitpod \
    && sudo su - gitpod
