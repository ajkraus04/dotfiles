#!/bin/bash

# Check if cheatsheet window exists
if pgrep -f "app=.*cheatsheet.html" > /dev/null 2>&1; then
  # Close it
  pkill -f "app=.*cheatsheet.html"
else
  # Open as standalone Chrome app window
  open -na "Google Chrome" --args --app="file:///Users/andrewkraus/cheatsheet.html"
fi
