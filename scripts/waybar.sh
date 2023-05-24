#!/bin/env bash

killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar -c ~/.config/waybar/top.jsonc &
waybar -c ~/.config/waybar/bottom.jsonc &
