#!/usr/bin/env zsh

############################
# dev_tools.sh
# This script installs development tools:
# - Anaconda for Python
# - PHP, Composer, and Laravel Installer (via php.new)
# - MAMP
# - NVM (Node Version Manager)
# - .NET SDK for C#
############################

# Step 1: Install Anaconda
echo "Downloading and installing Anaconda for Python..."
ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-MacOSX-arm64.sh"
curl -o ~/Downloads/Anaconda.sh "$ANACONDA_URL"
bash ~/Downloads/Anaconda.sh -b
echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/anaconda3/bin:$PATH"
rm ~/Downloads/Anaconda.sh
echo "Anaconda installation complete."

# Step 2: Install PHP, Composer, and Laravel Installer
echo "Installing PHP, Composer, and Laravel Installer..."
/bin/bash -c "$(curl -fsSL https://php.new/install/mac)"
echo "PHP, Composer, and Laravel installation complete."

# Step 3: Install MAMP with Verification
MAMP_URL="https://downloads.mamp.info/MAMP-PRO/macOS/MAMP-PRO/MAMP-MAMP-PRO-7.1-Apple-chip.pkg"
MAMP_PKG="MAMP.pkg"
curl -L -o $MAMP_PKG $MAMP_URL
if [[ $(file --mime-type -b "$MAMP_PKG") != "application/x-xar" ]]; then
  echo "Error: The downloaded file is not a valid .pkg installer."
  rm -f $MAMP_PKG
  exit 1
fi
sudo installer -pkg $MAMP_PKG -target /
rm $MAMP_PKG
echo "MAMP installation complete."

# Step 4: Install NVM (Node Version Manager)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc
source ~/.zshrc
nvm install node  # Optional: Installs the latest version of Node.js
echo "NVM installation complete and Node.js installed."

# Step 5: Install .NET SDK for C#
# Define the .NET SDK download URL and target filename
DOTNET_SDK_URL="https://download.visualstudio.microsoft.com/download/pr/35b0fb29-cadc-4083-aa26-6cecd2e7ffa1/1a9972a435b73ffdd0b462f979ea5b23/dotnet-sdk-8.0.403-osx-arm64.pkg"
DOTNET_SDK_PKG="dotnet-sdk.pkg"

# Download the .NET SDK installer
echo "Downloading .NET SDK from $DOTNET_SDK_URL..."
curl -L -o $DOTNET_SDK_PKG $DOTNET_SDK_URL

# Check if the downloaded file is a valid .pkg file
if [[ $(file --mime-type -b "$DOTNET_SDK_PKG") != "application/x-xar" ]]; then
  echo "Error: The downloaded file is not a valid .pkg installer."
  rm -f $DOTNET_SDK_PKG
  exit 1
fi

# Install .NET SDK
echo "Installing .NET SDK..."
sudo installer -pkg $DOTNET_SDK_PKG -target /

# Clean up the installer
echo "Cleaning up..."
rm $DOTNET_SDK_PKG

# Create a symlink for dotnet in /usr/local/bin
echo "Creating a symlink for dotnet..."
sudo ln -sf /usr/local/share/dotnet/dotnet /usr/local/bin/dotnet

# Verify .NET SDK installation
echo "Verifying .NET SDK installation..."
dotnet --version

echo ".NET SDK installation complete!"