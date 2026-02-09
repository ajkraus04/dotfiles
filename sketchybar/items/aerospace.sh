#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item "space.$sid" left \
               --subscribe "space.$sid" aerospace_workspace_change \
               --set "space.$sid" \
                     icon="$sid" \
                     icon.font="$FONT:Bold:14.0" \
                     icon.padding_left=8 \
                     icon.padding_right=8 \
                     icon.color=$WHITE \
                     icon.highlight_color=$PINK \
                     label.drawing=off \
                     background.color=$BACKGROUND_1 \
                     background.border_color=$BACKGROUND_2 \
                     background.corner_radius=5 \
                     background.height=22 \
                     background.drawing=off \
                     click_script="aerospace workspace $sid" \
                     script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done

sketchybar --add item separator left \
           --set separator icon="│" \
                           icon.font="$FONT:Regular:16.0" \
                           icon.color=$GREY \
                           icon.padding_left=4 \
                           icon.padding_right=4 \
                           label.drawing=off \
                           background.drawing=off
