{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.zsh.enable = mkEnableOption "Enable Zsh system shell with oh-my-zsh";

  config = mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "xiong-chiamiov-plus";
        plugins = ["git"];
      };
    };

    environment.shells = with pkgs; [zsh];
  };
}
