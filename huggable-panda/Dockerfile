FROM axisecp/acap-sdk:3.3-armv7hf-ubuntu20.04

# Building the ACAP application
COPY ./build /opt/app/
WORKDIR /opt/app
RUN . /opt/axis/acapsdk/environment-setup* && create-package.sh
