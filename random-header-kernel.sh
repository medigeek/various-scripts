#!/bin/bash
number=$RANDOM
RANGE=100
let "number %= $RANGE"
cat `find /usr/src/linux-headers-*-generic/ -iname *.h | head -n $number | tail -n 1`
