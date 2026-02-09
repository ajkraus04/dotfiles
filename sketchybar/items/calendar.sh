#!/bin/bash

sketchybar --add item calendar right \
  --set calendar icon=$CLOCK \
                 icon.font="$ICON_FONT:Regular:17.0" \
                 icon.color=$PINK \
                 icon.padding_right=6 \
                 label.font="$FONT:Regular:13.0" \
                 label.padding_right=6 \
                 update_freq=30 \
                 script="$PLUGIN_DIR/clock.sh" \
  --subscribe calendar system_woke
