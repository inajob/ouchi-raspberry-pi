file=$1
token=$2

curl -X POST \
  -d @${file}  \
https://hooks.slack.com/services/${token}
echo
