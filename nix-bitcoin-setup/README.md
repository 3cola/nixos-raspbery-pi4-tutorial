## first you need to complete [simple-ssd-ext4-setup-23-05](../simple-ssd-ext4-setup-23-05)

## install nix-bitcoin as a nix-channel
``` bash
sudo nix-channel --add https://github.com/fort-nix/nix-bitcoin/archive/v0.0.85.tar.gz nix-bitcoin
sudo nix-channel --update
```

## add [nix-bitcoin.nix](./nix-bitcoin.nix) as an import to your configuration.nix
``` nix
#...
 imports =
	    [
        #...
        ./nix-bitcoin.nix
        #...
        ];
#...
```

## rebuild
``` bash
sudo nixos-rebuild switch
```
