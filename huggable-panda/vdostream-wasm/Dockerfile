ARG ARCH=armv7hf
FROM axisecp/acap-sdk:3.3-${ARCH}-ubuntu20.04

# Building the ACAP application
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN /bin/bash -c "source /root/.bashrc"

RUN apt-get update
RUN apt-get install -y clang
RUN apt-get install -y llvm

COPY ./app /opt/app/
COPY wasmtime-v0.26.0-aarch64-linux-c-api /opt/app/wasmtime-v0.26.0-aarch64-linux-c-api
# COPY ./our_build /opt/app/build

WORKDIR /opt/app

RUN mkdir wasmtime

RUN mv wasmtime-v0.26.0-aarch64-linux-c-api/* wasmtime/

RUN rm -rf wasmtime-v0.26.0-aarch64-linux-c-api

RUN mv /opt/app/src/* /opt/app/

RUN . /opt/axis/acapsdk/environment-setup*
#&& create-package.sh

#copy over the interepter and all of its .o files
RUN cp /usr/aarch64-linux-gnu/lib/* /lib/
SHELL ["/bin/bash", "-c"]