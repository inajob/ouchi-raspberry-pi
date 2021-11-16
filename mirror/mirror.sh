#!/bin/sh

cd `dirname $0`

SLACK=../slack/post.sh

if [ $(mount|grep /media/mystorage|wc -l) = 2 ]; then
	echo "INFO: detect two drives."
	mount |grep /media/mystorage
else
	echo "ERROR: don't detect two drives!!!"
	mount |grep /media/mystorage
	$SLACK ./mirror-error.json $(cat ../secrets/slack-token)
	exit -1
fi

date
echo "======== dry run ========"
echo
rsync -avn --delete /media/mystorage/nadrive/ /media/mystorage2/nadrive/
date
echo
echo "======== start rsync ========"
echo
date
rsync -av --delete /media/mystorage/nadrive/ /media/mystorage2/nadrive/
if [ $? = 0 ]; then
	$SLACK ./mirror-success.json $(cat ../secrets/slack-token)
else
	$SLACK ./mirror-error.json $(cat ../secrets/slack-token)
fi
date
echo
echo "======== end rsync ========"
echo
