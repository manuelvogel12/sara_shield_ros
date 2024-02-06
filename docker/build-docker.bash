#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR

docker build --tag manuelvogel12/sara_shield_panda:latest . -f $DIR/Dockerfile "$@"
