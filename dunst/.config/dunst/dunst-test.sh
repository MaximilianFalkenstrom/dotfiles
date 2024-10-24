#!/bin/sh

killall dunst

notify-send -u normal "Another normal test" "This is another normal test"
notify-send -u critical "Test title" "This is just a test"
notify-send -u normal "Normal test" "This is a normal test"
notify-send -u low "Low test" "This is a low priority test"