#!/bin/bash
source "$CONFIG_DIR/icons.sh"

next()    { osascript -e 'tell application "Spotify" to play next track'; }
back()    { osascript -e 'tell application "Spotify" to play previous track'; }
play()    { osascript -e 'tell application "Spotify" to playpause'; }

repeat() {
  REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
  if [ "$REPEAT" = "false" ]; then
    sketchybar -m --set spotify.repeat icon.highlight=on
    osascript -e 'tell application "Spotify" to set repeating to true'
  else
    sketchybar -m --set spotify.repeat icon.highlight=off
    osascript -e 'tell application "Spotify" to set repeating to false'
  fi
}

shuffle() {
  SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar -m --set spotify.shuffle icon.highlight=on
    osascript -e 'tell application "Spotify" to set shuffling to true'
  else
    sketchybar -m --set spotify.shuffle icon.highlight=off
    osascript -e 'tell application "Spotify" to set shuffling to false'
  fi
}

update() {
  PLAYING=1

  # Check from event INFO first, fallback to direct query
  if [ -n "$INFO" ] && [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name)"
    ARTIST="$(echo "$INFO" | jq -r .Artist)"
    ALBUM="$(echo "$INFO" | jq -r .Album)"
  elif pgrep -x Spotify >/dev/null 2>&1; then
    STATE=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)
    if [ "$STATE" = "playing" ]; then
      PLAYING=0
      TRACK=$(osascript -e 'tell application "Spotify" to get name of current track' 2>/dev/null)
      ARTIST=$(osascript -e 'tell application "Spotify" to get artist of current track' 2>/dev/null)
      ALBUM=$(osascript -e 'tell application "Spotify" to get album of current track' 2>/dev/null)
    fi
  fi

  if [ $PLAYING -eq 0 ]; then
    SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling' 2>/dev/null)
    REPEAT=$(osascript -e 'tell application "Spotify" to get repeating' 2>/dev/null)
    COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track' 2>/dev/null)
    curl -s --max-time 20 "$COVER" -o /tmp/cover.jpg

    args=()
    if [ -z "$ARTIST" ] || [ "$ARTIST" = "null" ]; then
      args+=(--set spotify.title label="$TRACK"
             --set spotify.album label="Podcast"
             --set spotify.artist label="$ALBUM")
    else
      args+=(--set spotify.title label="$TRACK"
             --set spotify.album label="$ALBUM"
             --set spotify.artist label="$ARTIST")
    fi
    args+=(--set spotify.play icon="$SPOTIFY_PAUSE"
           --set spotify.shuffle icon.highlight=$SHUFFLE
           --set spotify.repeat icon.highlight=$REPEAT
           --set spotify.cover background.image="/tmp/cover.jpg"
                               background.color=0x00000000
           --set spotify.anchor drawing=on label="$ARTIST - $TRACK")
    sketchybar -m "${args[@]}"
  else
    sketchybar -m --set spotify.anchor drawing=on label="" \
                  --set spotify.play icon="$SPOTIFY_PLAY_PAUSE"
  fi
}

scrubbing() {
  DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track')
  DURATION=$((DURATION_MS/1000))
  TARGET=$((DURATION*PERCENTAGE/100))
  osascript -e "tell application \"Spotify\" to set player position to $TARGET"
  sketchybar --set spotify.state slider.percentage=$PERCENTAGE
}

scroll() {
  DURATION_MS=$(osascript -e 'tell application "Spotify" to get duration of current track' 2>/dev/null)
  [ -z "$DURATION_MS" ] && return
  DURATION=$((DURATION_MS/1000))
  FLOAT="$(osascript -e 'tell application "Spotify" to get player position' 2>/dev/null)"
  TIME=${FLOAT%.*}
  [ -z "$TIME" ] && return
  sketchybar --animate linear 10 \
             --set spotify.state slider.percentage="$((TIME*100/DURATION))" \
                                 icon="$(date -r $TIME +'%M:%S')" \
                                 label="$(date -r $DURATION +'%M:%S')"
}

mouse_clicked() {
  case "$NAME" in
    "spotify.next") next ;;
    "spotify.back") back ;;
    "spotify.play") play ;;
    "spotify.shuffle") shuffle ;;
    "spotify.repeat") repeat ;;
    "spotify.state") scrubbing ;;
    *) exit ;;
  esac
}

popup() { sketchybar --set spotify.anchor popup.drawing=$1; }

routine() {
  case "$NAME" in
    "spotify.state") scroll ;;
    *) update ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  "mouse.exited.global") popup off ;;
  "routine") routine ;;
  "forced") exit 0 ;;
  *) update ;;
esac
