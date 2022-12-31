#!/bin/bash
cat domains.txt | while read domain; do
  ./check-expiry.sh "$domain"
  sleep 5
done
