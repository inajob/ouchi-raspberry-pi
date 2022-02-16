#!/bin/bash

cd `dirname $0`

SLACK=../slack/post.sh
MAX_RETRY=5
n=0
until [ $n -ge $MAX_RETRY ]
do
# ====================
n=$[$n+1]
curl -v -XPOST -H "Content-Type: text/xml; charset=\"utf-8\""  -H "SOAPAction: \"urn:schemas-upnp-org:service:ContentDirectory:1#Browse\"" --data-binary @request.xml `cat ../secrets/tuner-address` > get.txt

python check-tuner.py && break

echo "ERROR"
sleep 10

# ====================
done

if [ $n -ge $MAX_RETRY ]; then
  echo "failed: ${@}" >&2
  $SLACK ./tuner-error.json $(cat ../secrets/slack-token)
  exit 1
else
  echo "OK"
  $SLACK ./tuner-success.json $(cat ../secrets/slack-token)
fi

