#!/usr/bin/env bash

# -------------------------------------------------
# Color Utilities for String Formatation
# -------------------------------------------------

export RESET="\e[m"
export BOLD="\e[1m"
export DIM="\e[2m"
export ITALIC="\e[3m"
export UNDERLINE="\e[4m"
export BLINK="\e[5m"
export INVERT="\e[7m"
export STRIKE="\e[9m"

export BLACK="\e[30m"
export RED="\e[31m"
export GREEN="\e[32m"
export YELLOW="\e[33m"
export BLUE="\e[34m"
export MAGENTA="\e[35m"
export CYAN="\e[36m"
export WHITE="\e[37m"

export BGBLACK="\e[40m"
export BGRED="\e[41m"
export BGGREEN="\e[42m"
export BGYELLOW="\e[43m"
export BGBLUE="\e[44m"
export BGMAGENTA="\e[45m"
export BGCYAN="\e[46m"
export BGWHITE="\e[47m"

colors() {
    # Display 256 colors escape sequences
    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            sequence="e[${fgbg};5;${color}m"
            # Display the color
            printf "\e[${fgbg};5;%sm %11s \e[m" $color $sequence
            # Display 6 colors per lines
            if [ $((($color + 1) % 6)) == 4 ] ; 
            then
                echo # New line
            fi
        done
        echo # New line
    done
}   # --------------------- End of color() ----------------------
