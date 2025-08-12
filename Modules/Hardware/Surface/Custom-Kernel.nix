# Base kernel modules for Surface Pro (Kaby Lake / i5-7300U)

# ETA 4h 30min
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    #(import "${inputs.nixos-hardware}/microsoft/surface/common")
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
  ];

  boot.kernelModules = ["hid-microsoft"];

  boot.initrd.kernelModules = [
    # Surface Aggregator Module (SAM) - essential for buttons, sensors, keyboard
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid_core"
    "surface_hid"

    # Intel Low Power Subsystem (keyboard, I2C, etc.)
    "intel_lpss"
    "intel_lpss_pci"
    "8250_dw"
  ];

  # You do NOT need IPTSd — touchscreen/pen should work via HID
  services.iptsd.enable = lib.mkForce false;

  # Optional: reduce flickering on some panels
  # boot.kernelParams = [ "i915.enable_psr=0" ];

  # Optional: if specific modules cause problems
  # boot.blacklistedKernelModules = [ "surface_gpe" ];


  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
  # Enable thermald for thermal management
 # services.thermald = {
 #   enable = true;
 #   extraOptions = [
 #     "--adaptive" # Optional: try to adapt to changing workloads
 #     "--max-temperature=65" # Set the desired thermal limit (°C)
 #   ];
 # };
  # Optional: ensure CPU governor isn't limiting performance too much
  #powerManagement.cpuFreqGovernor = "powersave"; # or "ondemand", "performance", depending on needs

  # Optional: disable turbo if still overheating
  # systemd.tmpfiles.rules = [
  #   "w /sys/devices/system/cpu/intel_pstate/no_turbo - - - - 1"
  # ];
}
