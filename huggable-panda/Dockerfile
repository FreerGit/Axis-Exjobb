FROM axisecp/acap-sdk:3.3-aarch64-ubuntu20.04

# Building the ACAP application
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN /bin/bash -c "source /root/.bashrc"

RUN apt-get update

RUN apt-get install -y clang

# ENTRYPOINT [ "/bin/bash" ]

COPY ./app /opt/app/
COPY ./wasmtime/crates/ /opt/app/wasmtime/crates/

COPY ./wasmtime/target/release/libwasmtime.a /opt/app/wasmtime/target/release/libwasmtime.dylib
WORKDIR /opt/app
RUN . /opt/axis/acapsdk/environment-setup* && create-package.sh
# RUN create-package.sh
SHELL ["/bin/bash", "-c"]