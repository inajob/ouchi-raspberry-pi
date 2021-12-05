#!/bin/sh

cd `dirname $0`
mkdir out
sh makePhoto.sh > out/photo.js
python3 get.py  > out/schedule.js
curl https://www.jma.go.jp/bosai/forecast/data/forecast/010000.json > out/weather.json
echo "var weather = " > out/weather.js
cat out/weather.json >> out/weather.js
