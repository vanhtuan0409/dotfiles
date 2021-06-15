#!/usr/bin/env bash
if [ -f /tmp/whereami ]; then
  alacritty --working-directory=$(cat /tmp/whereami)
else
  alacritty
fi
