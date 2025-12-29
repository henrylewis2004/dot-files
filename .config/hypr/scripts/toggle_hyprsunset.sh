#!/bin/bash
temp=$(hyprctl hyprsunset temperature)

if [ "$temp" -gt 4000 ]; then
	hyprctl hyprsunset temperature 4000
else
	hyprctl hyprsunset temperature 6000
fi

