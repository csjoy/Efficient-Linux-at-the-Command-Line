#!/bin/bash
echo 'CDPATH=$HOME' $(cd && ls -d */ | sed -e 's@^@$HOME/@g' -e 's@/$@@') .. | tr ' ' ':'
