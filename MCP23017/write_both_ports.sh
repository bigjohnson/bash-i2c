#!/bin/bash
I2CPORT=1
MCP23017=0x20
IODIRA=0x00
IODIRB=0x01
OLATA=0x14
OLATB=0x15

# MCP23017 setup
i2cset -y ${I2CPORT} ${MCP23017} ${IODIRA} 0x00
i2cset -y ${I2CPORT} ${MCP23017} ${OLATA} 0x00
i2cset -y ${I2CPORT} ${MCP23017} ${IODIRB} 0x00
i2cset -y ${I2CPORT} ${MCP23017} ${OLATB} 0x00

# Power off all led on exit...
trap "{ i2cset -y ${I2CPORT} ${MCP23017} ${OLATA} 0x00; i2cset -y ${I2CPORT} ${MCP23017} ${OLATB} 0x00; }" EXIT

while true
do
        for PORT in ${OLATA} ${OLATB}
        do
                for LED in 1 2 4 8 16 32 64 128 0
                do
                        i2cset -y ${I2CPORT} ${MCP23017} ${PORT} ${LED}
                done
        done
done
