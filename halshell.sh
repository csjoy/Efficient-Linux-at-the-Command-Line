#!/bin/bash
# Print a prompt
echo -n '$ '
# Read the user's input in a loop. Exit when the user presses Ctrl+C.
while read line; do
  echo "I'm sorry, I'm afraid I can't do that"
  # Print the next prompt
  echo -n '$ '
done
