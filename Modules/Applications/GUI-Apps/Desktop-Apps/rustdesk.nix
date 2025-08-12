{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.rustdesk.enable = mkEnableOption "Enable Spotify installation";

  config = mkIf config.rustdesk.enable {
   
    home.packages = with pkgs; [
      rustdesk

    ];

  };
}
