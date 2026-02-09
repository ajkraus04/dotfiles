#!/bin/bash

sketchybar --add item front_app left \
  --set front_app label.font="$FONT:Bold:13.0" \
                  label.padding_left=4 \
                  label.padding_right=10 \
                  icon.drawing=off \
                  display=active \
                  script="$PLUGIN_DIR/front_app.sh" \
                  click_script="open -a 'Mission Control'" \
  --subscribe front_app front_app_switched
