
{ config, lib, pkgs, ... }:

with lib;

let
  
  wallpaperPath =  ../../../../Ressources/Images/Wallpapers/mushishi-animation-1080.gif;
  targetWallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpaper/Wallpaper.gif";
  terminalFileManager = "ranger";
in {

  imports = [
    ../wofi
    ../waybar
    ../dunst
    ../wallpaper
    ../hyprlock
    ../kitty
    
   ];

    hyprland.wallpaper = {
      enable = true;
      from = wallpaperPath;
      target-wallpaper-path = targetWallpaperPath;
    };


    home.packages = with pkgs; [
      waybar
      dunst
      libsForQt5.dolphin
      networkmanagerapplet
      pavucontrol
      blueman
      bluez
      bluetui
      swww
      wl-clipboard
      swaylock-effects
      xdg-desktop-portal-hyprland
      mpd
      mpc-cli
      cava
      lm_sensors
      ranger
      hyprshot
      grimblast
      brightnessctl
      playerctl
      gsimplecal
    ];
    

    # Enable xdg-desktop-portal-hyprland for Wayland support
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    };


    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;


      settings = {
        "$mainMod" = "SUPER";
        #"$mainMod" = "ALT";
        "$term" = "kitty";
        "$editor" = "codium";
        "$fileManager" = "$term --class \"terminalFileManager\" -e ${terminalFileManager}";
        "$browser" = "brave";

        input = {
          kb_layout = "de";
          follow_mouse = "1";
          sensitivity = "0";
          force_no_accel = "1";
          numlock_by_default = "true";
        };

        monitor = "DP-1, preferred, auto, 1";
        #monitor = "DP-1, DP-2, preferred, auto, 1";
        #monitor = ", preferred, auto, 1";
        cursor.no_hardware_cursors = false;

        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 0;
          resize_on_border = false;
          layout = "dwindle";
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          shadow.enabled = false;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        plugin = {
          imgborders = {
            enabled = true;
            image = "~/.config/fall25/border.png";
            sizes = "3,3,3,3";
            insets = "0,0,0,0";
            scale = 1;
            smooth = false;
            blur = false;
          };
          hyprbars = {
            bar_height = 24;
            bar_color = "rgb(4b6983)";
            bar_text_font = "Terminus";
            bar_text_align = "left";
            on_double_click = "hyprctl dispatch fullscreen 1";
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master.new_status = "master";
        bindm = [
          "$mainMod, mouse:272, movewindow"   # Left-click to move window
          "$mainMod, mouse:273, resizewindow" # Right-click to resize window
        ];

        windowrulev2 = [
          "float, class:^(gnome-calendar)$"
          "center, class:^(gnome-calendar)$"
          "size 600 400, class:^(gnome-calendar)$"
        ];

        bind = [
          "$mainMod, Return, exec, kitty"
          "$mainMod, Q, killactive"
          "$mainMod, F, fullscreen"
          "$mainMod, J, togglesplit"
          "$mainMod, C, exec, hyprctl reload"
          "$mainMod SHIFT, M, exit"
          "$mainMod, L, exec, hyprlock"

          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch windows
          "$mainMod, Tab, cyclenext"
          "$mainMod, Tab, bringactivetotop"

          # Application launcher
          "ALT, space, exec, wofi --show drun"

          # Workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Media keys (no modifier)
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"

          # Brightness (no modifier)
          ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

          # Screenshots
          "$mainMod, Print, exec, grimblast copysave screen ~/Pictures/Screenshots/screenshot.png"
          "$mainMod SHIFT, Print, exec, grimblast copysave area ~/Pictures/Screenshots/screenshot.png"
          "$mainMod SHIFT, S, exec, hyprshot --mode region --output-folder /tmp"

          # File manager
          "$mainMod, E, exec, dolphin"

          # Toggle floating
          "$mainMod SHIFT, SPACE, togglefloating"
        ];

        exec-once = [
          "waybar"
          "dunst"
          "swww-daemon"
          "swww img \"${targetWallpaperPath}\""
          #"nm-applet"
          #"blueman-applet"
          
        ];
      };
  };
}
