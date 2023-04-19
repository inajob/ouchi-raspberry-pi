#!/bin/sh
URL="https://github.com/inajob/sleep-music/raw/master/turkish-march.mp3"
curl -v -X POST -d "text=${URL}" http://localhost:8091/google-home-notifier
