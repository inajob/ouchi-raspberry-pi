#!/bin/sh

cd `dirname $0`
mkdir out
sh makePhoto.sh > out/photo.js
python3 get.py  > out/schedule.js
