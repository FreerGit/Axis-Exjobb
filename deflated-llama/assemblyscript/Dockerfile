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

RUN apt-get update && apt-get install -y curl

RUN curl --silent --location https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y \
  nodejs

RUN npm run asbuild:optimized

CMD ["node", "--experimental-wasm-bigint", "tests/index.js"]