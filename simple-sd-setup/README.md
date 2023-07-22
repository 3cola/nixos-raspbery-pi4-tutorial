# simple-sd-card-setup
The goal is to have a permanent nixos system installed on the sdcard of a raspberry pi 4.

## Start with the [initial-setup](../initial-setup)

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

