#!/usr/bin/env bash
# Launch the `primary` (top) and `bottom` polybar bars on EVERY connected
# monitor. Polybar binds one bar instance per monitor -- there is no single
# instance that spans monitors -- so "show on all monitors" means spawning
# each bar once per output. This is the launcher invoked by polybar.service.
#
# Replaces the old MONITOR-env scheme: setupmonitor.sh no longer resolves a
# single primary output to hand to polybar. polybar enumerates the live outputs
# itself, so the bars simply follow whatever xrandr left active (external when
# docked, internal otherwise) without any name being threaded through systemd.

config="$HOME/dotfiles/config/polybar/config"

# Tear down bars from a previous run so a restart does not stack instances.
polybar-msg cmd quit >/dev/null 2>&1 || true

for monitor in $(polybar --list-monitors | cut -d: -f1); do
  MONITOR="$monitor" polybar primary -c "$config" &
  MONITOR="$monitor" polybar bottom  -c "$config" &
done

# Stay alive as the unit's main process so its lifetime tracks the bars;
# KillMode=control-group then tears every bar down when the service stops.
wait
