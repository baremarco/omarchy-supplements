#!/bin/bash

set -e

OMARCHY_CURRENT_THEME_PATH="$HOME/.config/omarchy/current"
THEME_FILE="$OMARCHY_CURRENT_THEME_PATH/theme.name"
STARSHIP_CONFIG_DIR="$HOME/.config"

# check if starship is installed
if ! command -v starship &> /dev/null; then
  echo "starship is not installed"
  exit 1 
fi

# check if theme.name exits
if [[ ! -f "$THEME_FILE" ]]; then
  echo "file $THEME_FILE not found"
  exit 1
fi

# check if starship-light exits
if [[ ! -f "$STARSHIP_CONFIG_DIR/starship-light.toml" ]]; then
  echo "file starship-light not found in $STARSHIP_CONFIG_DIR"
  exit 1
fi

# check if starship-dark exits
if [[ ! -f "$STARSHIP_CONFIG_DIR/starship-dark.toml" ]]; then
  echo "file starship-dark not found in $STARSHIP_CONFIG_DIR"
  exit 1
fi

# detect theme and apply starship theme preset
if grep "latte" "$THEME_FILE"; then
  # set light theme
  echo "light theme detected, setting light"
  cat "$STARSHIP_CONFIG_DIR/starship-light.toml" > "$STARSHIP_CONFIG_DIR/starship.toml"
else
  # set dark theme
  echo "setting dark theme"
  cat "$STARSHIP_CONFIG_DIR/starship-dark.toml" > "$STARSHIP_CONFIG_DIR/starship.toml"
fi
  
