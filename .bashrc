#!/usr/bin/env bash

# Fix ldconfig errors
export PATH="$PATH:/sbin:/usr/sbin"

# This folder is not defined in newest Ubuntu for some reason
export XDG_CONFIG_HOME=$HOME/.config

# Colemak layout
setxkbmap us -variant colemak
