#!/bin/bash
source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  case "$INFO" in
    [7-9][0-9]|100) ICON="$VOLUME_100" ;;
    [3-6][0-9])     ICON="$VOLUME_66" ;;
    [1-2][0-9])     ICON="$VOLUME_33" ;;
    [1-9])          ICON="$VOLUME_10" ;;
    *)              ICON="$VOLUME_0" ;;
  esac
  sketchybar --set volume_icon icon="$ICON" \
             --set volume slider.percentage="$INFO"
fi

if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set volume_icon popup.drawing=off
fi
