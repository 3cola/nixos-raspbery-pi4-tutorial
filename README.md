# nixos-raspbery-pi4-tutorial
A tutorial to setup a raspbery pi4 on nixos

This is a work-in-progress, quite reckless right now, but the goal is to refine a good configuration.nix over time.

## Download nixos for raspery pi 4
wget "https://hydra.nixos.org/build/157521526/download/1/nixos-sd-image-21.11pre327994.e9e4ac24b4c-aarch64-linux.img.zst"
## Uncompress it
unzstd -d nixos-sd-image-21.11pre327994.e9e4ac24b4c-aarch64-linux.img.zst
## Write the image to a usb stick or an sdcard
sudo dd if=nixos-sd-image-21.11pre327994.e9e4ac24b4c-aarch64-linux.img of=/dev/sdb bs=4096 conv=fsync status=progress  

## connect a screen and a keyboard to the rpi4
## setup a password for nixos user

## ssh remotely into the rpi4

## edit the configuration.nix (see configuration.nix)
sudo vi /etc/nixos/configuration.nix

## install the new version
sudo nixos-install --root /

## restart
sudo reboot now

## connect to it via ssh
## done.

