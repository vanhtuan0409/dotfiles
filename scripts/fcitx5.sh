#!/bin/bash

CAPS_SYMBOL=""
IMLIST_FILE="/tmp/fcitx5-imlist"

capslock() {
  xset -q | grep Caps | grep -q on && {
    echo on
    return 0
  } || {
    echo off
    return 1
  }
}

# Print out identifier of current input method
current() {
  dbus-send --session --print-reply \
    --dest=org.fcitx.Fcitx5 \
    /controller \
    org.fcitx.Fcitx.Controller1.CurrentInputMethod \
    | grep -Po '(?<=")[^"]+'
}

# List all input methods added to Fcitx
imlist() {
  if [ ! -f "${IMLIST_FILE}" ]; then
    dbus-send --session --print-reply \
      --dest=org.fcitx.Fcitx5 \
      /controller \
      org.fcitx.Fcitx.Controller1.AvailableInputMethods \
      | awk 'BEGIN{i=0}{
          if($0~/struct {/) i=0;
          else if(i<6){gsub(/"/,"",$2); printf("%s,",$2); i++}
          else if(i==6){printf("%s\n",$2); i++}
      }' > ${IMLIST_FILE}
    # Output like this:
    # pinyin, 拼音, 拼音, fcitx-pinyin, 拼, zh_CN, true
    # rime, 中州韻, , fcitx-rime, ㄓ, zh, true
    # ......
  fi

  cat ${IMLIST_FILE}
}

# This script wait for events from `watch` and
# update the text by printing a new line.
#
# Strip `Keyboard - ` part from IM name then print
print_pretty_name() {
  name=$(imlist | grep "^$(current)," | cut -d',' -f6)
  if [[ -z "$name" ]]; then
    return
  fi
  if capslock > /dev/null; then
    # ${var^^} means uppercase, when CapsLock is on, let the name uppercase
    name="${name^^} ${CAPS_SYMBOL}"
  fi
  echo "${name}"
}

print_pretty_name
