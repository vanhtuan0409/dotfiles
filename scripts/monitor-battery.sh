#!/bin/env bash

# Single check. Scheduling is handled by monitor-battery.timer (every 5min).
dev=${DEVICE:-BAT0}
bat_threshold=${BAT_THRESHOLD:-15}

bat_status=$(cat /sys/class/power_supply/$dev/status)
bat_level=$(cat /sys/class/power_supply/$dev/capacity)

if [[ "$bat_status" == "Discharging" && $bat_level -le $bat_threshold ]]; then
  notify-send -u critical "Battery low"
fi
