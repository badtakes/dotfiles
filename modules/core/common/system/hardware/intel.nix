{config, ...}: {
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  services.thermald.enable = true;
}
