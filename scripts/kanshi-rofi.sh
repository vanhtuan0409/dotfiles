#!/bin/env bash
# Pick a kanshi display profile with rofi. kanshi has no "list profiles"
# command, so the names are parsed out of the config file; the active one
# (from `kanshictl status`) is marked and pre-selected.

config="${XDG_CONFIG_HOME:-$HOME/.config}/kanshi/config"
echo "using kanshi config: ${config}"

current=$(kanshictl status 2>/dev/null | sed -n 's/^Current profile: //p')

profiles=$(grep -oP '^\s*profile\s+\K[^ {]+' "$config")

# Mark the active profile so it is obvious which one is applied.
menu=$(while read -r p; do
    [ "$p" = "$current" ] && echo "$p (active)" || echo "$p"
done <<<"$profiles")

choice=$(printf '%s\n' "$menu" | rofi -dmenu -i -p "kanshi" -select "$current") || exit 0

choice=${choice% (active)}
echo "kanshi choice: ${choice}"
[ -n "$choice" ] && kanshictl switch "$choice"
