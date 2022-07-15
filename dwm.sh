#!/bin/bash

# Variables
country=Bulgaria

# Options
aur_helper=true

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo reflector -c $country -a 12 --sort rate --save /etc/pacman.d/mirrorlist

# sudo firewall-cmd --add-port=1025-65535/tcp --permanent
# sudo firewall-cmd --add-port=1025-65535/udp --permanent
# sudo firewall-cmd --reload
# sudo virsh net-autostart default

if [[ $aur_helper = true ]]; then
    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay/;makepkg -si --noconfirm;cd
fi

# Install packages
yay -S brave-bin polkit polkit-gnome nitrogen lxappearance-gtk3 pcmanfm-gtk3 htop

# Install fonts

sudo pacman -S xorg-server xorg-xwininfo xorg-xinit xcompmgr xorg-xprop xorg-xbacklight # xorg
yay -S --noconfirm dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji
yay -S zsh rofi picom-animations-git gpick xclip imagemagick dunst dosfstools exfat-utils betterlockscreen-git lf-git ueberzug flameshot tigervnc gparted gnome-disks gnome-system-monitor gnome-keyring zsh-fast-syntax-highlighting-git
yay -S timeshift timeshift-autosnap arandr bitwarden blueman pavucontrol pamixer pulsemixer dracula-gtk-theme python-qdarkstyle man-db wireplumber pipewire pipewire-pulse pipewire-alsa unclutter xdotool fzf 
yay -S --noconfirm telegram-desktop-bin discord visual-studio-code-bin remmina libvncserver etcher-bin neofetch

# Pull Git repositories and install 
cd ~/.suckless
repos=( "dwm" "dwmblocks" "st" )
for repo in ${repos[@]}
do
    git clone https://github.com/lzhecz/$repo
    cd $repo;make;sudo make install;cd
done

# XSessions and dwm.desktop
if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
