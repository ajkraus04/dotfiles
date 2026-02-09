#!/bin/bash
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

CACHE_FILE="/tmp/sketchybar_wifi_scan.cache"

case "$SENDER" in
  "mouse.exited.global")
    sketchybar --set wifi popup.drawing=off
    ;;
  *)
    # Update icon based on connection
    IP="$(ipconfig getifaddr en0 2>/dev/null)"
    if [ -n "$IP" ]; then
      sketchybar --set $NAME icon="$WIFI_CONNECTED" icon.color="$PINK"
    else
      sketchybar --set $NAME icon="$WIFI_DISCONNECTED" icon.color="$RED"
    fi

    # Run scan in background and cache results
    ("$CONFIG_DIR/helpers/wifi_scan.sh" > "$CACHE_FILE" 2>/dev/null) &
    ;;
esac
