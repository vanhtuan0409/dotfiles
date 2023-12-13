#!/bin/env bash

INTERNAL_MONITOR=DP-3
EXTERNAL_MONITOR=DP-1

xrandr -q | grep "$EXTERNAL_MONITOR" | grep 1920x1200 > /dev/null
resolution_check_status=$?

echo "Check external monitor resolution 1920x1200 status: $resolution_check_status"

if test $resolution_check_status -eq 0
then
  xrandr --output $EXTERNAL_MONITOR --primary --mode 1920x1200 --pos 0x0 \
    --output $INTERNAL_MONITOR --off
  export PRIMARY_MONITOR="$EXTERNAL_MONITOR"
else
  xrandr --output $INTERNAL_MONITOR --primary --mode 1920x1080 --pos 0x0
  export PRIMARY_MONITOR="$INTERNAL_MONITOR"
fi
