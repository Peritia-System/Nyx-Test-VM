{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.flatpak.enable = mkEnableOption "Enable Flatpak";

  config = mkIf config.flatpak.enable {
    environment.systemPackages = [pkgs.flatpak];

    services.flatpak.enable = true;
    xdg.portal.enable = true; 
    
  };
}
