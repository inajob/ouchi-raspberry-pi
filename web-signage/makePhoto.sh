PHOTO_PATH=$(cat ../secrets/photo-path)
echo "var photoList = ["
IFS='
'
for line in `find /media/mystorage/${PHOTO_PATH} -type f|grep -e '.*\.\(HEIC\|jpg\|JPG\)'`; do
  d=`ls --full-time "$line" | awk '{print $6 " " $7}'`

  # d=`exiftool $line|grep "Create Date"|head -1|awk '{gsub(":","/",$4); print $4 " " $5}'`
  echo "{'name':'$line', 'date':'$d'},";
done;
echo "];"
