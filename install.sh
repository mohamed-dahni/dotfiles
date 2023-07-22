#!/bin/bash

# Cross-platform compatibility for home directory
if [ "$(uname)" == "Darwin" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    DOTFILES_DIR="/c/Users/$USER/.dotfiles"
else
    echo "Unsupported operating system. Exiting..."
    exit 1
fi

# List of dotfiles to be linked
DOTFILES=("vimrc" "aliases" "bash_profile" "bash_prompt" "bashrc")

# Function to create symbolic links
link_dotfiles() {
    for dotfile in "${DOTFILES[@]}"; do
        if [ -f "$HOME/.$dotfile" ]; then
            echo "Backing up existing .$dotfile to $HOME/dotfile_backup/"
            mkdir -p "$HOME/dotfile_backup"
            mv "$HOME/.$dotfile" "$HOME/dotfile_backup/"
        fi
        echo "Creating symlink for .$dotfile"
        ln -s "$DOTFILES_DIR/$dotfile" "$HOME/.$dotfile"
    done
}

# Main installation process
install_dotfiles() {
    echo "Installing dotfiles..."
    link_dotfiles
    echo "Dotfiles installation complete!"
}

# Execution
install_dotfiles
