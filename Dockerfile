FROM alpine:3.5

ARG NODE_VERSION=7.8.0
ARG NODE_BUILD_PATH=/tmp/node/

RUN apk --no-cache add libstdc++ &&\
    apk --no-cache add --virtual build-dependencies \
      git \
      binutils-gold \
       \
      linux-headers \
      musl-dev \
      build-base \
      python &&\
    git clone https://github.com/nodejs/node.git ${NODE_BUILD_PATH} &&\
    cd ${NODE_BUILD_PATH} &&\
    git checkout v${NODE_VERSION} &&\
    ./configure && \
    make -j$(getconf _NPROCESSORS_ONLN) &&\
    make install &&\
    rm -rf ${NODE_BUILD_PATH} &&\
    apk del --purge build-dependencies &&\
    rm -rf /var/cache/apk/*
RUN node --version
