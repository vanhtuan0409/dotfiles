#!/usr/bin/env bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done


polybar primary &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | grep -v primary | cut -d" " -f1); do
    MONITOR=$m polybar secondary &
  done
else
  polybar primary &
fi