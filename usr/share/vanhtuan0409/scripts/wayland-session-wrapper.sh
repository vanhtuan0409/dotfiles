#!/bin/env bash
# Generic Wayland-session wrapper for greetd/tuigreet (see --session-wrapper).
# Lives at /usr/share/vanhtuan0409/scripts/wayland-session-wrapper.sh (repo symlink).
# greetd execs this as the logging-in user (PAM sets $HOME), so it is user-generic
# and carries NO personal config -- the Wayland analogue of Xorg's Xsession script.
#
# Pre-session setup -- the static, personal session env that must live in the
# compositor's OWN environment -- is sourced from ~/.wayland-session (the
# .xsession analogue) if present. The DYNAMIC, compositor-dependent wiring
# (WAYLAND_DISPLAY -> systemd/D-Bus env, sway-session.target) happens from the
# compositor config once its sockets exist.
#
# Args ($@) = the session command tuigreet selected, e.g. "sway".

[ -f "$HOME/.wayland-session" ] && . "$HOME/.wayland-session"

# sway/wlroots refuses to start on the proprietary Nvidia driver without
# --unsupported-gpu, and there is no env equivalent, so always append it for sway.
case "$1" in
    sway) exec "$@" --unsupported-gpu ;;
    *)    exec "$@" ;;
esac

# vi: ft=bash
