# We use nix-bitcoin as a nix-channel.
# This file is an hybrid between 
# <nix-bitcoin/examples/importable-configuration.nix>
# and 
# <nix-bitcoin/modules/preset/secure-node.nix>

{ config, pkgs, lib, ... }:
with lib;
let 
  cfg = config.services;
  nbLib = config.nix-bitcoin.lib;
  operatorName = config.nix-bitcoin.operator.name;
in  
{
  imports = [
    <nix-bitcoin/modules/modules.nix>
    <nix-bitcoin/modules/presets/enable-tor.nix>
  ];

  options = {
    # Used by ../versioning.nix
    nix-bitcoin.secure-node-preset-enabled = {};
  };

  config = {
    nix-bitcoin.security.dbusHideProcessInformation = true;

    # Add a SSH onion service
    services.tor.relay.onionServices.sshd = nbLib.mkOnionService { port = 22; };
    nix-bitcoin.onionAddresses.access.${operatorName} = [ "sshd" ];

    # bitcoind
    nix-bitcoin.onionServices.bitcoind.public = true;
    services.bitcoind = {
      enable = true;
      listen = true;
      dbCache = 450;
      txindex = true;
      addnodes = [ ];
      extraConfig = ''
        maxmempool=300
        mempoolfullrbf=1
      '';
      i2p = false;
    };

    # fulcrum (seems to consume a lot of ressources and to not work so well...)
    services.fulcrum.enable = false;

    # electrs
    services.electrs.enable = true;

    # liquidd
    services.liquidd = {
      enable = false;
      # Enable `validatepegin` to verify that a transaction sending BTC into
      # Liquid exists on Bitcoin. Without it, a malicious liquid federation can
      # make the node accept a sidechain that is not fully backed.
      validatepegin = true;
      listen = true;
    };

    # extra services
    nix-bitcoin.nodeinfo.enable = true;
    services.backups = {
      enable = true;
      frequency = "daily";
    };
    
    # Automatically generate all secrets required by services.
    # The secrets are stored in /etc/nix-bitcoin-secrets
    nix-bitcoin.generateSecrets = true;

    # Enable interactive access to nix-bitcoin features (like bitcoin-cli) for
    # your system's main user
    nix-bitcoin.operator = {
      enable = true;
      name = "nixos";
    };
  };
} 
