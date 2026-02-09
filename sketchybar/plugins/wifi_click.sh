#!/bin/bash
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

ICON_FONT="SF Pro"
CACHE_FILE="/tmp/sketchybar_wifi_scan.cache"

# Toggle popup
DRAWING=$(sketchybar --query wifi | python3 -c "import json,sys; print(json.load(sys.stdin)['popup']['drawing'])" 2>/dev/null)
if [ "$DRAWING" = "on" ]; then
  sketchybar --set wifi popup.drawing=off
  exit 0
fi

# Get current IP
IP="$(ipconfig getifaddr en0 2>/dev/null)"

# Read cached scan results (or run fresh if no cache)
if [ -f "$CACHE_FILE" ] && [ -s "$CACHE_FILE" ]; then
  SCAN_OUTPUT=$(cat "$CACHE_FILE")
else
  SCAN_OUTPUT=$("$CONFIG_DIR/helpers/wifi_scan.sh" 2>/dev/null)
  echo "$SCAN_OUTPUT" > "$CACHE_FILE"
fi

# Find current SSID by matching saved networks to scan
SAVED=$(networksetup -listpreferredwirelessnetworks en0 2>/dev/null | tail -n +2 | sed 's/^[[:space:]]*//')
CURRENT_SSID=""
while IFS= read -r ssid; do
  [ -z "$ssid" ] && continue
  if echo "$SCAN_OUTPUT" | grep -q "^NET:${ssid}|"; then
    CURRENT_SSID="$ssid"
    break
  fi
done <<< "$SAVED"

# Clear old popup items
sketchybar --remove '/wifi\..*/' 2>/dev/null

# Show current connection
if [ -n "$CURRENT_SSID" ] && [ -n "$IP" ]; then
  sketchybar --add item wifi.current popup.wifi \
    --set wifi.current icon="$WIFI_CONNECTED" \
                       icon.color=$GREEN \
                       icon.font="$ICON_FONT:Regular:14.0" \
                       label="$CURRENT_SSID  ($IP)" \
                       label.color=$GREEN \
                       background.color=$BACKGROUND_1 \
                       background.corner_radius=6 \
                       background.drawing=on \
                       background.height=28
elif [ -n "$IP" ]; then
  sketchybar --add item wifi.current popup.wifi \
    --set wifi.current icon="$WIFI_CONNECTED" \
                       icon.color=$GREEN \
                       icon.font="$ICON_FONT:Regular:14.0" \
                       label="Connected  ($IP)" \
                       label.color=$GREEN \
                       background.color=$BACKGROUND_1 \
                       background.corner_radius=6 \
                       background.drawing=on \
                       background.height=28
else
  sketchybar --add item wifi.current popup.wifi \
    --set wifi.current icon="$WIFI_DISCONNECTED" \
                       icon.color=$RED \
                       icon.font="$ICON_FONT:Regular:14.0" \
                       label="Not Connected" \
                       label.color=$RED
fi

# Separator
sketchybar --add item wifi.sep popup.wifi \
  --set wifi.sep icon="─────────────────" \
                 icon.color=$GREY \
                 label.drawing=off

# List nearby networks (skip current)
COUNTER=0
while IFS='|' read -r line rssi connected; do
  SSID="${line#NET:}"
  [ -z "$SSID" ] && continue
  [ "$SSID" = "$CURRENT_SSID" ] && continue
  COUNTER=$((COUNTER + 1))
  [ $COUNTER -gt 10 ] && break

  RSSI_NUM=$rssi
  if [ "$RSSI_NUM" -gt -50 ] 2>/dev/null; then
    ICON_COLOR=$GREEN
  elif [ "$RSSI_NUM" -gt -70 ] 2>/dev/null; then
    ICON_COLOR=$YELLOW
  else
    ICON_COLOR=$RED
  fi

  sketchybar --add item "wifi.net.$COUNTER" popup.wifi \
    --set "wifi.net.$COUNTER" icon="$WIFI_CONNECTED" \
                              icon.color="$ICON_COLOR" \
                              icon.font="$ICON_FONT:Regular:14.0" \
                              label="$SSID" \
                              label.color=$WHITE \
                              click_script="networksetup -setairportnetwork en0 '$SSID' 2>/dev/null; sketchybar --set wifi popup.drawing=off; sleep 3; sketchybar --trigger wifi_change"
done <<< "$(echo "$SCAN_OUTPUT" | grep "^NET:")"

# Separator
sketchybar --add item wifi.sep2 popup.wifi \
  --set wifi.sep2 icon="─────────────────" \
                  icon.color=$GREY \
                  label.drawing=off

# WiFi Settings link
sketchybar --add item wifi.settings popup.wifi \
  --set wifi.settings icon=$PREFERENCES \
                      icon.font="$ICON_FONT:Regular:14.0" \
                      label="WiFi Settings" \
                      label.color=$BLUE \
                      click_script="open 'x-apple.systempreferences:com.apple.Wi-Fi-Settings.extension'; sketchybar --set wifi popup.drawing=off"

sketchybar --set wifi popup.drawing=on

# Refresh cache in background for next time
("$CONFIG_DIR/helpers/wifi_scan.sh" > "$CACHE_FILE" 2>/dev/null) &
