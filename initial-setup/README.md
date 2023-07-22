
## Download nixos for raspery pi 4
``` bash
wget "https://hydra.nixos.org/build/157521526/download/1/nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst"
```

## Uncompress it
``` bash
unzstd -d nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img.zst
```
## Write the image to an sdcard
``` bash
sudo dd if=nixos-sd-image-22.11pre428574.20fc948445a-aarch64-linux.img of=/dev/mmcblk0 bs=4096 conv=fsync status=progress  
```

## plug the sdcard into your raspberry pi, plug an ethernet cable to tyour local network, plugin the electricity

## ssh into the rpi4 (default password: nixos)
``` bash 
ssh nixos@nixos
```

## edit the configuration.nix (see [configuration.nix](./configuration.nix) for an example initial configuration)
``` bash
sudo vi /etc/nixos/configuration.nix
```

## install the new version
``` bash
sudo nixos-install --root /
```

## restart
``` bash
sudo reboot now
```

## connect to it via ssh
## done.

