#!/bin/bash
echo "My name is $USER" > /tmp/outfile
echo "My current directory is $PWD" >> /tmp/outfile
echo "Guess how many lines are in the file /etc/hosts?" >> /tmp/outfile
wc -l /etc/hosts >> /tmp/outfile
echo "Goodbye for now" >> /tmp/outfile
