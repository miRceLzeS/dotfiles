#!/usr/bin/env bash
set -e

if [[ "$(uname)" == "Darwin" ]]; then
  # macos cli tool set
  xcode-select --install

  # package manager
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "/opt/homebrew/bin/brew shellenv"
  fi

  brew update
  FISH="$(brew --prefix)/bin/fish"
  if ! grep -qx "$FISH" /etc/shells; then
    echo "$FISH" | sudo tee -a /etc/shells >/dev/null
    chsh -s "$FISH"
  fi
fi

