#!/bin/bash

#
# Script that runs on suspend and resume which changes the colour of LED strip.
#
if [ "${1}" == "pre" ]; then
  echo -n "[0, 0, 0]" > /dev/ttyACM0
elif [ "${1}" == "post" ]; then
  echo -n "[30, 255, 0]" > /dev/ttyACM0
fi
cat /dev/ttyACM0 > /dev/null
