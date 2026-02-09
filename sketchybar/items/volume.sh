#!/bin/bash

POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

sketchybar --add item volume_icon right \
  --set volume_icon icon=$VOLUME_100 \
                    icon.font="$ICON_FONT:Regular:17.0" \
                    icon.color=$PINK \
                    label.drawing=off \
                    padding_right=4 \
                    script="$PLUGIN_DIR/volume.sh" \
                    click_script="$POPUP_CLICK_SCRIPT" \
                    popup.align=right \
  --subscribe volume_icon volume_change mouse.clicked mouse.exited.global \
  \
  --add slider volume popup.volume_icon \
  --set volume slider.highlight_color=$BLUE \
               slider.background.height=6 \
               slider.background.corner_radius=3 \
               slider.background.color=$BACKGROUND_2 \
               slider.width=120 \
               slider.knob.drawing=on \
               padding_left=8 \
               padding_right=8 \
               label.drawing=off \
               icon.drawing=off \
               script="$PLUGIN_DIR/volume_slider.sh" \
  --subscribe volume mouse.clicked
