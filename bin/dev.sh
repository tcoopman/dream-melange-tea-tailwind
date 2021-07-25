#! /usr/bin/env bash

pkill -f "server/server.exe"
esy
npm run build
npm run build-css
npm run pack
esy start &
