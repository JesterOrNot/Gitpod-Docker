FROM gitpod/workspace-full

RUN sudo apt-get update \
    && sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
    && sh -c 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -' \
    && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"; \
    && sudo apt update \
    && apt-cache policy docker-ce \
    && sudo apt install docker-ce \
    && sudo systemctl status docker \
    && sudo usermod -aG docker gitpod