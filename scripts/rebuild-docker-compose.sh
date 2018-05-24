#!/bin/bash

export $(egrep -v '^#' .env | xargs)

HOME=$(pwd)

echo $HOME

if [ ! -d 'repos' ]; then
    mkdir -p repos
fi

if [ ! -d 'repos/Armory' ]; then
    git clone https://github.com/AJOU-ANSI/Armory repos/Armory
else
    cd 'repos/Armory' && git pull && cd $HOME
fi

if [ ! -d 'repos/Barracks' ]; then
    git clone https://github.com/AJOU-ANSI/Barracks repos/Barracks
else
    cd 'repos/Barracks' && git pull && cd $HOME
fi

docker build -t golang-dep docker/dep
docker run --rm -v "$HOME/repos/Barracks":/go/src/Barracks -w /go/src/Barracks golang-dep /bin/sh -c ./scripts/build.sh

docker-compose build