{
  config,
  lib,
  ...
}: {
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  services.thermald.enable = true;
}
