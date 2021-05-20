#!/bin/bash
acap-build -m manifest.json -a build/fibb.wasm -a runner-wasmtime .
eap-install.sh 169.254.170.232 pass install