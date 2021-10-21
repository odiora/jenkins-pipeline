FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt install -y \
maven \
docker.io \
openssh-client
COPY daemon.json /etc/docker/
RUN mkdir /root/.ssh/ && touch /root/.ssh/known_hosts
COPY id_rsa /root/.ssh/id_rsa
