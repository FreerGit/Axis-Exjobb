ARG ARCH=armv7hf
ARG VERSION=3.2
ARG UBUNTU_VERSION=20.04
ARG REPO=axisecp
ARG SDK=acap-sdk

FROM ${REPO}/${SDK}:${VERSION}-${ARCH}-ubuntu${UBUNTU_VERSION}

# Building the ACAP application
COPY . /opt/app/
WORKDIR /opt/app
# RUN . /opt/axis/acapsdk/environment-setup* && create-package.sh

RUN apt-get install -y curl

RUN curl https://get.wasmer.io -sSfL | sh

CMD . /root/.wasmer/wasmer.sh && wapm install cowsay && wapm run cowsay "WASMTIME"
