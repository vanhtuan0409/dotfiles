#!/usr/bin/env bash
input=$(ibus engine)

case $input in
  xkb:us::eng)
    echo "en"
    ;;
  BambooUs)
    echo "en"
    ;;
  Bamboo)
    echo "vi"
    ;;
  *)
    echo "${input##*:}"
    ;;
esac
