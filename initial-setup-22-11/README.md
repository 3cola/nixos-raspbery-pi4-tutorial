# initial-setup
The goal is to use an nixos image to boot on an install nixos system on the sd card of the rapsberry pi 4.

## Download nixos for raspery pi 4
``` bash
wget "https://hydra.nixos.org/build/157521526/download/1/nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst"
```

## Uncompress it
``` bash
unzstd -d nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst
```

## plug your sd card into your computer and identify it
``` bash
lsblk -f
```
Usually it is the device /dev/mmcblk0

## Write the image to your sdcard
``` bash
sudo dd if=nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img of=/dev/mmcblk0 bs=4096 conv=fsync status=progress  
```

## plug the sdcard into your raspberry pi, plug an ethernet cable to your local network, plugin the power adapter
You may need to wait few minutes before connecting in ssh for the initial setup...

## ssh into the rpi4 (default password: nixos)
``` bash 
ssh nixos@nixos
```

