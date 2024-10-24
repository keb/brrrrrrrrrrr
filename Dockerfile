# docker build -t brrr .
# docker run -v .:/workspace/ext brrr bash -c "for i in /workspace/ext/buildroot*.patch; do patch -p1 < \$i; done && make BR2_EXTERNAL=/workspace/ext rgarc_defconfig && make -j16 && cp -rv output/images /workspace/ext/output"

FROM debian:latest

ARG BR_VER=2024.02.1
ENV HOSTNAME brrrrrrrrrr

RUN apt-get update && apt-get install -y \
    build-essential curl bc cpio rsync file git wget unzip python3 libssl-dev dosfstools zstd

RUN mkdir -p /workspace
RUN curl -s -L https://github.com/buildroot/buildroot/archive/refs/tags/${BR_VER}.tar.gz | tar xvz -C /workspace && ls -l /workspace/
WORKDIR /workspace/buildroot-${BR_VER}
