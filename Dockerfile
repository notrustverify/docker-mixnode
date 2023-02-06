# 1. This tells docker to use the Rust official image
FROM rust:1.66-slim-buster as build

ARG NYM_VERSION=v1.1.6

RUN apt-get update && apt-get -y install pkg-config build-essential libssl-dev curl git && rm -rf /var/lib/apt/lists/*
#RUN git clone https://github.com/nymtech/nym && cd nym && git checkout $(curl -sSL 'https://api.github.com/repos/nymtech/nym/releases' | grep nym-client | grep -E -o "nym-binaries-v[0-9]\.]?[0-9]\.]?[0-9]\]?" | sort | tail -n 1)
RUN git clone https://github.com/nymtech/nym && cd nym && git checkout nym-binaries-$NYM_VERSION
WORKDIR /nym

# Build your program for release
RUN cargo build --bin nym-mixnode --release && echo "nym-client built !!!" || "nym-client failed to build."
RUN rm -rf target/release/deps/* target/release/build/*


FROM debian:stable-slim
WORKDIR nym
COPY --from=build /nym/target/release/nym-mixnode .
COPY entrypoint.sh .

RUN apt-get update && apt-get -y install ca-certificates && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 10000 user &&  useradd -u 10000 -g 10000 -ms /sbin/nologin user
RUN chown -R user:user /home/user && chmod +x nym-mixnode && chmod +x entrypoint.sh
USER user

EXPOSE 1789
EXPOSE 1790
EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]
