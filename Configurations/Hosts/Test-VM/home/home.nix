{
  config,
  nixDirectory,
  pkgs,
  inputs,
  ...
}: 
let

  # Import user-specific variables
  userVars = import ../variables/user-vars.nix;
  inherit (userVars) username gitUsername gitEmail;

in {
  ################################################################
  # Basic Home Manager Setup
  ################################################################

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  ################################################################
  # Module Imports
  ################################################################



  imports = [
    # All Home Manager Modules
    ../../../../Modules/Applications

     # Desktop applications
    ./desktop.nix

    # Extended Retro theme
#    ../../../../Modules/Desktops/XFCE-retro

#    inputs.nyx.homeManagerModules.default
 
  ];

  ################################################################
  # Feature Modules
  ################################################################

  # App groups
  standardApps.enable = true;
  officeApps.enable = true;

  # Individual GUI apps
  brave-and-extension.enable = true;
  vscodium-and-extension.enable = true;
  vesktop.enable = true;
  krita.enable = true;
  signal.enable = true;
  zoom.enable = true;
  kdenlive.enable = true;
  classic-game-collection.enable = true;
  spotify.enable = true;
  obsidian.enable = true;
  protonvpn.enable = true;
  printer-scan.enable = true;
#  rustdesk.enable = true;


  # Gaming
  prismlauncher.enable = true;

  # CLI tools
  cliTools.enable = true;

  # Web apps (disabled)
  webapps = {
    enable = false;
    slack.enable = false;
    teams.enable = false;
    outlook.enable = false;
    entra.enable = false;
  };





  ################################################################
  # Package Selection
  ################################################################

  home.packages = import ./user-packages.nix {
    inherit pkgs;
  };


  ################################################################
  # Git Configuration
  ################################################################

  programs.git = {
    enable = true;
    userName = gitUsername;
    userEmail = gitEmail;

    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
    };
  };
}



  

