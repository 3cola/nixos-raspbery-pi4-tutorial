{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    tmp.useTmpfs = true;
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
        "8250.nr_uarts=1"
        "console=ttyAMA0,115200"
        "console=tty1"
        # Some gui programs need this
        "cma=128M"
    ];
  };

  boot.loader.raspberryPi = {
    enable = true;
    version = 4;
    firmwareConfig = "dtparam=sd_poll_once=on";
  };
  boot.loader.grub.enable = false;

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  networking.hostName = "nixos-raspi-4"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    vim
    tmux
  ];

  services.openssh.enable = true;

  users = {
    defaultUserShell = pkgs.bash;
    mutableUsers = false;
    users.root = {
      password = "nixos";
    };
    users.nixos = {
      isNormalUser = true;
      password = "nixos";
      extraGroups = [ "wheel" ]; # Enable _sudo_ for the user.
    };
  };

  environment.variables = {
    EDITOR = "vim";
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "23.05";
}
