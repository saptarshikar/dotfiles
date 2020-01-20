#!/usr/bin/env bash

plugin_path=vim/pack/saptarshikar/start/
plugin=$plugin_path$1
echo $plugin
git submodule deinit $plugin
git rm $plugin
rm -Rf .git/modules/$plugin
git commit
