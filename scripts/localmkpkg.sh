#!/bin/env bash

set -e

pkgname=$(basename "$PWD")

export PKGDEST="$HOME/.cache/arch/local/packages/$pkgname"
export SRCDEST="$HOME/.cache/arch/local/sources/$pkgname"
export SRCPKGDEST="$HOME/.cache/arch/local/srcpackages/$pkgname"
export BUILDDIR=/tmp/arch/local/build

cmd="${1:-build}"
case $cmd in
  build)
    makepkg --force -si
    ;;
  checksum)
    updpkgsums
    ;;
  *)
    echo "USAGE: build|checksum"
    ;;
esac
