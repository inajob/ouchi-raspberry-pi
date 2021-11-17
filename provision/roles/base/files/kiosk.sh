#!/bin/sh

xset s off
xset -dpms
xset s noblank
/home/pi/work/google-home/run-server.sh &
chromium http://localhost/web-signage --kiosk --disable-features=Translate
