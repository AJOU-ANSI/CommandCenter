#!/bin/bash

HOME=$(pwd)

cd 'repos/Armory' && git pull && cd $HOME

docker-compose up -d --build web
