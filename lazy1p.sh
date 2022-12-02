mkfs.vfat /dev/nvme1n1p1
mkfs.btrfs -f /dev/nvme1n1p2

#create subvolumes
mount /dev/nvme1n1p2 /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @var
cd
umount /mnt

#mount subvolumes
mount -o noatime,compress=zstd,ssd,space_cache=v2,discard=async,subvol=@ /dev/nvme1n1p2 /mnt
mkdir -p /mnt/{boot/efi,home,var}
mount -o noatime,compress=zstd,ssd,space_cache=v2,discard=async,subvol=@home /dev/nvme1n1p2 /mnt/home
mount -o noatime,compress=zstd,ssd,space_cache=v2,discard=async,subvol=@var /dev/nvme1n1p2 /mnt/var
mount /dev/nvme1n1p1 /mnt/boot/efi

lsblk

