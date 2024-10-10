#!/bin/bash

echo "Ensuring that NetworkManager is enabled and started"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

echo "Installing required base packages"
sudo pacman -S --noconfirm base-devel git curl wget nano zip unzip

echo "Installing yay"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

echo "Installing xorg"
sudo pacman -S --noconfirm xorg xorg-xinit

echo "Installing i3, polybar and rofi"
sudo pacman -S --noconfirm i3-wm polybar rofi

echo "Installing web browsers (Firefox, Chromium)"
sudo pacman -S --noconfirm firefox chromium

echo "Installing xdg-user-dirs"
sudo pacman -S --noconfirm xdg-user-dirs

xdg-user-dirs-update
xdg-settings set default-web-browser firefox.desktop

echo "Installing Spotify"
yay -S --noconfirm spotify

echo "Installing Discord"
sudo pacman -S --noconfirm discord

echo "Installing various utilities (alacritty, neovim, zsh, autorandr, feh, picom, dunst, fastfetch, htop, fzf, zoxide, stow"
sudo pacman -S --noconfirm alacritty neovim zsh autorandr feh picom dunst fastfetch htop fzf zoxide stow

echo "Installing python, nodejs and go"
sudo pacman -S --noconfirm python nodejs npm go

echo "Installing starship"
curl -sS https://starship.rs/install.sh | sh

echo "Installing nvidia drivers"
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

echo "Installing openrazer and razer-cli"
sudo pacman -S --noconfirm linux-headers python-openrazer openrazer-driver-dkms openrazer-daemon
pip install razer-cli --break-system-packages
echo "Please enter your username"
read -r username
sudo usermod -aG plugdev "$username"

echo "Do you want to also install jellyfin media player? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    yay -S --noconfirm jellyfin
fi
