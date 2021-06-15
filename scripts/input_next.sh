#!/usr/bin/env bash
inputs=(
  Bamboo
  xkb:us::eng
)
length=${#inputs[@]}

current_input=$(ibus engine)
for i in "${!inputs[@]}"; do
  if [[ "${inputs[$i]}" = "$current_input" ]]; then
    current_index=$i
  fi
done

next_index=$((($current_index+1) % $length))
ibus engine "${inputs[$next_index]}"
