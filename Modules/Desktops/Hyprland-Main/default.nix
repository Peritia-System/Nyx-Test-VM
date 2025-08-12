# Import all modules so configuration.nix only needs to Import all.nix
{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  imports = [

    ./hyprland

    ./stylix.nix


  ];
}
