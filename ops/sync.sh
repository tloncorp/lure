#!/usr/bin/env sh

# syncs desk to fake ship

rsync -avL --delete $URBIT_REPO_PATH/pkg/base-dev/* $SHIP_PATH/$SHIP/$DEST_DESK/
rsync -avL $URBIT_REPO_PATH/pkg/garden-dev/* $SHIP_PATH/$SHIP/$DEST_DESK/
rsync -avL $REPO_PATH/$SRC_DESK/* $SHIP_PATH/$SHIP/$DEST_DESK/
