FROM ubuntu:20.04
WORKDIR nym
COPY entrypoint.sh entrypoint.sh

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install wget curl && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/nymtech/nym/releases/download/nym-binaries-v1.1.6/nym-mixnode -O nym-mixnode

RUN groupadd -g 10000 user &&  useradd -u 10000 -g 10000 -ms /sbin/nologin user
RUN chown -R user:user /home/user && chmod +x nym-mixnode && chmod +x entrypoint.sh
USER user

EXPOSE 1789
EXPOSE 1780
EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]

