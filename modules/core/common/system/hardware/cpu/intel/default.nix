{
  config,
  pkgs,
  ...
}: {
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = ["i915.fastboot=1" "enable_gvt=1"];
  };

  environment.systemPackages = [pkgs.intel-gpu-tools];
}
