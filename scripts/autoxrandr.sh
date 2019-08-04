#!/bin/bash

laptop=eDP1
vga=DP1
hdmi=HDMI1
virtual=VIRTUAL1

xrandr --auto --output $laptop --primary --mode 1600x900 --rotate normal --rate 60
if xrandr | grep "$hdmi connected"; then
  xrandr --auto --output $hdmi --mode 1920x1080 --rotate normal --rate 60 --right-of $laptop
fi
