#!/bin/env bash

INTERNAL_MONITOR=eDP-1
EXTERNAL_MONITOR=DP-1-1
DPI=142

xrandr -q | grep 1920x1200 > /dev/null
resolution_check_status=$?

echo "Check 1920x1200 status: $resolution_check_status"

if test $resolution_check_status -eq 0
then
  xrandr --dpi $DPI --output $INTERNAL_MONITOR --primary --mode 1680x1050 --scale 1.14x1.14 --pos 0x0 --rotate normal \
    --output $EXTERNAL_MONITOR --auto --mode 1920x1200 --same-as $INTERNAL_MONITOR
else
  xrandr --dpi $DPI --output $INTERNAL_MONITOR --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output $EXTERNAL_MONITOR --auto --mode 1920x1080 --same-as $INTERNAL_MONITOR
fi
