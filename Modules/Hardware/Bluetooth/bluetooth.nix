{
  lib,
  config,
  pkgs,
  ...
}:

{
  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


  # Enable firmware (Intel AX200 needs firmware files from linux-firmware)
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  
  
}