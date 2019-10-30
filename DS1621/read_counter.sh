#!/bin/bash
DATA=$(i2cget -y 1 0x48 0xA8 )
echo ${DATA}
