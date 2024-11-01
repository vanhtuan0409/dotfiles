#!/bin/env bash

INTERNAL_MONITOR=DP-3
EXTERNAL_MONITOR=$(xrandr -q | grep " connected" | grep -v "${INTERNAL_MONITOR}" | awk '{print $1}')
SELECTED_WIDTH=1920

echo "Connected external monitor: ${EXTERNAL_MONITOR}"

function get_external_monitor_resolution(){
  xrandr -q | \
    jc --xrandr | \
    jq -r ".screens[0].devices[] | select(.device_name == \"${EXTERNAL_MONITOR}\") | .resolution_modes[] | select(.resolution_width == ${SELECTED_WIDTH}) | \"\(.resolution_width)x\(.resolution_height)\"" | \
    head -1
}

if [ ! -z "$EXTERNAL_MONITOR" ]
then
  resolution=$(get_external_monitor_resolution)
  echo "External monitor resolution: ${resolution}"
  xrandr --output $EXTERNAL_MONITOR --primary --mode ${resolution} --pos 0x0 \
    --output $INTERNAL_MONITOR --off
  export PRIMARY_MONITOR="$EXTERNAL_MONITOR"
else
  xrandr --output $INTERNAL_MONITOR --primary --mode 1920x1080 --pos 0x0
  export PRIMARY_MONITOR="$INTERNAL_MONITOR"
fi
