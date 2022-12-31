#!/bin/bash
PROGRAM=$(basename $0)
DATABASE=$HOME/Code/linux/vault.gpg

if [ $# -ne 1 ]; then
  >&2 echo "$PROGRAM: look up passwords"
  >&2 echo "Usage: $PROGRAM string"
  exit 1
fi

searchstring="$1"
decrypted=$(gpg -d -q "$DATABASE")
match=$(echo "$decrypted" | awk '$3~/^'$searchstring'$/')

if [ -z "$match" ]; then
  match=$(echo "$decrypted" | awk "/$searchstring/")
fi

if [ -z "$match" ]; then
  >&2 echo "$PROGRAM: no matches for '$searchstring'"
  exit 1
fi

echo "$match"
