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
    software-properties-common
# && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
# && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
# xenial \
# stable" \
# && sudo apt-cache policy docker-ce \
# && sudo apt install -y docker-ce uidmap \
# && sudo service docker start \
# && sudo usermod -aG docker gitpod \

USER gitpod
RUN mkdir /proc/sys/kernel/unprivileged_userns_clone \
    && sudo sh -c "echo 1 > /proc/sys/kernel/unprivileged_userns_clone" \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && sudo curl -s -sSL https://get.docker.com/rootless | sh \
    && sudo usermod -aG docker gitpod
USER root
