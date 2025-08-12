{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.grub-theme = {
    enable = mkEnableOption "Enable grub theme generally";
    minegrub-default.enable = mkEnableOption "Enable minegrub default theme";
    minegrub-world-sel-theme.enable = mkEnableOption "Enable minegrub world selection theme";
  };

  config = mkIf config.grub-theme.enable {
    boot.loader.grub = {
      minegrub-theme = mkIf config.grub-theme.minegrub-default.enable {
        enable = true;
        splash = "100% Flakes!";
        background = "background_options/1.8  - [Classic Minecraft].png";
        boot-options-count = 4;
      };

      minegrub-world-sel = mkIf config.grub-theme.minegrub-world-sel-theme.enable {
        enable = true;
        customIcons = [
          {
            name = "nixos";
            lineTop = "NixOS (23/11/2023, 23:03)";
            lineBottom = "Survival Mode, No Cheats, Version: 23.11";
            imgName = "nixos";
            # Optional: add this if you have a local image
            # customImg = builtins.path {
            #   path = ./nixos-logo.png;
            #   name = "nixos-img";
            # };
          }
        ];
      };
    };
  };
}
