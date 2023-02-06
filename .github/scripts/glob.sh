#!/usr/bin/env bash

set -e
set -o pipefail

SHIP=$1
PASSWORD=$2
BRANCH=$3
DIR=$4
URL=$5

# XX: Do we need '--ignore-existing' opts for dev rsyncs?
CMD_FILE=`mktemp --tmpdir "lure.XXXXXX"`
CMDS='
COOKIE_JAR=`mktemp --tmpdir "lure-cookie.XXXXXX"`
CURL_CMD=`mktemp --tmpdir "lure-upload.XXXXXX"`
ISOLATION=`mktemp -d -t`
SOURCE_REPO=`mktemp -d -t`

git clone --depth=1 --branch '$BRANCH' https://github.com/tloncorp/lure.git $SOURCE_REPO

mv '$DIR' $ISOLATION
cd $ISOLATION

curl --cookie-jar $COOKIE_JAR --data-raw "password='$PASSWORD'" https://'$URL'/~/login

echo "curl --cookie $COOKIE_JAR" >> $CURL_CMD
echo "--form \"desk=lure\"" >> $CURL_CMD
find ./ -type f | sed "s:^\./\(.*\)$:--form \"glob=@\1;filename=\1\":g" | sed "s:\.js\"$:.js;type=text/javascript\":g" | sed "s:\.css\"$:.css;type=text/css\":g" >> $CURL_CMD
echo "https://'$URL'/docket/upload" >> $CURL_CMD
eval `cat $CURL_CMD | tr "\n" " "`

cd $HOME

rm -rf $SOURCE_REPO
rm -rf $ISOLATION
rm -rf $CURL_CMD
rm -rf $COOKIE_JAR
'
echo "$CMDS" >> "$CMD_FILE"

gcloud compute ssh \
  --internal-ip \
  --project $GCP_PROJECT \
  --zone $GCP_ZONE \
  --ssh-flag="-T" \
  --command "$(sed '/^$/d' $CMD_FILE | sed ':a;N;s/\n/ && /;$!ba')" \
  $GCP_USER@$SHIP

echo "%lure glob deployed to $SHIP"
