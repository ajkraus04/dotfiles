#!/bin/bash

cpu_percent=(
  label.font="$FONT:Bold:12"
  label=CPU
  icon=$CPU
  icon.color=$PINK
  update_freq=4
  padding_right=8
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=$RED
  graph.fill_color=$RED
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  graph.color=$BLUE
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=on
  background.color=$TRANSPARENT
)

sketchybar --add item cpu.percent right \
           --set cpu.percent "${cpu_percent[@]}"
