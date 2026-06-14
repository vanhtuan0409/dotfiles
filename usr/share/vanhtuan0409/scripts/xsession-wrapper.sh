#!/bin/env bash
# Generic X-session wrapper for greetd/tuigreet.
# Live at /usr/share/vanhtuan0409/scripts/xsession-wrapper.sh (repo symlink).
# greetd execs this as the logging-in user (PAM sets $HOME), so it is user-generic.
# Args ($@) = the session command tuigreet selected, e.g. "i3".

# greetd execs this non-login, so source the system X profile for PATH/env setup.
[ -f /etc/xprofile ] && . /etc/xprofile

if [ -f "$HOME/.xinitrc" ]; then
    exec startx "$HOME/.xinitrc" "$@" 
fi
exec startx /usr/bin/env "$@"  # fall back to tuigreet's default for users w/o ~/.xinitrc
