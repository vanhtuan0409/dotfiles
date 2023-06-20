#!/bin/env bash

case $1 in
  up)
    sh -c "$2"
    ;;

  down)
    sh -c "$3"
    ;;

  *)
    # Do nothing
    ;;
esac
