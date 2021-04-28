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
RUN curl --silent --location https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y \
  nodejs

RUN curl https://get.wasmer.io -sSfL | sh

RUN npm run asbuild:optimized

CMD . /root/.wasmer/wasmer.sh && wasmer run build/optimized.wasm
