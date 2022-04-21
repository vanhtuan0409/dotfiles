#!/bin/env bash

dev=${DEVICE:-BAT0}
bat_threshold=${BAT_THRESHOLD:-15}

while true; do
  bat_status=$(cat /sys/class/power_supply/$dev/status)
  bat_level=$(cat /sys/class/power_supply/$dev/capacity)

  if [[ "$bat_status" == "Discharging" && $bat_level -le $bat_threshold ]]; then
    notify-send -u critical "Battery low"
  fi

  sleep 300
done
