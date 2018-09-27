#!/usr/bin/env bash

icon="$HOME/.config/scripts/lock.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -scale 20% -scale 500% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock --radius 130 -i "$tmpbg"
