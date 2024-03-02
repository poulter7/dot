#!/bin/bash
# move current nvim folder
mv ~/.config/nvim ~/.config/nvim.bak

# clean up neovim folders
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# install symlink
cd ~/.config
ln -s ~/dot/apps/astrovim nvim
