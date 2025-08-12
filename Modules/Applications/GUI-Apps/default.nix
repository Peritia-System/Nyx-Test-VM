# Import all modules so home.nix only needs to import this file
{ config, pkgs, lib, inputs, ... }: {
  imports = [

    ################
    # 🖥️ Desktop Apps #
    ################
    ./Desktop-Apps/krita.nix
    ./Desktop-Apps/obsidian.nix
    ./Desktop-Apps/office-apps.nix
    ./Desktop-Apps/signal-desktop.nix
    ./Desktop-Apps/spotify.nix
    ./Desktop-Apps/standard-apps.nix
    ./Desktop-Apps/vesktop.nix
    ./Desktop-Apps/zoom.nix
    ./Desktop-Apps/kdenlive.nix
    ./Desktop-Apps/vscodium.nix
    ./Desktop-Apps/printer-scan.nix
    ./Desktop-Apps/rustdesk.nix

    #############
    # 🌐 Browser #
    #############
    ./Browser/brave/brave.nix

    ############
    # 🎮 Gaming #
    ############
    ./Gaming/prismlauncher.nix
    ./Gaming/classic-game-collection.nix

    ###########
    # 🔐 VPNs #
    ###########
    ./VPN/protonvpn.nix
  ];
}
