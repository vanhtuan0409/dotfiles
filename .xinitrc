#!/bin/env bash
# Symlinked to ~/.xinitrc. Reached via the greetd/tuigreet X path
# (xsession-wrapper.sh -> startx ~/.xinitrc <session>). lightdm does NOT use this
# file; it sources ~/.xsession on its own. One env source of truth, two login paths.
. "$HOME/.xsession"
exec "${1:-i3}"

# vi: ft=bash
