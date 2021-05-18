FROM axisecp/acap-sdk:3.3-armv7hf-ubuntu20.04

# Building the ACAP application
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN /bin/bash -c "source /root/.bashrc"

RUN apt-get update

RUN apt-get install -y clang

COPY ./app /opt/app/
COPY ./our_build /opt/app/build

RUN mkdir wasmer
RUN mkdir wasmtime

# x86_64 architecture 
RUN tar -xvf wasmer-linux-amd64.tar.gz -C /opt/app/wasmer 
RUN tar -xf wasmtime-v0.26.0-x86_64-linux-c-api.tar.xz

RUN mv wasmtime-v0.26.0-x86_64-linux-c-api/* wasmtime/

RUN rm -f wasmer-linux-amd64.tar.gz
RUN rm -rf wasmtime-v0.26.0-x86_64-linux-c-api

RUN rm -f wasmer-linux-aarch64.tar.gz
RUN rm -f wasmtime-v0.26.0-aarch64-linux-c-api.tar.xz
RUN rm -f wasmtime-v0.26.0-x86_64-linux-c-api.tar.xz

RUN mv /opt/app/src/* /opt/app/

RUN . /opt/axis/acapsdk/environment-setup* 

#copy over the interepter and all of its .o files
# RUN cp /usr/aarch64-linux-gnu/lib/* /lib/

SHELL ["/bin/bash", "-c"]