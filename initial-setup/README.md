
## Download nixos for raspery pi 4
wget "https://hydra.nixos.org/build/157521526/download/1/nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst"

## Uncompress it
unzstd -d nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst
## Write the image to an sdcard
sudo dd if=nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img of=/dev/mmcblk0 bs=4096 conv=fsync status=progress  

## connect a screen and a keyboard to the rpi4
## setup a password for nixos user

## ssh remotely into the rpi4

## edit the configuration.nix (see [configuration.nix](./configuration.nix) for an example initial configuration)
sudo vi /etc/nixos/configuration.nix

## install the new version
sudo nixos-install --root /

## restart
sudo reboot now

## connect to it via ssh
## done.

