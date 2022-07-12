#!/bin/env bash

for file in *; do
  ln -sf $(realpath $file) ~/.config/broot
done
