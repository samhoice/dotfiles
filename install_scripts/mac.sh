#!/bin/bash

brew_targets="pyenv pipx fzf ripgrep jq tree"

# for item in $brew_installs; do
# 	brew install $item
# done

brew install $brew_targets

# isntall fzf keybindings and completion
/usr/local/opt/fzf/install
