#!/bin/sh

BORDER_FOREGROUND=113 # Froggy green!

# Check if `gum` and `curl` is available
if ! command -v gum > /dev/null; then
  printf "Ribbot requires gum to work. Please install it by using:\n"
  printf "\tgo install github.com/charmbracelet/gum@latest\n"
  printf "Visit https://github.com/charmbracelet/gum for more information\n"
  exit 1
fi

if ! command -v curl > /dev/null; then
  printf "Ribbot requires curl to work. Please make sure that you have installed it\n"
  printf "on your system.\n"
  exit 1
fi

# The main app
clear
gum style --border double --margin "1" --padding "1 2" --border-foreground "$BORDER_FOREGROUND" \
" ____  ___ ____  ____   ___ _____ 
|  _ \|_ _| __ )| __ ) / _ \_   _|
| |_) || ||  _ \|  _ \| | | || |  
|  _ < | || |_) | |_) | |_| || |  
|_| \_\___|____/|____/ \___/ |_|  

A simple and beautiful wrapper of curl
"
URL=$(gum input --prompt "Enter URL to request (Empty to quit the app) " --width 150 --placeholder "URL to request...")
if [ "$URL" = "" ]; then
  exit 0
fi
METHOD=$(gum input --prompt "Enter request method " --value "GET" --placeholder "Request method...")

if [ "$METHOD" = "POST" ]; then
  DATA=$(gum write --placeholder "Enter data to POST here... (Ctrl-D to finish)")
  if gum confirm "Do you want to use multipart/form-data POST? (for file upload, etc.)?"; then
    curl -F "$DATA" "$URL" -L
  else
    curl -d "$DATA" "$URL" -L
  fi
else
  curl -X "$METHOD" "$URL" -L
fi
