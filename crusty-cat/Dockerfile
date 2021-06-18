FROM amd64/ubuntu:20.04

COPY src /opt/src
COPY commits.json /opt/src
COPY jansson-2.13.1 /opt/jansson

RUN apt-get update &&\
  apt-get install -y --no-install-recommends\
  make gcc automake binutils libglib2.0-dev libtool

RUN cd /opt/jansson &&\
  autoreconf -fi &&\
  ./configure &&\
  make &&\
  make check &&\
  make install &&\
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/jansson/libs" &&\
  ldconfig

RUN cd /opt/src &&\
  make

WORKDIR /opt/src

ENTRYPOINT ./jsondecoder
