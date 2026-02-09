#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if ! echo "$BATTERY_INFO" | grep -q "InternalBattery"; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi
[ -z "$PERCENTAGE" ] && exit 0

COLOR=$WHITE
case "${PERCENTAGE}" in
  [8-9][0-9]|100) ICON="$BATTERY_100"; COLOR=$PINK ;;
  [5-7][0-9])     ICON="$BATTERY_75";  COLOR=$YELLOW ;;
  [3-4][0-9])     ICON="$BATTERY_50";  COLOR=$ORANGE ;;
  [1-2][0-9])     ICON="$BATTERY_25";  COLOR=$RED ;;
  *)              ICON="$BATTERY_0";   COLOR=$RED ;;
esac

[ -n "$CHARGING" ] && ICON="$BATTERY_CHARGING" && COLOR=$PINK

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.color="$COLOR"
