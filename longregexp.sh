#!/bin/bash

areacode='\([0-9]*\)'
state='\([A-Z][A-Z]\)'
cities='\([^@]*\)'

regexp="$areacode@$state@$cities@"
replacement='\1\t\2\t\3\n'

curl -s https://efficientlinux.com/areacodes.html | hxnormalize -x | hxselect -c -s'@' '#ac .ac, #ac .state, #ac .cities' | sed "s/$regexp/$replacement/g"