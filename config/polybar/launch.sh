#!/usr/bin/env bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#export MONITOR="$(xrandr -q | grep " connected" | grep primary | cut -d" " -f1)"
export MONITOR="${PRIMARY_MONITOR}"

polybar primary -c $HOME/dotfiles/config/polybar/config &
polybar bottom -c $HOME/dotfiles/config/polybar/config &
