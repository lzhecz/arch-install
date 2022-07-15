#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=en_US.UTF-8" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

read -p 'Username: ' uservar
read -sp 'Password: ' passvar

echo root:$passvar | chpasswd

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils 
pacman -S bash-completion openssh rsync dnsmasq openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns os-prober ntfs-3g terminus-font
pacman -S --noconfirm alsa-utils wireplumber pipewire pipewire-alsa pipewire-pulse pipewire-jack gst-plugin-pipewire libpulse # Audio
pacman -S --noconfirm virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils vde2 # VM packages
pacman -S --noconfirm acpi acpi_call acpid # power managment
pacman -S --noconfirm tlp # power saving for notebook
#pacman -S cups hplip # printers

# pacman -S --noconfirm xf86-video-amdgpu
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
pacman -S --noconfirm mesa

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#systemctl enable cups.service # printers
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
# systemctl enable firewalld
systemctl enable acpid
systemctl enable tlp # power saving for notebooks

useradd -m $uservar
echo $uservar:$passvar | chpasswd
usermod -aG libvirt $uservar


echo "$uservar ALL=(ALL) ALL" >> /etc/sudoers.d/$uservar

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
