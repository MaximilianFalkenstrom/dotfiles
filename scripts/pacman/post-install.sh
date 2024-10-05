#!/bin/bash

echo "Make sure you have enabled networking so that things can be downloaded"
echo "Are you using NetworkManager and want me to enable it for you? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager
fi

echo "Installing required packages"
sudo pacman -S --noconfirm base-devel git curl wget nano zip unzip

echo "Do you want to install yay? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

echo "Do you want to install nvidia drivers? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
fi

echo "Do you want to install xorg? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    sudo pacman -S --noconfirm xorg xorg-xinit
fi

echo "Do you want to install i3, polybar and rofi? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    sudo pacman -S --noconfirm i3-wm polybar rofi
fi

echo "Do you also want to install the following packages? [y/n]"
echo " 1. alacritty"
echo " 2. neovim"
echo " 3. zsh"
echo " 4. autorandr"
echo " 5. feh"
echo " 6. picom"
echo " 7. dunst"
echo " 8. fastfetch"
echo " 9. htop"
echo "10. fzf"
echo "11. zoxide"
echo "12. stow
read -r response
if [[ "$response" == "y" ]]; then
    sudo pacman -S --noconfirm alacritty neovim zsh autorandr feh picom dunst fastfetch htop fzf zoxide stow
fi

echo "Do you want to set up openrazer and razer-cli? [Y/n]"
read -r response
if [[ "$response" != "n" ]]; then
    sudo pacman -S --noconfirm linux-headers python-openrazer openrazer-driver-dkms openrazer-daemon
    pip install razer-cli --break-system-packages
    echo "Please enter your username"
    read -r username
    sudo usermod -aG plugdev "$username"
fi


echo "Which of the following browsers do you want to install? Please specify the numbers separated by spaces"
echo "1. Firefox"
echo "2. Chromium"
echo "3. Brave"
echo "4. Ungoogled-Chromium"
read -r response
for i in $response; do
    case $i in
        1)
            sudo pacman -S --noconfirm firefox
            ;;
        2)
            sudo pacman -S --noconfirm chromium
            ;;
        3)
            yay -S --noconfirm brave-bin
            ;;
        4)
            yay -S --noconfirm ungoogled-chromium
            ;;
    esac
done

echo "Do you want to install any of the following programming languages? Please specify the numbers separated by spaces"
echo "1. Python"
echo "2. Node.js"
echo "3. Go"
echo "4. Rust"
echo "5. Dotnet"
read -r response
for i in $response; do
    case $i in
        1)
            sudo pacman -S --noconfirm python
            ;;
        2)
            sudo pacman -S --noconfirm nodejs npm
            ;;
        3)
            sudo pacman -S --noconfirm go
            ;;
        4)
            sudo pacman -S --noconfirm rust
            ;;
        5)
            sudo pacman -S --noconfirm dotnet-runtime dotnet-host dotnet-sdk
            ;;
    esac
done

echo "Do you want to install fastfetch? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    yay -S --noconfirm fastfetch
fi

echo "Do you want to install jellyfin media player? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    yay -S --noconfirm jellyfin
fi

echo "Do you want to install starship? [y/n]"
read -r response
if [[ "$response" == "y" ]]; then
    curl -sS https://starship.rs/install.sh | sh
fi
