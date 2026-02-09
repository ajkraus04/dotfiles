#!/bin/bash

sketchybar --add item wifi right \
  --set wifi icon=$WIFI_CONNECTED \
             icon.color=$PINK \
             icon.font="$ICON_FONT:Regular:17.0" \
             padding_right=4 \
             label.drawing=off \
             script="$PLUGIN_DIR/wifi.sh" \
             click_script="$PLUGIN_DIR/wifi_click.sh" \
             update_freq=30 \
             popup.align=right \
  --subscribe wifi wifi_change mouse.exited.global
