{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.hyprland.wallpaper;
in {
  options.hyprland.wallpaper = {
    enable = mkEnableOption "Enable animated wallpaper using swww";

    from = mkOption {
      type = types.path;
      description = "Source path to the wallpaper file (e.g., ./Wallpaper.gif)";
    };

    target-wallpaper-path = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/Pictures/Wallpaper/Wallpaper.gif";
      description = "Final destination path of the wallpaper in the home directory";
    };
  };

  config = mkIf cfg.enable {
    # Install the wallpaper to the desired location
    home.file."${cfg.target-wallpaper-path}".source = cfg.from;

    # swww daemon service
    systemd.user.services.swww-daemon = {
      Unit = {
        Description = "swww wallpaper daemon";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # swww wallpaper setter
    systemd.user.services.swww-wallpaper = {
      Unit = {
        Description = "Set wallpaper using swww";
        After = [ "swww-daemon.service" ];
        Requires = [ "swww-daemon.service" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.swww}/bin/swww img "${cfg.target-wallpaper-path}" --transition-type any
        '';
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
