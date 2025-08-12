{
  config,
  pkgs,
  lib,
  username,
  ...
}:
with lib; {
  options.docker = {
    enable = mkEnableOption "Enable Docker support (including CLI and service)";
    rootless = mkEnableOption "Enable rootless Docker for the user";
    podman = mkEnableOption "Enable Podman as an alternative container runtime";
  };

  config = mkMerge [
    # 🐳 Standard Docker (daemon + CLI)
    (mkIf config.docker.enable {
      virtualisation.docker.enable = true;
      virtualisation.docker.enableOnBoot = true;

      users.users.${username}.extraGroups = ["docker"];

      environment.systemPackages = with pkgs; [
        docker
        docker-compose
      ];

      # Optional: Docker cgroup v2 support
      boot.kernelParams = ["cgroup_enable=memory" "cgroup_memory=1"];
    })

    # 👤 Rootless Docker mode
    (mkIf config.docker.rootless {
      virtualisation.docker.rootless.enable = true;

      environment.systemPackages = with pkgs; [
        docker
        docker-compose
      ];
    })

    # 🧪 Podman support
    (mkIf config.docker.podman {
      virtualisation.podman.enable = true;

      environment.systemPackages = with pkgs; [
        podman
        podman-compose
      ];

      # Optional: enable Podman socket activation
      services.dbus.packages = [pkgs.podman];

      # Podman group for user
      users.users.${username}.extraGroups = ["podman"];
    })
  ];
}
