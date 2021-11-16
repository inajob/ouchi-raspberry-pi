PHOTO_PATH=$(cat ../secrets/photo-path)
echo "var photoList = ["
for line in `find /media/mystorage/${PHOTO_PATH} -type f|grep -e '.*\.\(HEIC\|jpg\|JPG\)'`; do
  echo "'$line',";
done;
echo "];"
