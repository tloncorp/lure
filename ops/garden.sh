#!/usr/bin/env sh

# syncs landscape (fka garden / grid) to fake ship
# defaults to syncing to ~lur
# e.g., to sync to %garden desk on ~net:
# ./garden.sh net

# fake ship name, defaults to lur
SHIP="${1:-lur}"
# path to urbit git repo
URBIT_REPO_PATH=~/dev/urbit/urbit
# path to landscape git repo
REPO_PATH=~/dev/urbit/landscape
# path to directory of fake ship piers
SHIP_PATH=~/dev/urbit/ships
# name of src desk in repo
SRC_DESK="${2:-desk}"
# name of dest desk on fake ship
DEST_DESK="${3:-garden}"

./sync.sh
