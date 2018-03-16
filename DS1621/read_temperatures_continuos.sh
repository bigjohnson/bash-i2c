#!/bin/bash
RITARDO=1
twos() { x=$((16#$1)); [ "$x" -gt 127 ] && ((x=x-256)); echo "$x"; }
i2cset -y 1 0x48 0xac 0x00
i2cset -y 1 0x48 0xee
while true
do
        DATA=$(i2cget -y 1 0x48 0xAA w)
        if [ "${DATA:2:2}" = "80" ]
        then
                DECIMALE=.5
        else
                DECIMALE=.0
        fi
        TEMP=$(twos ${DATA:4})
        echo ${TEMP}${DECIMALE}
        sleep ${RITARDO}
done