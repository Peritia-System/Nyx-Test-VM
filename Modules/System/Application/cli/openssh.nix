{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.openssh.enable = mkEnableOption "Enable the OpenSSH daemon";

  config = mkIf config.openssh.enable {
    services.openssh.enable = true;
  };
}
