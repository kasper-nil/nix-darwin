#!/bin/bash
# close-or-quit.sh — Close the focused window; quit the app if it was the last one.
#
# Apps like Messages minimize instead of closing when yabai --close or Cmd+W
# is used. To handle this, we count windows BEFORE closing: if it's the last
# window of a non-excluded app, we kill the process directly.
#
# Exclude list: apps that should NEVER be auto-quit.
EXCLUDE=(
  "Finder"
  "Raycast"
  "Alfred"
  "Bartender"
  "iStat Menus"
  "1Password"
  "Karabiner-Elements"
  "skhd"
  "yabai"
)

# ── Get focused window info from yabai ─────────────────────────────────────
WIN_INFO=$(yabai -m query --windows --window 2>/dev/null)
if [ -z "$WIN_INFO" ]; then
  exit 0
fi

WIN_PID=$(echo "$WIN_INFO" | jq -r '.pid // empty')
WIN_APP=$(echo "$WIN_INFO" | jq -r '.app // empty')

if [ -z "$WIN_APP" ]; then
  exit 0
fi

# ── Check exclude list ─────────────────────────────────────────────────────
is_excluded=false
for ex in "${EXCLUDE[@]}"; do
  if [ "$WIN_APP" = "$ex" ]; then
    is_excluded=true
    break
  fi
done

# ── Count windows for this process BEFORE closing ─────────────────────────
WIN_COUNT=$(yabai -m query --windows 2>/dev/null | jq --argjson pid "${WIN_PID:-0}" '[.[] | select(.pid == $pid)] | length' 2>/dev/null)

if [ "$is_excluded" = true ]; then
  # Excluded app: close window only, never quit
  osascript -e "tell application \"System Events\" to keystroke \"w\" using command down"
elif [ "${WIN_COUNT:-1}" -le 1 ]; then
  # Last window of non-excluded app: kill process directly.
  # Bypasses apps that minimize instead of closing (Messages, etc.)
  kill "$WIN_PID" 2>/dev/null &
else
  # Multiple windows: close just this one
  yabai -m window --close 2>/dev/null || \
    osascript -e "tell application \"System Events\" to keystroke \"w\" using command down"
fi
