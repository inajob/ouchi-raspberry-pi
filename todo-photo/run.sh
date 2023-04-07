#/bin/bash

cd `dirname $0`

# set UXGA
curl $(cat ../secrets/todo-camera-address)/control?var=framesize&val=10
sleep 1
curl $(cat ../secrets/todo-camera-address)/capture -o todo.jpg
sleep 1
curl $(cat ../secrets/todo-camera-address)/capture -o todo.jpg
sleep 1
curl $(cat ../secrets/todo-camera-address)/capture -o todo.jpg

convert todo.jpg -rotate 180 -fill white -pointsize 25 -font Helvetica -draw "text 20,20 '`date`'" -background white todo.jpg

for f in $(rclone --config=../secrets/rclone.conf lsf "google drive:/ouchi-raspberry-pi/"); do
  echo "delete $f"
  rclone --config=../secrets/rclone.conf delete "google drive:/ouchi-raspberry-pi/$f"
done;

rclone --config=../secrets/rclone.conf copyto todo.jpg "google drive:/ouchi-raspberry-pi/todo-$(date "+%Y%m%d-%H%M").jpg"
