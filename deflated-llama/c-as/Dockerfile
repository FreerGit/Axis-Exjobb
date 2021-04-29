ARG ARCH=armv7hf
ARG VERSION=3.2
ARG UBUNTU_VERSION=20.04
ARG REPO=axisecp
ARG SDK=acap-sdk

FROM ${REPO}/${SDK}:${VERSION}-${ARCH}-ubuntu${UBUNTU_VERSION}

COPY deflated-llama/c-as/ /opt/app/
WORKDIR /opt/app

COPY wasi-sdks/wasi-sdk-12.0-linux /opt/app
ADD deflated-llama/c-as/build /opt/app

RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN curl https://get.wasmer.io -sSfL | sh
RUN /bin/bash -c "source /root/.bashrc"

RUN apt-get update

RUN apt-get install -y clang

# ENTRYPOINT [ "/bin/bash" ]
SHELL ["/bin/bash", "-c"]
CMD . /root/.wasmer/wasmer.sh \
    && echo "wasmer:" \
    && wasmer run build/optimized-wasi.wasm \
    && source /root/.bashrc \
    && export WASMTIME_HOME="$HOME/.wasmtime" \
    && export PATH="$WASMTIME_HOME/bin:$PATH" \
    && echo "wasmtime:" \
    && wasmtime run build/optimized-wasi.wasm \
    && cd src/wasmer \
    && make compile \
    && ./wasmer_test 25 11
