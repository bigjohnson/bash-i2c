#!/bin/bash
I2CPORT=1
MCP23017=0x20
IODIR=0x01
OLAT=0x15
i2cset -y ${I2CPORT} ${MCP23017} ${IODIR} 0x00
trap "{ i2cset -y ${I2CPORT} ${MCP23017} ${OLAT} 0; }" EXIT
while true
do
        for LED in 1 2 4 8 16 32 64 128
        do
        i2cset -y ${I2CPORT} ${MCP23017} ${OLAT} ${LED}
        done
done
