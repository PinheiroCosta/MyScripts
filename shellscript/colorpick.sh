#!/usr/bin/bash

# Author: Rômulo Pinheiro
# Creation: 24/03/2021
#	version: 1.1
# License: GPL


TITLE="Color Picker"
ICON="gtk-color-picker"

color=$(yad --window-icon=$ICON --title="$TITLE" --color --button="Copy to clipboard" --buttons-layout=center)

xclip -selection clipboard <<< $color
