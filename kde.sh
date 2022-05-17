sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Ukraine -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

git clone https://aur.archlinux.org/pikaur.git
cd pikaur/
makepkg -si --noconfirm

#sudo pacman -S --noconfirm xorg

sudo pacman -S --noconfirm xorg sddm plasma kde-applications firefox simplescreenrecorder obs-studio vlc papirus-icon-theme kdenlive materia-kde
sudo pikaur -S --noconfirm telegram-desktop-bin
sudo pikaur -S --noconfirm discord
sudo pikaur -S --noconfirm stacer

sudo systemctl enable sddm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
