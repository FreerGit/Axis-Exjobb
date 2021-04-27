#!/bin/bash
version="wasi-sdk-12.0-linux"
while getopts ml flag
do
    case "${flag}" in
        m) version="wasi-sdk-12.0-macos" ;;
        l) version="wasi-sdk-12.0-linux" ;;
    esac
done

function setup {
    skipcreation=false
    if [[ -d "/opt/wasi-sdk" ]]; then
        echo "/opt/wasi-sdk exists, do you want to update? yn"
        while [ true ] ; do
            read -n 1 $key
            if [ $key = "y" ]; then
                $(eval 'sudo rm -rf /opt/wasi-sdk')
                break ;
            else
                skipcreation=true
                break ;
            fi
        done
    fi

    if [ !skipcreation ]; then
        eval 'sudo cp -r ./${version} /opt/wasi-sdk'
    fi
}

setup version