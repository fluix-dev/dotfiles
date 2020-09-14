#!/bin/bash

#
# Script that runs on suspend and resume which changes the colour of LED strip.
# The colours are set with [r, b, g]
#
if [ "${1}" == "pre" ]; then
  echo -n "[0, 0, 0]" > /dev/ttyACM0
elif [ "${1}" == "post" ]; then
  echo -n "[255, 0, 64]" > /dev/ttyACM0
fi
