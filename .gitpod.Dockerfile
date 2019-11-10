FROM gitpod/workspace-full
RUN cat <<EOF | sudo sh -x && sudo apt-get update && sudo apt-get install -y uidmap iptables kmod
RUN SKIP_IPTABLES=1 curl -sSL https://get.docker.com/rootless | bash
# It requires the following env vars:
ENV XDG_RUNTIME_DIR=/tmp/docker-33333
ENV PATH=/home/gitpod/bin:$PATH
ENV DOCKER_HOST=unix:///tmp/docker-33333/docker.sock
