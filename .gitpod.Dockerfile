FROM golang:1.11-alpine AS gobuild-base
RUN apk add --no-cache \
	bash \
	build-base \
	gcc \
	git \
	libseccomp-dev \
	linux-headers \
	make

FROM alpine:3.8 AS idmap
RUN apk add --no-cache autoconf automake build-base byacc gettext gettext-dev gcc git libcap-dev libtool libxslt
RUN git clone https://github.com/shadow-maint/shadow.git /shadow
WORKDIR /shadow
RUN git checkout 59c2dabb264ef7b3137f5edb52c0b31d5af0cf76
RUN ./autogen.sh --disable-nls --disable-man --without-audit --without-selinux --without-acl --without-attr --without-tcb --without-nscd \
  && make \
  && cp src/newuidmap src/newgidmap /usr/bin

FROM gobuild-base AS rootlesskit
RUN go get github.com/rootless-containers/rootlesskit/cmd/rootlesskit && go get github.com/rootless-containers/rootlesskit/cmd/rootlessctl

FROM gobuild-base AS slirp4netns
RUN apk add --no-cache autoconf automake glib-dev glib-static
RUN git clone https://github.com/rootless-containers/slirp4netns.git /slirp4netns
WORKDIR /slirp4netns
RUN ./autogen.sh \
  && LDFLAGS=-static ./configure --prefix=/usr \
  && make \
  && make install

FROM alpine:3.10
COPY --from=idmap /usr/bin/newuidmap /usr/bin/newuidmap
COPY --from=idmap /usr/bin/newgidmap /usr/bin/newgidmap
COPY --from=rootlesskit /go/bin/rootlesskit /usr/bin/rootlesskit
COPY --from=rootlesskit /go/bin/rootlessctl /usr/bin/rootlessctl
COPY --from=slirp4netns /slirp4netns/slirp4netns /usr/bin/slirp4netns
RUN chmod u+s /usr/bin/newuidmap /usr/bin/newgidmap \
  && adduser -D -u 1000 user \
  && mkdir -p /run/user/1000 \
  && chown -R user /run/user/1000 /home/user \
  && echo user:100000:65536 | tee /etc/subuid | tee /etc/subgid
RUN apk add --no-cache curl iptables iproute2
USER user
RUN curl -sSL https://get.docker.com/rootless | sh
ENV XDG_RUNTIME_DIR=/tmp/docker-1000
ENV PATH=/home/user/bin:$PATH
ENV DOCKER_HOST=unix:///tmp/docker-1000/docker.sock
USER root
