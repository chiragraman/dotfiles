#!/bin/zsh

# Find path for User and Workspace Settings
if [ "$(uname -s)" = "Darwin" ]; then
  CONFIG_ROOT="$HOME"/Library/Application\ Support/Code/User
elif [ "$(uname -s)" = "Linux" ]; then
  CONFIG_ROOT="$HOME"/.config/Code/User
fi

# Create links for settings, keybindings, snippets
ln -sf "$DOTFILES"/vscode/settings.json "$CONFIG_ROOT"/settings.json
ln -sf "$DOTFILES"/vscode/keybindings.json "$CONFIG_ROOT"/keybindings.json
ln -sf "$DOTFILES"/vscode/snippets/ "$CONFIG_ROOT"/snippets

# Install extensions
EXTENSIONS=(
  $(sed "s/[[:space:]]*#.*//;/^[[:space:]]*$/d" $(dirname "$0")/extensions.txt)
)

for VARIANT in "code" \
               "code-insiders"
do
  if hash $VARIANT 2>/dev/null; then
    echo -e "\n› Installing extensions for $VARIANT"
    for EXTENSION in ${EXTENSIONS[@]}
    do
      $VARIANT --install-extension $EXTENSION
    done
  fi
done
