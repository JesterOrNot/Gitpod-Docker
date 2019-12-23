FROM gitpod/workspace-full

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
          xenial \
          stable" \
    && sudo apt-cache policy docker-ce \
    && sudo apt-get update \
    && sudo apt-get install -y \
        dmsetup \
        git \
        git-man \
        imagemagick \
        imagemagick-6-common \
        imagemagick-6.q16 \
        libdevmapper1.02.1 \
        libdjvulibre-dev \
        libdjvulibre-text \
        libdjvulibre21 \
        libfribidi0 \
        libjpeg-turbo8 \
        libjpeg-turbo8-dev \
        libmagickcore-6-arch-config \
        libmagickcore-6-headers \
        libmagickcore-6.q16-6 \
        libmagickcore-6.q16-6-extra \
        libmagickcore-6.q16-dev \
        libmagickcore-dev \
        libmagickwand-6-headers \
        libmagickwand-6.q16-6 \
        libmagickwand-6.q16-dev \
        libmagickwand-dev \
        libmysqlclient-dev \
        libmysqlclient20 \
        libnss-systemd \
        libpam-systemd \
        libruby2.5 \
        libsqlite3-0 \
        libsqlite3-dev \
        libssh-4 \
        libsystemd0 \
        libudev1 \
        linux-libc-dev \
        python3-distutils \
        python3-lib2to3 \
        ruby2.5 \
        systemd \
        systemd-sysv \
        unattended-upgrades \
        apt-utils \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        uidmap \
        lxc \
        lxc-dev \
        kmod \
        software-properties-common \
        docker-ce \
    && sudo service docker start \
    && sudo usermod -aG docker gitpod

USER gitpod

RUN export SKIP_IPTABLES=1 && curl -fsSL https://get.docker.com/rootless | sh
USER root
ENV XDG_RUNTIME_DIR=/tmp/docker-33333
ENV PATH=/home/gitpod/bin:$PATH
ENV DOCKER_HOST=unix:///tmp/docker-33333/docker.sock
RUN sudo dockerd -H unix:///tmp/docker-33333/docker.sock --experimental > /tmp/logfile