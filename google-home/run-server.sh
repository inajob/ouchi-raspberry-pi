cd `dirname $0`
while :
do
  node ../google-home-notifier/example.js
  echo "server process down.. restart.."
  sleep 3
done
