#!/bin/env bash

# use to automatically unlock keyring with password stored in a file
# in case dont want the keyring password to be empty
# or using fprintd
# NOTED: you should disable `auto_start` option in /etc/pamd.d/lightdm-*
KEYRING_PATH=${KEYRING_PATH:-}
echo -n $(cat $KEYRING_PATH) | /usr/bin/gnome-keyring-daemon --daemonize --unlock --replace
/usr/bin/gnome-keyring-daemon --start
