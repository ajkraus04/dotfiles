#!/bin/bash
if [ "$SENDER" = "mouse.clicked" ]; then
  osascript -e "set volume output volume $PERCENTAGE"
fi
