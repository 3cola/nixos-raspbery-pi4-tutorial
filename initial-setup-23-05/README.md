# initial-setup
The goal is to use an nixos image to boot on an install nixos system on the sd card of the rapsberry pi 4.

## Download nixos for raspery pi 4
``` bash
wget "https://hydra.nixos.org/build/228566487/download/1/nixos-sd-image-23.05.2162.6da4bc6cb07-aarch64-linux.img.zst"
```

## Uncompress it
``` bash
unzstd -d nixos-sd-image-23.05.2162.6da4bc6cb07-aarch64-linux.img.zst
```

## plug your sd card into your computer and identify it
``` bash
lsblk -f
```
Usually it is the device /dev/mmcblk0

## Write the image to your sdcard
``` bash
sudo dd if=nixos-sd-image-23.05.2162.6da4bc6cb07-aarch64-linux.img of=/dev/mmcblk0 bs=4096 conv=fsync status=progress  
```

## Unplug the sdcard from your computer and plug it into the raspberry pi, plug also an ethernet cable and the power adapter
## wait for the initial setup
``` bash
ping nixos
```

## when you get a reply from ping, the initial setup is done, unplug the power from your raspberry pi
## unplug the sd card from the raspberry and plug it back into your computer

## Mount locally the filesystem and copy your ssh id
``` bash
sudo mount /dev/mmcblk0p2 /mnt
sudo mkdir /mnt/home/nixos/.ssh
cat ~/.ssh/id_rsa.pub | sudo tee /mnt/home/nixos/.ssh/authorized_keys
sudo chown -R 1000:100 /mnt/home/nixos/.ssh
sudo chmod -R go-w /mnt/home/nixos/.ssh
sudo umount /mnt
```

## unplug the sd card from your computer, plug it into the raspberry, plug in the ethernet and the power adpater

## ssh into the rpi4 (default password: nixos)
``` bash 
ssh nixos@nixos
```

