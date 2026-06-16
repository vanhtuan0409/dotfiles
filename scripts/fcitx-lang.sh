#!/usr/bin/env bash

# Print the language code of the current fcitx5 input method (e.g. ja, en, zh).

im=$(fcitx5-remote -n 2> /dev/null) || exit 0
[ -z "$im" ] && exit 0

busctl --user --json=short call \
    org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1 AvailableInputMethods \
    | jq -r --arg im "$im" '.data[0][] | select(.[0]==$im) | .[5]'
