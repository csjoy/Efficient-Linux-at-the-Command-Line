#!/bin/bash
PROGRAM=$(basename $0)
DATABASE=$HOME/Code/linux/vault

if [ $# -ne 1 ]; then
  >&2 echo "$PROGRAM: look up passwords"
  >&2 echo "Usage: $PROGRAM string"
  exit 1
fi

searchstring="$1"

match=$(awk '$3~/^'$searchstring'$/' "$DATABASE")

if [ -z "$match" ]; then
  match=$(awk "/$searchstring/" "$DATABASE")
fi

if [ -z "$match" ]; then
  >&2 echo "$PROGRAM: no matches for '$searchstring'"
  exit 1
fi

echo "$match"
