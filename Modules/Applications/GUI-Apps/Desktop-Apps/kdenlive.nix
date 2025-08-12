{
  config,
  pkgs,
  lib,
  ...
}:


with lib; {
  options.kdenlive.enable = mkEnableOption "Enable kdenlive";
  config = mkIf config.kdenlive.enable {
    home.packages = with pkgs; [
      kdePackages.kdenlive

    ];

  };
}



