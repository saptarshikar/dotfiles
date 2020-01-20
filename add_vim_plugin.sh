#!/usr/bin/env bash

if [ $# != 1 ]; then
	echo "Too many or too few arguments"
	exit 1
fi

#grep -o '[^/][a-zA-Z-]*.git$' <<< $1 

name=$(echo $1 | cut -d'/' -f5 | cut -d'.' -f1)
echo $name
plugin_path="vim/pack/saptarshikar/start/"$name
echo $plugin_path
git submodule add $1 $plugin_path
git add .gitmodules $plugin_path
