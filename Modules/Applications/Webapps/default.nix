# module/Home/webapps/webapps.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./private-webapps.nix
    ./work-webapps.nix
  ];

  options.webapps = {
    enable = lib.mkEnableOption "Enable custom web app launchers";

    teams.enable = lib.mkEnableOption "Enable Microsoft Teams web app";
    outlook.enable = lib.mkEnableOption "Enable Outlook web app";
    entra.enable = lib.mkEnableOption "Enable Entra admin web app";
    slack.enable = lib.mkEnableOption "Enable Slack web app";
  };

  config = {};
}
