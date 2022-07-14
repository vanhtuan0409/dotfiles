#!/bin/env bash

arch_count=$(checkupdates 2>/dev/null | wc -l)
aur_count=$(yay -Qu 2>/dev/null | wc -l)

echo $(($arch_count + $aur_count))
