# all-grub.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    #####################
    # GRUB Theme Modules
    #####################

    ./minegrub.nix
  ];
}
