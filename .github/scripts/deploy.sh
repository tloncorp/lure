#!/usr/bin/env bash

set -e
set -o pipefail

SHIP=$1
BRANCH=$2

CMD_FILE=`mktemp --tmpdir "lure.XXXXXX"`
CMDS='
LURE_PATH="'$SHIP'/lure"

SOURCE_REPO=`mktemp -d -t`
URBIT_REPO=`mktemp -d -t`
LANDSCAPE_REPO=`mktemp -d -t`

git clone --depth=1 --branch '$BRANCH' https://github.com/tloncorp/lure.git $SOURCE_REPO
git clone --depth=1 --branch master https://github.com/urbit/urbit.git $URBIT_REPO
git clone --depth=1 --branch master https://github.com/tloncorp/landscape.git $LANDSCAPE_REPO

curl -s --data '"'"'{"source":{"dojo":"+hood/mount %lure"},"sink":{"app":"hood"}}'"'"' http://localhost:12321 > /dev/null

rsync -avL --delete "$SOURCE_REPO/desk/" $LURE_PATH
rsync -avL "$URBIT_REPO/pkg/base-dev/" $LURE_PATH
rsync -avL "$LANDSCAPE_REPO/desk-dev/lib/docket.hoon" "$LURE_PATH/lib"
rsync -avL "$LANDSCAPE_REPO/desk-dev/sur/docket.hoon" "$LURE_PATH/sur"
rsync -avL "$LANDSCAPE_REPO/desk-dev/mar/docket-0.hoon" "$LURE_PATH/mar"

curl -s --data '"'"'{"source":{"dojo":"+hood/commit %lure"},"sink":{"app":"hood"}}'"'"' http://localhost:12321 > /dev/null
curl -s --data '"'"'{"source":{"dojo":"+hood/unmount %lure"},"sink":{"app":"hood"}}'"'"' http://localhost:12321 > /dev/null

rm -rf $SOURCE_REPO
rm -rf $URBIT_REPO
rm -rf $LANDSCAPE_REPO
'
echo "$CMDS" >> $CMD_FILE

gcloud compute ssh \
  --internal-ip \
  --project $GCP_PROJECT \
  --zone $GCP_ZONE \
  --ssh-flag="-T" \
  --command "$(sed '/^$/d' $CMD_FILE | sed ':a;N;s/\n/ && /;$!ba')" \
  $GCP_USER@$SHIP

echo "%lure OTA performed for $SHIP"
