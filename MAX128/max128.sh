#!/bin/bash
MAX128ADDRESS=0x28
I2CBUS=1

# Control bit
SARTBIT=128

# Cannels selection bits
# Channel 0
CHANNEL=0
# Channel 1
#CHANNEL=16
# Channel 2
#CHANNEL=32
# Channel 3
#CHANNEL=48
# Channel 4
#CHANNEL=64
# Channel 5
#CHANNEL=80
# Channel 6
#CHANNEL=96
# Channel 7
#CHANNEL=112

# RNG
# Full scale
RNG=8
# Half scale
# RNG=0

#Bipolar ( actually bipolar conversion is unimplmented )
# Unipolar
BIPOLAR=0
# Bipolar
#BIPOLAR=4

# Power select ( tested only with Normal operation )
# Normal operation
POWERDOWN=0
# Standby Power-Down Mode (STBYPD)
#POWERDOWN=2
# Full Power-Down Mode (FULLPD)
#POWERDOWN=3

DECCONTROL=$(( ${SARTBIT} | ${CHANNEL} | ${RNG} | ${BIPOLAR} | ${POWERDOWN} ))

CONTROL=$( printf '%x' ${DECCONTROL} )

READ=$(i2c-read-register -b ${I2CBUS} -d ${MAX128ADDRESS} 0x${CONTROL} 2)
#echo ${READ}
MSB=${READ:0:2}
LSB=${READ:3:2}
#echo $MSB
#echo $LSB
ALL=$(echo $(( $(($((0x$LSB))>>4)) + $(($((0x$MSB))<<4)) )))
#echo $ALL

if [ "${ALL}" -lt 10 ]
then
        PRE=0.00
        POST=${ALL}

elif [ "${ALL}" -lt 100 ]
then
        PRE=0.0
        POST=${ALL}
elif [ "${ALL}" -lt 1000 ]
then
        PRE=0.
        POST=${ALL}

else
        PRE=${ALL:0:1}.
        POST=${ALL:1}
fi

echo ${SIGN}${PRE}${POST}
