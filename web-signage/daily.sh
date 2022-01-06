#!/bin/sh

cd `dirname $0`
mkdir out
echo "var birthDate = '$(cat ../secrets/birthdate)';" > out/birthdate.js
sh makePhoto.sh |tee out/photo.js
python3 get.py  > out/schedule.js
curl https://www.jma.go.jp/bosai/forecast/data/forecast/010000.json > out/weather.json
echo "var weather = " > out/weather.js
cat out/weather.json >> out/weather.js

echo "var disk = " > out/disk.js
jq -n --arg f "`df -h /media/mystorage|tail -1|awk '{print $3 "/" $2 " " $5}'`" '.file = $f' >> out/disk.js
