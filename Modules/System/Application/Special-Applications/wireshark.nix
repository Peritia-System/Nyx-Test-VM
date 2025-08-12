{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; {
  options = {
    wireshark.enable = mkEnableOption "Enable Wireshark support";

    wireshark.userForWSGroup = mkOption {
      type = types.str;
      default = username;
      description = "User to be added to the 'wireshark' group for dumpcap access.";
    };
  };

  config = mkIf config.wireshark.enable {
    environment.systemPackages = [pkgs.wireshark];

    programs.wireshark.enable = true;
    programs.wireshark.dumpcap.enable = true;

    users.users.${config.wireshark.userForWSGroup}.extraGroups = ["wireshark"];
  };
}
