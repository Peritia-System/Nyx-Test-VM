{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.kde;
in {
  options.kde.enable = mkEnableOption "Enable KDE Desktop Environment";

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };

    # Enable the KDE Bluetooth frontend
    environment.systemPackages = with pkgs; [
      kdePackages.bluedevil
    ];

  };
}
