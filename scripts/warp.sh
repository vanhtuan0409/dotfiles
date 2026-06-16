#!/usr/bin/env bash
# Cloudflare WARP status for waybar (custom/warp module).
# Emits JSON; `alt` selects the glyph via format-icons, `class` drives CSS.

if warp-cli status 2>/dev/null | grep -q "Connected"; then
  printf '{"alt":"connected","class":"connected","tooltip":"WARP: connected"}\n'
else
  printf '{"alt":"disconnected","class":"disconnected","tooltip":"WARP: disconnected"}\n'
fi
