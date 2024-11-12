#!/usr/bin/env zsh

############################
# macOS.sh
# This script sets up macOS-specific configurations:
# - Installs Xcode Command Line Tools (Beta) if not already installed
# - Installs Oh My Zsh
# - Sets screenshot location
# - Configures wallpaper folder with automatic rotation by copying the Automator app and adding it to Login Items
############################

# Step 1: Install Xcode Command Line Tools (Beta)
xcode-select --install
echo "Complete the installation of Xcode Command Line Tools before proceeding."
echo "Press Enter to continue..."
read

# Step 2: Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed. Skipping installation."
fi

# Step 3: Set Screenshot Location
echo "Setting screenshot location to ~/Pictures/Screenshots..."
mkdir -p "$HOME/Pictures/Screenshots"  # Create the directory if it doesn't exist
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
killall SystemUIServer  # Apply the changes
echo "Screenshot location set to ~/Pictures/Screenshots."

# Step 4: Copy Wallpaper Rotator Automator App to Applications and Add to Login Items

DOTFILES_APP_PATH="$HOME/.dotfiles/WallpaperRotator.app"
APPLICATIONS_APP_PATH="/Applications/WallpaperRotator.app"

# Check if the Automator app exists in .dotfiles
if [ -d "$DOTFILES_APP_PATH" ]; then
    echo "Copying Wallpaper Rotator app to /Applications directory..."
    cp -R "$DOTFILES_APP_PATH" "$APPLICATIONS_APP_PATH"

    # Run the app once
    echo "Running the Wallpaper Rotator app..."
    open "$APPLICATIONS_APP_PATH"

    # Add the app to Login Items using AppleScript
    echo "Adding Wallpaper Rotator app to Login Items..."
    osascript <<EOF
tell application "System Events"
    if (count of (every login item whose name is "WallpaperRotator")) = 0 then
        make login item at end with properties {path:"$APPLICATIONS_APP_PATH", hidden:false}
    end if
end tell
EOF

    echo "Wallpaper Rotator app added to Login Items successfully."
else
    echo "Wallpaper Rotator app not found at $DOTFILES_APP_PATH. Please ensure it's available in your .dotfiles directory."
fi

echo "macOS setup complete!"