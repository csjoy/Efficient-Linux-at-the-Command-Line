#!/bin/bash
if [ -n "$1" ]; then
  grep -iw "$1" areacodes.txt
fi
