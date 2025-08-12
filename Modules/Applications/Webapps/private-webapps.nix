{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.webapps;
  browser = "${pkgs.chromium}/bin/chromium";
in {
  config = mkIf cfg.enable {
    xdg.desktopEntries = mkMerge [
      (mkIf cfg.whatsapp.enable {
        whatsapp = {
          name = "WhatsApp";
          exec = "${browser} --app=https://web.whatsapp.com/";
          icon = "WhatsApp";
          type = "Application";
        };
      })

    ];
  };
}
