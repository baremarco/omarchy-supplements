#!/bin/bash
##
# Based on: install-dotfiles.sh
# Original author: typecraft-dev
# Source: https://github.com/typecraft-dev/omarchy-supplement/blob/main/install-dotfiles.sh
#
# This version:
# - Used as part of a personal Omarchy backup/restore workflow
# - Adapted to my setup
#
# Thanks to @typecraft_dev

set -e

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/baremarco/dotfiles.git"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd $HOME

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  echo "removing old configs"
  rm -rf ~/.config/omarchy/backgrounds 
  rm -rf ~/.config/bash 
  rm -rf ~/.config/ideavim 
  rm -rf ~/.config/JetBrains 
  rm -rf ~/.config/maven 
  rm -rf ~/.config/starship.toml 
  rm -rf ~/.config/starship-dark.toml 
  rm -rf ~/.config/starship-light.toml 
  rm -rf ~/.config/nvim 
  rm -rf ~/.local/share/nvim/ 
  rm -rf ~/.cache/nvim/ 
  rm -rf ~/.bashrc

  cd "$REPO_NAME"
  stow backgrounds
  stow bash
  stow ideavim
  stow intellij
  stow maven
  stow nvim
  stow starship

else
  echo "Failed to clone the repository."
  exit 1
fi

