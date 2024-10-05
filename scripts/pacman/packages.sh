#!/bin/bash

cmd=$1

if [[ "$cmd" == "backup" ]]; then
    pacman -Qqen > pacman/pkglist.txt
    pacman -Qqem > pacman/pkglist_aur.txt
elif [[ "$cmd" == "restore" ]]; then
    sudo pacman -S --noconfirm --needed - < pacman/pkglist.txt
    yay -S --noconfirm --needed - < pacman/pkglist_aur.txt
else
    echo "Unknown command"
fi