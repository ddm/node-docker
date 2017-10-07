FROM alpine:3.6

ARG NODE_VERSION=6.11.4
ARG NODE_BUILD_PATH=/tmp/node/

RUN apk --no-cache add --virtual runtime-dependencies libstdc++ &&\
    apk --no-cache add --virtual build-dependencies \
      git \
      binutils-gold \
      linux-headers \
      musl-dev \
      build-base \
      python &&\
    git clone --depth 1 --branch v${NODE_VERSION} https://github.com/nodejs/node.git ${NODE_BUILD_PATH} &&\
    cd ${NODE_BUILD_PATH} &&\
    ./configure && \
    make -j$(getconf _NPROCESSORS_ONLN) &&\
    make install &&\
    apk del --purge build-dependencies &&\
    rm -rf /tmp/* &&\
    rm -rf /root/* &&\
    rm -rf /var/cache/apk/*

RUN node --version
