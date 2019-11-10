FROM gitpod/workspace-full
USER gitpod

# Rootless Docker
# gets installed to /home/gitpod/bin
RUN cat <<EOF | sudo sh -x
RUN apt-get update && apt-get install -y uidmap iptables && modprobe ip_tables && EOF
RUN curl -sSL https://get.docker.com/rootless | sh
# It requires the following env vars:
ENV XDG_RUNTIME_DIR=/tmp/docker-33333
ENV PATH=/home/gitpod/bin:$PATH
ENV DOCKER_HOST=unix:///tmp/docker-33333/docker.sock
