# Import all modules so configuration.nix only needs to import this file
{ config, pkgs, lib, inputs, username, ... }: {
  imports = [

    ################
    # 🧰 CLI Tools  #
    ################
    ./Application/cli/docker.nix
    ./Application/cli/openssh.nix
    ./Application/cli/vm.nix
    ./Application/cli/zsh.nix

    ####################
    # 🎮 Gaming & Apps #
    ####################
    ./Application/Gaming/Steam

    #######################
    # 🧪 Special Software #
    #######################
    ./Application/Special-Applications/flatpak.nix
    ./Application/Special-Applications/wireshark.nix

    ##############
    # ⚙️ Defaults #
    ##############
    ./common.nix
  ];
}
