#!/bin/bash
I2CPORT=1
MCP23017=0x20
IODIR=0x00
OLAT=0x14

# MCP23017 setup
i2cset -y ${I2CPORT} ${MCP23017} ${IODIR} 0x00
i2cset -y ${I2CPORT} ${MCP23017} ${OLAT} 0 0 i

# Power off all led on exit...
trap "{ i2cset -y ${I2CPORT} ${MCP23017} ${OLAT} 0 0 i; }" EXIT

while true
do
        for LED in 1 2 4 8 16 32 64 128
        do
        i2cset -y ${I2CPORT} ${MCP23017} ${OLAT} ${LED} ${LED} i
        done
done
