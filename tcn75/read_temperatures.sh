#!/bin/bash
twos() { x=$((16#$1)); [ "$x" -gt 127 ] && ((x=x-256)); echo "$x"; }
DATA=$(i2cset -y 1 0x4f 0 0x00; i2cget -y 1 0x4f 0 w)
if [ "${DATA:2:2}" = "80" ]
then
        DECIMALE=.5
else
        DECIMALE=.0
fi
TEMP=$(twos ${DATA:4})
echo ${TEMP}${DECIMALE}
