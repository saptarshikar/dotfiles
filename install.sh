#!/usr/bin/env bash

ZSH_CUSTOM=/Users/saptarshikar/.oh-my-zsh/custom
DOT_FILES=/Users/saptarshikar/Documents/code/dotfiles/*

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

for f in $DOT_FILES
do
  ln -s "$f" "$HOME/.${f##*/}"
done

mkdir -p ~/code
git clone https://github.com/leostat/rtfm.git ~/code/rtfm
