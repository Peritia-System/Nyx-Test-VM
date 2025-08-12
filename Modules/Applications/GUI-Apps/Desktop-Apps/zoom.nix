{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.zoom.enable = mkEnableOption "Enable Spotify installation";

  config = mkIf config.zoom.enable {
   #programs.zoom-us.enable = true;
    home.packages = with pkgs; [
      zoom-us
    ];

  };
}
