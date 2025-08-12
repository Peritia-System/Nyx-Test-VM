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
      (mkIf cfg.slack.enable {
        slack = {
          name = "Slack";
          exec = "${browser} --app=https://app.slack.com/client";
          icon = "slack";
          type = "Application";
        };
      })

      (mkIf cfg.teams.enable {
        teams = {
          name = "Microsoft Teams";
          exec = "${browser} --app=https://teams.microsoft.com";
          icon = "teams";
          type = "Application";
        };
      })

      (mkIf cfg.outlook.enable {
        outlook = {
          name = "Outlook Web";
          exec = "${browser} --user-data-dir=/home/${config.home.username}/.local/share/ice/profiles/Outlook4305 --profile-directory=Default --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo";
          icon = "outlook";
          type = "Application";
        };
      })

      (mkIf cfg.entra.enable {
        entra = {
          name = "Microsoft Entra";
          exec = "${browser} --app=https://entra.microsoft.com";
          icon = "microsoft";
          type = "Application";
        };
      })
    ];
  };
}
