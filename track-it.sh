#!/bin/bash

PROGRAM=$(basename $0)
DATAFILE=packages.txt
BROWSER="google-chrome"
errors=0

cat "$DATAFILE" | while read line; do
  track=$(echo "$line" | awk '{print $1}')
  service=$(echo "$line" | awk '{print $2}')
  case "$service" in
    UPS)
      $BROWSER "https://www.ups.com/track?tracknum=$track" &
      ;;
    FedEx)
      $BROWSER "https://www.fedex.com/fedextrack/?trknbr=$track" &
      ;;
    USPS)
      $BROWSER "https://tools.usps.com/go/TrackConfirmAction?tLabels=$track" &
      ;;
    *)
      >&2 echo "$PROGRAM: Unknown service '$service'"
      errors=1
      ;;
  esac
done
exit $errors