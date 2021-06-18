FROM amd64/ubuntu:20.04
ENV TZ=Europe/Stockholm
ENV UBUNTU_FRONTEND=noninteractive 


COPY src /opt/src
COPY commits.json /opt/src

COPY jansson-2.13.1 /opt/jansson

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update &&\
  apt-get install -y --no-install-recommends\
  make gcc automake binutils libglib2.0-dev python3-pip libtool wget unzip xz-utils cmake nodejs

RUN cd /opt/ &&\
    wget https://github.com/emscripten-core/emsdk/archive/refs/heads/main.zip --no-check-certificate &&\
    wget https://digip.org/jansson/releases/jansson-2.13.1.tar.gz --no-check-certificate &&\
    tar xvf jansson-2.13.1.tar.gz &&\
    unzip main.zip

RUN cd /opt/emsdk-main &&\
    ./emsdk install latest &&\
    ./emsdk activate latest &&\
    # echo 'export PATH=$PATH:/opt/emsdk-main:/opt/emsdk-main/node/14.15.5_64bit/bin:/opt/emsdk-main/upstream/emscripten' >> ~/.bashrc 
    export PATH=$PATH:/opt/emsdk-main &&\
    export PATH=$PATH:/opt/emsdk-main/node/14.15.5_64bit/bin &&\
    export PATH=$PATH:/opt/emsdk-main/upstream/emscripten &&\
    cd /opt/jansson-2.13.1 &&\
    emcmake cmake . &&\
    emmake make &&\
    emmake make install &&\
    cd /opt/src &&\
    emcc -lnodefs.js parse-for-wasm.c -ljansson -L/opt/jansson-2.13.1/lib -I/opt/vdo/jsontest/jansson-2.13.1/bin -o parse.js

WORKDIR /opt/src

ENTRYPOINT node parse.js