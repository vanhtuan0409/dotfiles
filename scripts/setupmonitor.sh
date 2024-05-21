#!/bin/env bash

INTERNAL_MONITOR=DP-3
EXTERNAL_MONITOR=$(xrandr -q | grep " connected" | grep -v "${INTERNAL_MONITOR}" | awk '{print $1}')

echo "Connected external monitor: ${EXTERNAL_MONITOR}"

if [ ! -z "$EXTERNAL_MONITOR" ]
then
  resolution=$(xrandr -q | grep -A 1 $EXTERNAL_MONITOR | tail -1 | awk '{print $1}')
  echo "External monitor resolution: ${resolution}"
  xrandr --output $EXTERNAL_MONITOR --primary --mode ${resolution} --pos 0x0 \
    --output $INTERNAL_MONITOR --off
  export PRIMARY_MONITOR="$EXTERNAL_MONITOR"
else
  xrandr --output $INTERNAL_MONITOR --primary --mode 1920x1080 --pos 0x0
  export PRIMARY_MONITOR="$INTERNAL_MONITOR"
fi
