#!/usr/bin/env bash

if (warp-cli status | grep Connected); then
  warp-cli disconnect
else
  warp-cli connect
fi

sleep 0.1
polybar-msg action warp hook 0
