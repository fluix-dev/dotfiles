#!/bin/bash

#
# Script to change the volume and play an audible tone.
#
VOL=$1

amixer -q sset Master $VOL
if [ ${VOL: -1} == "+" ]; then
  play -nq -t pulseaudio synth 0.05 sin 440 gain -20
else
  play -nq -t pulseaudio synth 0.05 sin 380 gain -20
fi
