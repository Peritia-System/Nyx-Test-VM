{
  config,
  pkgs,
  lib,
  username,
  ...
}:
with lib; {
  options.vm.enable = mkEnableOption "Enable virtual machine tools and services (libvirt, virt-manager, etc.)";

  config = mkIf config.vm.enable {
    # Install virtualization tools
    environment.systemPackages = with pkgs; [
      virt-manager
      spice-gtk
      dnsmasq
      bridge-utils
    ];

    # Enable libvirt and QEMU support
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
      };
    };

    # Add user to virtualization groups
    users.users.${username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];

    # Enable kernel modules for virtualization
    boot.kernelModules = ["kvm" "kvm_intel" "kvm_amd"];

    # GUI tool support
    programs.virt-manager.enable = true;
  };
}
