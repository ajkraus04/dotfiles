#!/bin/bash
VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" = "true" ]; then
  osascript -e 'set volume without output muted'
else
  osascript -e 'set volume with output muted'
fi
