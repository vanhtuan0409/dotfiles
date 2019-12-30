#!/usr/bin/env bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  MONITOR=$m polybar primary -c $HOME/dotfiles/config/polybar/config &
  MONITOR=$m polybar bottom -c $HOME/dotfiles/config/polybar/config &
done
