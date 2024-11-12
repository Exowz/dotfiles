#!/usr/bin/env zsh

############################
# brew.sh
# This script installs Homebrew if it’s not already installed
# and sets the PATH for Homebrew if necessary.
############################

# Step 1: Install Homebrew
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed. Skipping installation."
fi

# Step 2: Set the PATH for Homebrew if it’s not in the PATH already
if ! echo "$PATH" | grep -q "/opt/homebrew/bin"; then
  echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
  export PATH="/opt/homebrew/bin:$PATH"
  echo "Homebrew path added to .zshrc and current session."
else
  echo "Homebrew path is already in the PATH."
fi

echo "Homebrew setup complete!"