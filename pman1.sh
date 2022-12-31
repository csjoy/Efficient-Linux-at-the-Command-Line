#!/bin/bash
PROGRAM=$(basename $0)
DATABASE=$HOME/Code/linux/vault

if [ $# -ne 1 ]; then
  >&2 echo "$PROGRAM: look up password by string"
  >&2 echo "Usage: $PROGRAM string"
  exit 1
fi

searchstring="$1"

grep "$searchstring" "$DATABASE"
if [ $? -ne 0 ]; then
  >&2 echo "$PROGRAM: no matches for '$searchstring'"
  exit 1
fi
