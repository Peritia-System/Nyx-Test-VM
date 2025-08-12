{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.classic-game-collection;
in {
  options.classic-game-collection.enable = mkEnableOption "Enable ace-of-penguins";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kpat
      kdePackages.ksudoku
      space-cadet-pinball
      kdePackages.palapeli
      kdePackages.kmines
      kdePackages.kblocks
      kdePackages.libkmahjongg
    ];
  };
}
