# simple-ssd-ext4-setup
The goal is to have a permanent nixos system installed on a usb ssd drive formated in ext4, pluged in a raspberry pi 4.

## Start with the [initial-setup-23-05](../initial-setup-23-05)

## ssh into the rpi4 (default password: nixos)
``` bash 
ssh nixos@nixos
```
## plug in the usb ssd drive

## get root
``` bash
sudo -i
```

## prepare the usb ssd disk
### check that our disk is /dev/sda
``` bash
lsblk -f
```
this should be /dev/sda

### format
``` bash
wipefs -a /dev/sda

parted --align=opt /dev/sda -- mklabel msdos
parted --align=opt /dev/sda -- mkpart primary fat32 1MiB 513MiB
parted --align=opt /dev/sda -- mkpart primary linux-swap 513MiB 8705MiB
parted --align=opt /dev/sda -- mkpart primary 8705MiB 100%

mkfs.fat -F 32 -n BOOT /dev/sda1
mkswap -L swap /dev/sda2
mkfs.ext4 -L NIXOS_ROOT /dev/sda3
```

### mount fs for installation and copy firmware from sdcard to boot
``` bash
swapon /dev/sda2

mount /dev/sda3 /mnt

mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

mkdir -p /firmware
mount /dev/mmcblk1p1 /firmware

cp -r /firmware/* /mnt/boot
```

## generate nixos config
``` bash
nixos-generate-config --root /mnt
```

## check the generated hardware-configuration.nix, usually you don't need to edit anything
``` bash
less /mnt/etc/nixos/hardware-configuration.nix
```

## edit the configuration.nix (see [configuration.nix](./configuration.nix) for an example initial configuration)
``` bash
vim /mnt/etc/nixos/configuration.nix
```

## install 
``` bash
nixos-install --root /mnt
```

## restart
``` bash
shutdown now
```

## unplug the power, unplug the sdcard and plug back the power

## connect to it via ssh
## done.

## optionally, we can upgrade 
``` bash
sudo nixos-rebuild --upgrade boot

sudo reboot now
```
