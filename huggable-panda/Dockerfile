FROM axisecp/acap-sdk:3.3-aarch64-ubuntu20.04

# Building the ACAP application
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN /bin/bash -c "source /root/.bashrc"

RUN apt-get update

RUN apt-get install -y clang

# ENTRYPOINT [ "/bin/bash" ]

COPY ./app /opt/app/
COPY ./our_build /opt/app/build

# COPY ./wasmtime/crates/ /opt/app/wasmtime/crates/

# COPY ./wasmtime/target/release/libwasmtime.a /opt/app/wasmtime/target/release/libwasmtime.dylib
WORKDIR /opt/app
RUN tar -xvf wasmtime-c-api-0.26-linux.tar.xz -C /opt/app/
RUN rm -f wasmtime-c-api-0.26-linux.tar.xz
RUN mv wasmtime-c-api-0.26-linux wasmtime
RUN mv /opt/app/src/* /opt/app/

RUN . /opt/axis/acapsdk/environment-setup* 
# RUN create-package.sh
SHELL ["/bin/bash", "-c"]