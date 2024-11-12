#!/usr/bin/env zsh

############################
# vscode.sh
# This script installs Visual Studio Code extensions and sets up user settings.
############################

# Complete list of VS Code Extensions
extensions=(
    amiralizadeh9480.laravel-extra-intellisense
    anbuselvanrocky.bootstrap5-vscode
    antfu.browse-lite
    antfu.vite
    arcticicestudio.nord-visual-studio-code
    batisteo.vscode-django
    benjaminbenais.copilot-theme
    blackboxapp.blackbox
    bmewburn.vscode-intelephense-client
    bradlc.vscode-tailwindcss
    christian-kohler.npm-intellisense
    christian-kohler.path-intellisense
    danielpinto8zz6.c-cpp-project-generator
    dbaeumer.vscode-eslint
    devsense.composer-php-vscode
    devsense.intelli-php-vscode
    devsense.phptools-vscode
    devsense.profiler-php-vscode
    donjayamanne.python-environment-manager
    donjayamanne.python-extension-pack
    ecmel.vscode-html-css
    esbenp.prettier-vscode
    formulahendry.auto-close-tag
    formulahendry.auto-rename-tag
    formulahendry.code-runner
    github.vscode-pull-request-github
    gobystrokreactjs.gobystrok
    hurly.sqltools-oracle-driver
    illixion.vscode-vibrancy-continued
    ionic.ionic
    kevinrose.vsc-python-indent
    kj.sqltools-driver-redshift
    lewxdev.vscode-glyph
    magicstack.magicpython
    ms-azuretools.vscode-docker
    ms-dotnettools.csdevkit
    ms-dotnettools.csharp
    ms-dotnettools.vscode-dotnet-runtime
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.cmake-tools
    ms-vscode.cpptools
    ms-vscode.cpptools-extension-pack
    ms-vscode.cpptools-themes
    ms-vscode.live-server
    ms-vscode.remote-explorer
    ms-vscode.vscode-serial-monitor
    ms-vscode.vscode-typescript-next
    ms-vsliveshare.vsliveshare
    mtxr.sqltools
    mtxr.sqltools-driver-mssql
    mtxr.sqltools-driver-mysql
    mtxr.sqltools-driver-pg
    mtxr.sqltools-driver-sqlite
    mubaidr.vuejs-extension-pack
    nichabosh.minimalist-dark
    njpwerner.autodocstring
    nuxt.mdc
    nuxtr.nuxtr-vscode
    pkief.material-icon-theme
    platformio.platformio-ide
    pranaygp.vscode-css-peek
    pulkitgangwar.nextjs-snippets
    redhat.java
    redhat.vscode-yaml
    ritwickdey.liveserver
    sdras.night-owl
    sdras.vue-vscode-snippets
    simonsiefke.svg-preview
    tombonnike.vscode-status-bar-format-toggle
    ttoowa.in-your-face-incredible
    twxs.cmake
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    vitest.explorer
    vscjava.vscode-gradle
    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-java-pack
    vscjava.vscode-java-test
    vscjava.vscode-maven
    vscode-icons-team.vscode-icons
    vue.volar
    wholroyd.jinja
    xabikos.javascriptsnippets
    xabikos.reactsnippets
    xdebug.php-debug
    xdebug.php-pack
    zhuangtongfa.material-theme
    zignd.html-css-class-completion
    zobo.php-intellisense
)

# Get a list of all currently installed extensions.
installed_extensions=$(code --list-extensions)

for extension in "${extensions[@]}"; do
    if echo "$installed_extensions" | grep -qi "^$extension$"; then
        echo "$extension is already installed. Skipping..."
    else
        echo "Installing $extension..."
        code --install-extension "$extension"
    fi
done

echo "VS Code extensions have been installed."

# Define the target directory for VS Code user settings on macOS
VSCODE_USER_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User"

# Check if VS Code settings directory exists
if [ -d "$VSCODE_USER_SETTINGS_DIR" ]; then
    # Copy your custom settings.json and keybindings.json to the VS Code settings directory
    ln -sf "${HOME}/.dotfiles/settings/VSCode-Settings.json" "${VSCODE_USER_SETTINGS_DIR}/settings.json"

    echo "VS Code settings have been updated."
else
    echo "VS Code user settings directory does not exist. Please ensure VS Code is installed."
fi

# Open VS Code to sign in to extensions
code .
