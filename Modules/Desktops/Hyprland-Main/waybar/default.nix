{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    systemd = {
      enable = false;
      target = "graphical-session.target";
    };

    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
          "temperature"
          "mpd"
          "custom/cava-internal"
        ];

        modules-center = [
          "custom/applauncher"
        ];

        modules-right = [
          "network"
          "battery"
          "custom/bluetooth"
          "pulseaudio"
          "tray"
          "clock"
        ];

        # Workspace module
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          tooltip = false;
        };

        # App launcher
        "custom/applauncher" = {
          format = "〇";
          on-click = "pgrep wofi >/dev/null && killall wofi || wofi --show drun --location=top -y 15";
          tooltip = false;
        };

        # System tray
        tray = {
          spacing = 10;
          tooltip = false;
        };

        # Clock with calendar and actions
        clock = {
          format = "{:%H:%M} ";
          format-alt = "{:%A, %B %d, %Y (%R)} ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          on-click = "gsimplecal";  # ← launches calendar app on click
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };


        # Network
        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰤮 No Network";
          tooltip-format-wifi = ''
             Wi-Fi Connected
            ↓ {bandwidthDownBits}
            ↑ {bandwidthUpBits}
            Signal: {signalStrength}%
          '';
          tooltip-format-ethernet = ''
            󰈀 Ethernet Connected
            ↓ {bandwidthDownBits}
            ↑ {bandwidthUpBits}
          '';
          tooltip-format-disconnected = ''
            󰤮 Disconnected
            No network connection
          '';
          interval = 5;

          on-click = "$TERMINAL -e nmtui";
        };

        "custom/bluetooth" = {
          format = "";          # Bluetooth icon (Font Awesome or Nerd Font)
          tooltip = true;        # Enable tooltip
          tooltip-format = ''
            Bluetooth: {status}  # Tooltip text showing Bluetooth status
          '';
          interval = 10;         # Update every 10 seconds
          return-type = "plain"; # Return plain text (no markup)
          on-click = "$TERMINAL -e bluetui";  # Open bluetui on click
        };



        # Audio
        pulseaudio = {
          scroll-step = 5;
          max-volume = 150;
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "";
          format-icons = [ "" "" "" ];
          nospacing = 1;
          on-click = "pavucontrol";
          tooltip = false;
        };

        # Battery
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-alt = "{icon} {time}";
          format-full = "󱈑 {capacity}%";
          format-icons = [ "󱊡" "󱊢" "󱊣" ];
        };
      }
    ];
  };
}
