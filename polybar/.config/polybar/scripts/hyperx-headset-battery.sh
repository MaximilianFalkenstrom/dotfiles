#!/bin/sh

battery=$(timeout 2 python3 ~/.config/polybar/scripts/battery.py)

if [[ battery -gt 0 ]]; then
    echo "$battery%"
else
    echo "off"
fi