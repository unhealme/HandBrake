FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get -y install automake autoconf autopoint build-essential cmake gcc git intltool libtool libtool-bin m4 make meson nasm ninja-build patch pkg-config tar zlib1g-dev clang curl libssl-dev bison bzip2 flex g++ gzip pax libnuma-dev && \
    apt-get -y clean

ENV RUSTUP_HOME="/opt/rustup" PATH="/opt/cargo/bin:${PATH}"
RUN export CARGO_HOME="/opt/cargo" && \
    curl https://sh.rustup.rs -sSf | bash -s -- -y --no-modify-path && \
    cargo install cargo-c && \
    rm -rf "${CARGO_HOME}"/registry "${CARGO_HOME}"/git && \
    rustup target add x86_64-pc-windows-gnu
