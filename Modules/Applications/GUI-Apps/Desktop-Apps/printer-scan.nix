{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.printer-scan.enable = mkEnableOption "Enable Spotify installation";

  config = mkIf config.printer-scan.enable {
   
    home.packages = with pkgs; [
      simple-scan

    ];

  };
}
