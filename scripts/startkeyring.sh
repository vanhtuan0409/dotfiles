#!/usr/bin/env bash
# Launch + unlock the gnome-keyring daemon for the i3 session.
#
# gnome-keyring takes the unlock password ONLY at daemon launch: --unlock/--login
# read it from stdin as the daemon starts. The one mode that talks to an
# already-running daemon (--start) explicitly refuses a password
# ("--start is incompatible with --unlock"), and a bare `--unlock` just forks a
# second, redundant daemon. So there is no post-start CLI unlock -- start and
# unlock have to happen together, which is what this script does. It is run by
# gnome-keyring.service (bound to i3-session.target), which tracks the daemon.
#
# Used to auto-unlock the keyring from a password file instead of leaving it
# empty or wiring up fprintd. Disable the keyring auto_start in the login PAM
# stack (greetd/pam) so this is the only daemon and it owns org.freedesktop.secrets.
set -eu

# The systemd user manager does not inherit KEYRING_PATH from .xsession, and the
# path is kept out of this committed file as a secret -- source it (and require
# it) from ~/.secretvars instead of defaulting it here.
[ -r "$HOME/.secretvars" ] && . "$HOME/.secretvars"
: "${KEYRING_PATH:?KEYRING_PATH not set (define it in ~/.secretvars)}"

# --foreground: systemd owns the process (Type=simple, so Restart= works).
# --components: drop the ssh agent -- ssh is served by gcr (SSH_AUTH_SOCK is set
#   in .xsession), not by gnome-keyring.
# $(< ...) strips the password file's trailing newline and printf adds none: the
#   daemon reads stdin verbatim as the password, so a stray newline would break it.
exec /usr/bin/gnome-keyring-daemon --foreground --components=pkcs11,secrets --unlock \
  < <(printf '%s' "$(< "$KEYRING_PATH")")
