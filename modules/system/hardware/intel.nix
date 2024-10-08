{config, ...}: {
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  powerManagement.cpuFreqGovernor = "performance";

  services.thermald.enable = true;
}
