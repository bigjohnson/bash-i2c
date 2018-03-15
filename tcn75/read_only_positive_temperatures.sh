
#!/bin/bash
DATA=$(i2cset -y 1 0x4f 0 0x00; i2cget -y 1 0x4f 0 w)
if [ "${DATA:2:2}" = "80" ]
then
        DECIMALE=.5
else
        DECIMALE=.0
fi
echo $((16#${DATA:4}))${DECIMALE}
