{ config, lib, pkgs, ... }:

let
  # 🎨 Colour Palette
  catppuccin = config.colourpalette.catppuccin-mocha;
in {
  imports = [
    # Catppuccin color palette definition module
    ../../../Ressources/Themes/Colourpalettes/catpuccin.nix
  ];

  # ✨ Enable Stylix
  stylix = {
    enable = true;


    # 🔤 Fonts
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts._0xproto;
        name = "0xProto Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.vistafonts;
        name = "Tahoma";
      };
      serif = {
        package = pkgs.vistafonts;
        name = "Times New Roman";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 9;
        popups = 10;
      };
    };

    # 🖱 Cursor
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    # 🎨 Base16 Color Scheme (Catppuccin Mocha)
    base16Scheme = {
      base00 = catppuccin.crust;
      base01 = catppuccin.mantle;
      base02 = catppuccin.base;
      base03 = catppuccin.surface0;
      base04 = catppuccin.surface1;
      base05 = catppuccin.text;
      base06 = catppuccin.subtext0;
      base07 = catppuccin.subtext1;
      base08 = catppuccin.red;
      base09 = catppuccin.peach;
      base0A = catppuccin.yellow;
      base0B = catppuccin.green;
      base0C = catppuccin.teal;
      base0D = catppuccin.blue;
      base0E = catppuccin.mauve;
      base0F = catppuccin.flamingo;
    };

    # 🌫 Opacity Levels
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };

    # 🖼 Image
    #image = ../../../../Ressources/Images/Wallpapers/mushishi-1080.png;

    # 🌓 Theme Polarity
    polarity = "dark";

    # 🚫 Disable Hyprlock theming if managed separately
    targets.hyprlock.enable = false;
    
  };
}
