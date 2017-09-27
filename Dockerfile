FROM alpine:3.6

ARG NODE_VERSION=8.6.0
ARG NODE_BUILD_PATH=/tmp/node/

ADD https://yarnpkg.com/install.sh /tmp/yarn/install.sh

RUN apk --no-cache add --virtual runtime-dependencies libstdc++ &&\
    apk --no-cache add --virtual build-dependencies \
      git \
      binutils-gold \
      linux-headers \
      musl-dev \
      build-base \
      python \
      bash &&\
    git clone --depth 1 --branch v${NODE_VERSION} https://github.com/nodejs/node.git ${NODE_BUILD_PATH} &&\
    cd ${NODE_BUILD_PATH} &&\
    ./configure && \
    make -j$(getconf _NPROCESSORS_ONLN) &&\
    make install &&\
    bash /tmp/yarn/install.sh &&\
    apk del --purge build-dependencies &&\
    rm -rf /tmp/* &&\
    rm -rf /root/* &&\
    rm -rf /var/cache/apk/*

RUN node --version
