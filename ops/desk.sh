#!/usr/bin/env sh

# syncs desk to fake ship
# defaults to syncing to %lure on ~lur
# e.g., to sync to %talk desk on ~net:
# ./desk.sh net talk

# fake ship name, defaults to lur
SHIP="${1:-lur}"
# path to urbit git repo
URBIT_REPO_PATH=~/dev/urbit/urbit
# path to lure git repo
REPO_PATH=~/dev/urbit/lure
# path to directory of fake ship piers
SHIP_PATH=~/dev/urbit/ships
# name of src desk in repo
SRC_DESK="${2:-desk}"
# name of dest desk on fake ship
DEST_DESK="${3:-lure}"

./sync.sh
