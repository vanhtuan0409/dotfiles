#!/bin/env bash

arch_count=$(checkupdates | wc -l)
aur_count=$(yay -Qu | wc -l)

echo $(($arch_count + $aur_count))
