#!/bin/bash

PROGRAM=$(basename $0)
DATABASE=$HOME/Code/linux/vault.gpg

load_password() {
  echo "$1" | cut -f1 | tr -d '\n' | xclip -selection clipboard
  echo "$1" | cut -f2 | tr -d '\n' | xclip -selection primary

  echo "$PROGRAM: Found" $(echo "$1" | cut -f3- --output-delimiter=': ')
  echo "$PROGRAM: username and password loaded into X selections"
  # (sleep 30 && echo -n | xclip -selection primary) &
}

if [ $# -ne 1 ]; then
  >&2 echo "$PROGRAM: look up passwords"
  >&2 echo "Usage: $PROGRAM string"
  exit 1
fi

searchstring="$1"
decrypted=$(gpg -d -q "$DATABASE")

if [ $? -ne 0 ]; then
  >&2 echo "$PROGRAM: could not decryp $DATABASE"
  exit 1
fi

match=$(echo "$decrypted" | awk '$3~/^'$searchstring'$/')
if [ -n "$match" ]; then
  load_password "$match"
  exit $?
fi

match=$(echo "$decrypted" | awk "/$searchstring/")
if [ -z "$match" ]; then
  >&2 echo "$PROGRAM: no matches"
  exit 1
fi

count=$(echo "$match" | wc -l)

case "$count" in
  0)
    >&2 echo "$PROGRAM: no matches"
    exit 1
    ;;
  1)
    load_password "$match"
    exit $?
    ;;
  *)
    >&2 echo "$PROGRAM: multiple matches for the following keys:"
    echo "$match" | cut -f3
    >&2 echo "$PROGRAM: rerun this script with one of the keys"
    exit
    ;;
esac
